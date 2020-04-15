//
//  CalcButtonView.swift
//  Calculator
//
//  Created by Brandon Potts on 4/11/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct CalcButtonView: View {
    
    var calcButton: CalcButton
    var highlightAble: Bool
    var width: CGFloat?
    @State var buttonForeground: Color = Color.white
    @State var buttonBackGround: Color?
    @State private var highlighted: Bool = false
    
    @EnvironmentObject var numObservable: NumObservable
    
    init(newCalcButton: CalcButton){
        let orangeButtons: [String] = ["/", "x", "-", "+", "="]
        
        self.highlightAble = false
        self.calcButton = newCalcButton
        self.highlighted = false
        self.width = (newCalcButton.label == "0" ? 200 : 100)
        if orangeButtons.contains(self.calcButton.label){
            self.highlightAble = true
        }
        
    }
    
    var body: some View {
        Button(action: {
            self.numObservable.updateOrOperationDelegate(buttonLabel: self.calcButton.label)
            self.toggleHighLight()
        }, label:{
            Text(calcButton.label)
                .frame(width: self.width, height: 100)
                .background(self.buttonBackGround)
                .foregroundColor(self.buttonForeground)
                .cornerRadius(75)
        }).onAppear {
            /// Buttons that are light gray
            let lightGrayButtons: [String] = ["C", "+/-", "%"]
            /// Buttons that are orange
            let orangeButtons: [String] = ["/", "x", "-", "+", "="]
            if lightGrayButtons.contains(self.calcButton.label){
                self.buttonBackGround = Color.lightGray
            } else if orangeButtons.contains(self.calcButton.label){
                self.buttonBackGround = Color.orange
            } else {
                self.buttonBackGround = Color.darkGray
            }
        }
    }
    
    func toggleHighLight() -> Void {
        
        if highlightAble {
            // Will be true when the button is already highlighted
            if highlighted {
                self.buttonForeground = Color.white
                self.buttonBackGround = Color.orange
                highlighted = false
            } else {
                self.buttonForeground = Color.orange
                self.buttonBackGround = Color.white
                highlighted = true
            }
        }
    }
}

struct CalcButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalcButtonView(newCalcButton: CalcButton(label: "+"))
    }
}
