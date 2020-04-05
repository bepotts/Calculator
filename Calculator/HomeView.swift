//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

let buttons: [[String]] = [
    ["C", "+/-", "%", "/"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0", ".", "="],
]

var numStartFromBegining: Bool = true
var previousOp: String = ""
var equalsBefore: Bool = false
var previousButton: String = ""

// Sets up the color groupings
let lightGrayButtons: [String] = ["C", "+/-", "%"]
let orangeButtons: [String] = ["/", "x", "-", "+", "="]

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
    @Published var finalSolution: Double = Double(Int.min)
    @Published var currentVal: Double = 0
    
    func reset() -> Void {
        finalSolution = Double(Int.min)
        currentVal = 0
    }
}

// Adds the button colors from the Calculator app
extension Color {
    static let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}

extension Double {
    func truncate(maxDigits: Int = 2)-> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: self as NSNumber) ?? "error"
    }
}

enum InputError: Error {
    case invalidInput(String)
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
                    Text(solutionEnv.currentVal.truncate(maxDigits: 8))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                }
                
                ForEach(buttons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            Button(action: {
                                self.testFunc(currentButton: currentButton)
                            }, label: {
                                Text(currentButton)
                                    .foregroundColor(Color.white)
                                    .frame(width: self.generateWidth(button: currentButton), height: 100)
                                    .background(self.colorSelector(currentButton: currentButton)).cornerRadius(75)
                            })
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }
    
    func colorSelector(currentButton: String) -> Color{
        if lightGrayButtons.contains(currentButton){
            return Color.lightGray
        }
        if orangeButtons.contains(currentButton){
            return Color.orange
        }
        return Color.darkGray
    }
    
    func generateWidth(button: String) -> CGFloat {
        if button == "0" {
            return 200
        }
        return 100
    }
    
    func testFunc(currentButton: String) -> Void {
        let errorInt: Double = -1
        let convertedInt: Double = Double(currentButton) ?? errorInt
        
        if convertedInt == errorInt {
            // This is to ignore input from user that hit the same button over and over again
            if currentButton == previousButton  && currentButton != "+/-"{
                return
            }
            do {
                try self.operationDelegate(op: currentButton)
            } catch {
                let errorMessage: String = "Operation Delegate recieved an input that it didn't know what to do with"
                fatalError(errorMessage)
            }
        } else {
            self.updateValue(val: convertedInt)
        }
        
        previousButton = currentButton
    }
    
    func updateValue(val: Double) -> Void {
        
        // Will be true when this is the first value the user punched in
        if numStartFromBegining {
            solutionEnv.currentVal = val
            numStartFromBegining = false
        } else {
            solutionEnv.currentVal = solutionEnv.currentVal * 10 + val
        }
    }
    
    func addOp() -> Void {
        solutionEnv.finalSolution += solutionEnv.currentVal
    }
    
    func subOp() -> Void {
        solutionEnv.finalSolution -= solutionEnv.currentVal
    }
    
    func divOp() -> Void {
        solutionEnv.finalSolution /= solutionEnv.currentVal
    }
    
    func multiplyOp() -> Void {
        solutionEnv.finalSolution *= solutionEnv.currentVal
    }
    
    func percentOp() -> Void {
        solutionEnv.currentVal /= 100
    }
    
    func clearOp() -> Void {
        numStartFromBegining = true
        solutionEnv.reset()
        previousOp = ""
    }
    
    func equalsOp() -> Void {
        do {
            try operationDelegate(op: previousOp)
        } catch {
            let errorMessage: String = "Operation Delegate recieved an operation that it didn't know what to do with"
            fatalError(errorMessage)
        }
        print("This is the solution after the operation: \(solutionEnv.finalSolution)")
        solutionEnv.currentVal = solutionEnv.finalSolution
        solutionEnv.finalSolution = Double(Int.min)
        numStartFromBegining = true
        previousOp = "="
        print("Equals operation")
    }
    
    func changeSignOp() -> Void {
        
        if solutionEnv.currentVal > 0 {
            solutionEnv.currentVal = 0 - solutionEnv.currentVal
        } else {
            solutionEnv.currentVal = abs(solutionEnv.currentVal)
        }
    }
    
    func operationDelegate(op: String) throws ->  Void {
        print("Inside the operation delgate function")
        
        if op == "C" {
            self.clearOp()
            return
        }
        
        // Will be true when the user is trying to use the previous solution as the basis for a new equation
        if previousOp == "="  && op != "="{
            solutionEnv.finalSolution = solutionEnv.currentVal
            previousOp = op
            return
            // Will be true if the user has not entered a value and hit an operation
        } else if solutionEnv.finalSolution == Double(Int.min) && solutionEnv.currentVal == 0 {
            return
        }
        
        switch op {
        case "+/-":
            self.changeSignOp()
        case "%":
            print("We are about to run the percent op")
            self.percentOp()
        case "=":
            equalsOp()
        // Default triggers when doing a math operation
        default:
            print("Looks like we're performing a mathematical operation")
            previousOp = op
            numStartFromBegining = true
            // Will be true when the user input the first number in an operation
            if solutionEnv.finalSolution == Double(Int.min) {
                solutionEnv.finalSolution = solutionEnv.currentVal
            } else if op == "+"{
                self.addOp()
            } else if op == "-" {
                self.subOp()
            } else if op == "/" {
                self.divOp()
            } else if op == "x" {
                self.multiplyOp()
            } else {
                throw InputError.invalidInput(op)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SolutionObservable())
    }
}



