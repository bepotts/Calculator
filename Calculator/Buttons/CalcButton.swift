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
    
    public let id = UUID()
    public var label: String
    public var color: Color
    var action: ()?
    
    init(label: String, color: Color = Color.darkGray, action: ()? = nil) {
        self.label = label
        self.color = color
        self.action = action
    }
    
    static func == (lhs: CalcButton, rhs: CalcButton) -> Bool {
        return lhs.label == rhs.label && lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(color)
    }
}
