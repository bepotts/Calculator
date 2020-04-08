//
//  CalcButton.swift
//  Calculator
//
//  Created by Brandon Potts on 4/6/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import Foundation
import SwiftUI

class CalcButton {
    var label: String?
    var color: Color?
    var action: ()?
    
    init(label: String, color: Color = Color.orange, action: ()?) {
        self.label = label
        self.color = color
        self.action = action
    }
}
