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
    let highlightAble: Bool
    @State var foregroundColor: Color = Color.white
    @State var backgroundColor: Color
    @State private var highlighted: Bool = false
    
    @EnvironmentObject var numObservable: NumObservable
    
    var body: some View {
        Button(action: {
            self.numObservable.updateOrOperationDelegate(buttonLabel: self.calcButton.label)
            self.toggleHighLight()
        }, label:{
            Text(calcButton.label)
                .background(self.backgroundColor)
                .foregroundColor(self.foregroundColor)
                .cornerRadius(75)
        })
    }
    
    func toggleHighLight() -> Void {
        
        if highlightAble {
            // Will be true when the button is already highlighted
            if highlighted {
                self.foregroundColor = Color.white
                self.backgroundColor = Color.orange
                highlighted = false
            } else {
                self.foregroundColor = Color.orange
                self.backgroundColor = Color.white
                highlighted = true
            }
        }
    }
}

struct CalcButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalcButtonView(calcButton: CalcButton(label: "+"), highlightAble: true, backgroundColor: Color.orange)
    }
}
