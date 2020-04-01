//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

let buttons: [[String]] = [
    ["C", "+/-", "%", "X"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0", ".", "="],
]

var currentPlace: Int = 0


enum Operation {
    case add
    case subtract
    case divide
    case multiply
    case percent
    case clear
    case changeSign
    case equals
}

class SolutionObservable: ObservableObject {
    @Published var finalSolution:Int = 0
    @Published var currentVal: Int = 0
}

struct HomeView: View {
    
    @EnvironmentObject var solutionEnv: SolutionObservable
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Spacer()
                    Text(String(solutionEnv.currentVal))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                }
                
                ForEach(buttons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            Button(currentButton, action: {
                                self.testFunc(currentButton: currentButton)
                            })
                                .foregroundColor(Color.white).frame(width: self.generateWidth(button: currentButton), height: 100).background(Color.orange).cornerRadius(75)
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }
    
    func generateWidth(button: String) -> CGFloat {
        if button == "0" {
            return 200
        }
        return 100
    }
    
    func testFunc(currentButton: String) -> Void {
        let errorInt: Int = -1
        let convertedInt: Int = Int(currentButton) ?? errorInt
        
        if convertedInt == errorInt {
            self.operationDelegate(op: currentButton)
        } else {
            self.updateValue(val: convertedInt)
        }
    }
    
    func updateValue(val: Int) -> Void {
        if currentPlace == 0 {
            solutionEnv.currentVal = val
            currentPlace += 1
        } else {
            solutionEnv.currentVal = solutionEnv.currentVal * 10 + val
        }
    }

    func operationDelegate(op: String) -> Void {
        print("Inside the operation delgate function")
            
        switch op {
        case "+":
            addOp()
        case "-":
            subOp()
        case "/":
            divOp()
        case "*":
            multiplyOp()
        case "%":
            percentOp()
        case "C":
            clearOp()
        case "+/-":
            changeSignOp()
        case "=":
            equalsOp()
        default:
            print("There was an error in the operation Delegate function")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SolutionObservable())
    }
}

func addOp() -> Void {
    print("Add operation")
}

func subOp() -> Void {
    print("Subtract operation")
}

func divOp() -> Void {
    print("Divide operation")
}

func multiplyOp() -> Void {
    print("Multiply Operation")
}

func percentOp() -> Void {
    print("percent operation")
}

func clearOp() -> Void {
    print("Clear operation")
}

func equalsOp() -> Void {
    print("Equals operation")
}

func changeSignOp() -> Void {
    print("Change sign operation")
}

func flipSign() -> Void {
    print("Flip Sign operation")
}


