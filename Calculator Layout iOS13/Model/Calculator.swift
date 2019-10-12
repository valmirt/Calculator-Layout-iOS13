//
//  Calculator.swift
//  Calculator Layout iOS13
//
//  Created by Valmir Torres on 12/10/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

class Calculator {
    var operatorOne = ""
    var operatorTwo = ""
    var operation = ""
    
    func result() -> String {
        switch operation {
        case "+":
            if someoneIsDouble() {
                let opOne = Double(operatorOne)
                let opTwo = Double(operatorTwo)
                return String(opOne! + opTwo!)
            } else {
                let opOne = Int(operatorOne)
                let opTwo = Int(operatorTwo)
                return String(opOne! + opTwo!)
            }
        default:
            return ""
        }
    }
    
    func clear() {
        operatorOne = ""
        operatorTwo = ""
        operation = ""
    }
    
    private func someoneIsDouble() -> Bool {
        return operatorOne.contains(".") || operatorTwo.contains(".")
    }
}
