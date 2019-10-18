//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel?
    let calculator = Calculator()
    var operationChange = false
    var hasOneEqual = true
    var hasOneOperation = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func digitButton(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            display(element: digit)
        }
        changeAlphaButton(sender)
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if !calculator.operatorOne.isEmpty && hasOneEqual {
            hasOneEqual = false
            trySetOperatorTwo(true)
        }
        changeColorButton(sender)
    }
    
    @IBAction func operationButton(_ sender: UIButton) {
        if let op = sender.currentTitle {
            switch op {
            case "×":
                doIt(operation: "*")
            case "÷":
                doIt(operation: "/")
            default:
                doIt(operation: op)
            }
            changeColorButton(sender)
        }
    }
    
    @IBAction func percentageButton(_ sender: UIButton) {
        if hasOneOperation {
            hasOneOperation = false
            calculator.operation = "%"
            if !calculator.operatorOne.isEmpty {
                if let display = displayLabel {
                    if let text = display.text {
                        calculator.operatorTwo = text
                    }
                }
            } else {
                trySetOperatorOne()
            }
            if !calculator.operatorOne.isEmpty {
                displayResult(false)
                hasOneEqual = false
                operationChange = true
            }
        }
        changeAlphaButton(sender)
    }
    
    @IBAction func signalButton(_ sender: UIButton) {
        let hasOneOp = hasOneOperation
        display(element: "", true)
        if !hasOneOp {
            hasOneOperation = false
        }
        changeAlphaButton(sender)
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        hasOneEqual = true
        calculator.clear()
        clearDisplay()
        changeAlphaButton(sender)
    }
    
    private func changeColorButton(_ sender: UIButton) {
        let colorOne = sender.currentTitleColor
        let colorTwo = sender.backgroundColor
        sender.setTitleColor(colorTwo, for: .normal)
        sender.backgroundColor = colorOne
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15, execute: {
            sender.setTitleColor(colorOne, for: .normal)
            sender.backgroundColor = colorTwo
        })
    }
    
    private func changeAlphaButton(_ sender: UIButton) {
        sender.alpha = 0.6
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15, execute: {
            sender.alpha = 1
        })
    }
    
    private func display(element: String, _ signal: Bool = false) {
        var text = displayLabel?.text
        hasOneOperation = true
        
        if text != nil {
            if signal && !text!.isEmpty {
                text = setSignal(text!)
            } else {
                if !operationChange {
                    text = regularInput(text!, element)
                } else {
                    text = firstInput(element)
                }
            }
        } else {
            text = firstInput(element)
        }
        
        displayLabel?.text = text
    }
    
    private func regularInput(_ field: String, _ element: String) -> String {
        if field.onlyDigits().count < 9 {
            if field.isEmpty && element == "." {
                return "0."
            } else {
                return field + element
            }
        }
        return field
    }
    
    private func firstInput(_ element: String) -> String {
        operationChange = false
        if element == "." {
            return "0."
        } else {
            return element
        }
    }
    
    private func setSignal(_ field: String) -> String {
        if field.contains("-") {
            var positive = field
            positive.removeFirst()
            return positive
        } else {
            return "-\(field)"
        }
    }
    
    private func isDouble() -> Bool {
        if let display = displayLabel {
            if let text = display.text {
                return text.contains(".")
            }
            return false
        }
        return false
    }
    
    private func clearDisplay() {
        displayLabel?.text = ""
    }
    
    private func displayResult(_ equal: Bool) {
        var response = calculator.result()
        response = adjust(response)
        
        if response == "Error" || calculator.operation == "%" {
            hasOneOperation = false
            calculator.clear()
        } else {
            if !equal {
                calculator.operatorOne = response
            } else {
                calculator.clear()
            }
        }
        displayLabel?.text = response
        operationChange = true
    }
    
    private func adjust(_ response: String) -> String {
        if response.count > 10 {
            return String(response.prefix(10))
        }
        if response.isFalseDouble() {
            var resp = response
            resp.removeLast()
            resp.removeLast()
            return resp
        }
        return response
    }
    
    private func trySetOperatorOne() {
        if let display = displayLabel {
            if let text = display.text {
                if !text.isEmpty {
                    calculator.operatorOne = text
                }
            }
        }
    }
    
    private func trySetOperatorTwo(_ equal: Bool) {
        if let display = displayLabel {
            if let text = display.text {
                calculator.operatorTwo = text
                displayResult(equal)
            }
        }
    }
    
    private func doIt (operation: String) {
        if hasOneOperation {
            hasOneOperation = false
            if !calculator.operatorOne.isEmpty {
                trySetOperatorTwo(false)
                calculator.operation = operation
            } else {
                trySetOperatorOne()
                calculator.operation = operation
                operationChange = true
                hasOneEqual = true
            }
        }
    }
}
