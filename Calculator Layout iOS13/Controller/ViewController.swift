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
            trySetOperatorTwo()
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if hasOneOperation {
            hasOneOperation = false
            if !calculator.operatorOne.isEmpty {
                trySetOperatorTwo()
            } else {
                trySetOperatorOne()
                calculator.operation = "+"
                operationChange = true
                hasOneEqual = true
            }
        }
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        clearDisplay()
    }
    
    @IBAction func multButton(_ sender: UIButton) {
        clearDisplay()
    }
    
    @IBAction func percentageButton(_ sender: UIButton) {
        clearDisplay()
    }
    
    @IBAction func signalButton(_ sender: UIButton) {
        display(element: "", true)
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        hasOneEqual = true
        calculator.clear()
        clearDisplay()
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        clearDisplay()
    }
    
    
    func display(element: String, _ signal: Bool = false) {
        var text = displayLabel?.text
        hasOneOperation = true
        
        if text != nil && !operationChange {
            if signal && !text!.isEmpty {
                if text!.contains("-") {
                    text!.removeFirst()
                } else {
                    text! = "-\(text!)"
                }
            } else {
                if text!.onlyDigits().count < 9 {
                    text! += element
                }
            }
        } else {
            operationChange = false
            text = element
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
    
    func displayResult() {
        let response = calculator.result()
        calculator.operatorOne = response
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
    
    func trySetOperatorTwo() {
        if let display = displayLabel {
            if let text = display.text {
                calculator.operatorTwo = text
                displayResult()
            }
        }
    }
}

