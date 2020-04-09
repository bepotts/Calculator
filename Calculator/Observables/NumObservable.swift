//
//  NumObservable.swift
//  Calculator
//
//  Created by Brandon Potts on 4/7/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import Foundation


/// Observable class that encapsulates the values that our math is performed on
class NumObservable: ObservableObject {
    
    @Published var finalSolution: Double = Double(Int.min)
    @Published var displayVal: Double = 0
    
    /// Determines whether the display  value should update at 10^0 or higher
    var numStartFromBegining: Bool = true
    /// Stores the value of the previous operation
    var previousOp: String = ""
    /// Stores the value of the previous pushed button
    var previousButton: String = ""
    
    func reset() -> Void {
        finalSolution = Double(Int.min)
        displayVal = 0
    }
    
    
    /**
     Updates the display text or performs and operation, based on the given text
     - Parameter buttonLabel: label of the pressed button
     - Returns: Void
     */
    func updateOrOperationDelegate(buttonLabel: String) -> Void {
        let errorInt: Double = -1
        let convertedInt: Double = Double(buttonLabel) ?? errorInt
        
        if convertedInt == errorInt {
            // This is to ignore input from user that hit the same button over and over again
            if buttonLabel == self.previousButton  && buttonLabel != "+/-"{
                return
            }
            do {
                try self.operationDelegate(opLabel: buttonLabel)
            } catch {
                let errorMessage: String = "Operation Delegate recieved an input that it didn't know what to do with"
                fatalError(errorMessage)
            }
        } else {
            self.updateDisplayVal(clickedVal: convertedInt)
        }
        
        self.previousButton = buttonLabel
    }
    
    /**
     Updates the number being displayed. Called after a user hits a number button
     - Parameter clickedVal: the value of the button that was just clicked
     - Returns: Void
     */
    func updateDisplayVal(clickedVal: Double) -> Void {
        
        // Will be true when this is the first value the user punched in
        if self.numStartFromBegining {
            self.displayVal = clickedVal
            self.numStartFromBegining = false
        } else {
            self.displayVal = self.displayVal * 10 + clickedVal
        }
    }
    
    /**
     Performs the "addition" operation
     - Returns: Void
     */
    func addOperation() -> Void {
        self.finalSolution += self.displayVal
    }
    
    /**
     Performs the "subtraction" operation
     - Returns: Void
     */
    func subtractOperation() -> Void {
        self.finalSolution -= self.displayVal
    }
    
    /**
     Peforms the "division" operation
     - Returns: Void
     */
    func divideOperation() -> Void {
        self.finalSolution /= self.displayVal
    }
    
    /**
     Performs the "multiplication" operation
     - Returns: Void
     */
    func multiplyOperation() -> Void {
        self.finalSolution *= self.displayVal
    }
    
    /**
     Performs the "percent" operation.
     This changes the displayed value to an equivalent percentage value
     - Returns: Void
     */
    func percentOperation() -> Void {
        self.displayVal /= 100
    }
    
    /**
     Performs the "clear" operation
     - Returns: Void
     */
    func clearOperation() -> Void {
        self.numStartFromBegining = true
        self.reset()
        self.previousOp = ""
    }
    
    /**
     Performs the "equals" operation.
     - Returns: Void
     */
    func equalsOperation() -> Void {
        do {
            try operationDelegate(opLabel: self.previousOp)
        } catch {
            let errorMessage: String = "Operation Delegate recieved an operation that it didn't know what to do with"
            fatalError(errorMessage)
        }
        print("This is the solution after the operation: \(self.finalSolution)")
        self.displayVal = self.finalSolution
        self.finalSolution = Double(Int.min)
        self.numStartFromBegining = true
        self.previousOp = "="
        print("Equals operation")
    }
    
    /**
     Performs the change sign operation on the displayed value
     - Returns: Void
     */
    func changeSignOperation() -> Void {
        
        if self.displayVal > 0 {
            self.displayVal = 0 - self.displayVal
        } else {
            self.displayVal = abs(self.displayVal)
        }
    }
    
    /**
     Accepts an operation label an executes the correspoding operation.
     - Parameter opLabel: label of the operation
     - Returns: Void
     - Throws: InputError.invalidInput
     */
    func operationDelegate(opLabel: String) throws ->  Void {
        print("Inside the operation delgate function")
        
        if opLabel == "C" {
            self.clearOperation()
            return
        }
        
        // Will be true when the user is trying to use the previous solution as the basis for a new equation
        if self.previousOp == "="  && opLabel != "="{
            self.finalSolution = self.displayVal
            self.previousOp = opLabel
            return
            // Will be true if the user has not entered a value and hit an operation
        } else if self.finalSolution == Double(Int.min) && self.displayVal == 0 {
            return
        }
        
        switch opLabel {
        case "+/-":
            self.changeSignOperation()
        case "%":
            print("We are about to run the percent op")
            self.percentOperation()
        case "=":
            equalsOperation()
        // Default triggers when doing a math operation
        default:
            print("Looks like we're performing a mathematical operation")
            self.previousOp = opLabel
            self.numStartFromBegining = true
            // Will be true when the user input the first number in an operation
            if self.finalSolution == Double(Int.min) {
                self.finalSolution = self.displayVal
            } else if opLabel == "+"{
                self.addOperation()
            } else if opLabel == "-" {
                self.subtractOperation()
            } else if opLabel == "/" {
                self.divideOperation()
            } else if opLabel == "x" {
                self.multiplyOperation()
            } else {
                throw InputError.invalidInput(opLabel)
            }
        }
    }
}

