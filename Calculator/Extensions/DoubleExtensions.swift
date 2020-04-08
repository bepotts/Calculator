//
//  Double.swift
//  Calculator
//
//  Created by Brandon Potts on 4/8/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import Foundation
import SwiftUI

extension Double {
    func truncate(maxDigits: Int = 2)-> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: self as NSNumber) ?? "error"
    }
}

