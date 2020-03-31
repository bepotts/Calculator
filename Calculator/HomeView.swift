//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

var currentVal: Int = 0

let buttons: [[String]] = [
    ["C", "+/-", "%", "X"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0", ".", "="],
]


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
                    Text(String(solutionEnv.finalSolution))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                }
                
                ForEach(buttons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            Text(currentButton)
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SolutionObservable())
    }
}

func operationDelegate(op: Operation) -> Void {
    switch op {
    case .add:
        addOp()
    case .subtract:
        subOp()
    case .divide:
        divOp()
    case .multiply:
        multiplyOp()
    case .percent:
        percentOp()
    case .clear:
        clearOp()
    case .changeSign:
        changeSignOp()
    case .equals:
        equalsOp()
    }
}

func addOp() -> Void {
    // TODO
}

func subOp() -> Void {
    // TODO
}

func divOp() -> Void {
    // TODO
}

func multiplyOp() -> Void {
    // TODO
}

func percentOp() -> Void {
    // TODO
}

func clearOp() -> Void {
    // TODO
}

func equalsOp() -> Void {
    // TODO
}

func changeSignOp() -> Void {
    // TODO
}

func flipSign() -> Void {
    // TODO
}


