//
//  CalcButton.swift
//  Calculator
//
//  Created by Brandon Potts on 4/6/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import Foundation
import SwiftUI

/**
 Represents the features of a button calculator
 */
struct CalcButton: Hashable, Identifiable{
    
    let id = UUID()
    let highlightAble: Bool
    let originalBackgroundColor: Color
    var label: String
    var backgroundColor: Color
    var foregroundColor: Color
    var action: ()?
    

    init(label: String, backgroundColor: Color = Color.darkGray, highlightAble: Bool = false, action: ()? = nil) {
        self.label = label
        self.backgroundColor = backgroundColor
        self.highlightAble = highlightAble
        self.originalBackgroundColor = backgroundColor
        self.foregroundColor = Color.white
        self.action = action
    }
    
    static func == (lhs: CalcButton, rhs: CalcButton) -> Bool {
        return lhs.label == rhs.label && lhs.backgroundColor == rhs.backgroundColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(backgroundColor)
    }
    
    mutating func checkForHightlight() -> Void {
        if self.highlightAble {
            // Will be true when the button isn't already highlighted
            if self.backgroundColor == self.originalBackgroundColor {
                self.highlightOn()
            } else {
                self.highlightOff()
            }
        }
    }
    
    mutating func highlightOn() -> Void {
        self.foregroundColor = Color.orange
        self.backgroundColor = Color.white
    }
    
    mutating func highlightOff() -> Void {
        self.backgroundColor = self.originalBackgroundColor
        self.foregroundColor = Color.white
    }
}
