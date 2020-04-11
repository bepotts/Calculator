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
    var label: String
    var action: ()?
    

    init(label: String, action: ()? = nil) {
        self.label = label
        self.action = action
    }
    
    static func == (lhs: CalcButton, rhs: CalcButton) -> Bool {
        return lhs.label == rhs.label && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(id)
    }
    
}
