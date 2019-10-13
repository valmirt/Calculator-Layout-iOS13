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
    
    @IBAction func zeroButton(_ sender: UIButton) {
        display(element: "0")
    }
    
    @IBAction func oneButton(_ sender: UIButton) {
        display(element: "1")
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        display(element: "2")
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        display(element: "3")
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        display(element: "4")
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        display(element: "5")
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        display(element: "6")
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        display(element: "7")
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        display(element: "8")
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        display(element: "9")
        
    }
    
    @IBAction func pointButton(_ sender: UIButton) {
        if !isDouble() {
            display(element: ".")
        }
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        if !calculator.operatorOne.isEmpty && hasOneEqual {
            hasOneEqual = false
            trySetOperatorTwo(true)
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        doIt(operation: "+")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        doIt(operation: "-")
    }
    
    @IBAction func multButton(_ sender: UIButton) {
       doIt(operation: "*")
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
            displayResult(false)
            hasOneEqual = false
            operationChange = true
        }
    }
    
    @IBAction func signalButton(_ sender: UIButton) {
        let hasOneOp = hasOneOperation
        display(element: "", true)
        if !hasOneOp {
            hasOneOperation = false
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        hasOneEqual = true
        calculator.clear()
        clearDisplay()
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        doIt(operation: "/")
    }
    
    
    func display(element: String, _ signal: Bool = false) {
        var text = displayLabel?.text
        hasOneOperation = true
        
        if text != nil {
            if signal && !text!.isEmpty {
                if text!.contains("-") {
                    text!.removeFirst()
                } else {
                    text! = "-\(text!)"
                }
            } else {
                if !operationChange {
                    if text!.onlyDigits().count < 9 {
                        if text!.isEmpty && element == "." {
                            text = "0."
                        } else {
                            text! += element
                        }
                    }
                } else {
                    operationChange = false
                    if element == "." {
                        text = "0."
                    } else {
                        text = element
                    }
                }
            }
        } else {
            operationChange = false
            if element == "." {
                text = "0."
            } else {
                text = element
            }
        }
        
        displayLabel?.text = text
    }
    
    func isDouble() -> Bool {
        if let display = displayLabel {
            if let text = display.text {
                return text.contains(".")
            }
            return false
        }
        return false
    }
    
    func clearDisplay() {
        displayLabel?.text = ""
    }
    
    func displayResult(_ equal: Bool) {
        var response = calculator.result()
        
        if response.count > 10 {
            response = String(response.prefix(10))
        }
        if response.isFalseDouble() {
            response.removeLast()
            response.removeLast()
        }
        
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
    
    func trySetOperatorOne() {
        if let display = displayLabel {
            if let text = display.text {
                calculator.operatorOne = text
            }
        }
    }
    
    func trySetOperatorTwo(_ equal: Bool) {
        if let display = displayLabel {
            if let text = display.text {
                calculator.operatorTwo = text
                displayResult(equal)
            }
        }
    }
    
    func doIt (operation: String) {
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

