//
//  ViewController.swift
//  Calculator
//
//  Created by Ana Perez on 11/20/16.
//  Copyright © 2016 Ana Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController { //Superclass (Inheritance)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet var display: UILabel!
    @IBOutlet var history: UILabel!
    
    var userIsInMiddleOfTypingANumber = false, hasDecimalNumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingANumber {
            if brain.isPI(digit) {
                enter()
                displayValue = brain.getPI()
                enter()
                return
            }
            else if brain.hasDecimalPoint(digit) {
                if hasDecimalNumber {
                    display.text = "Error"
                    return
                } else {
                    hasDecimalNumber = true
                }
            }
            display.text = display.text! + digit
        } else {
            if brain.isPI(digit) {
                displayValue = brain.getPI()
                enter()
                return
            }
            display.text = digit
            userIsInMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        hasDecimalNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        history.text = brain.getHistory()
    }
    
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
    @IBAction func operate(_ sender: UIButton) {
        if userIsInMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    @IBAction func clearView() {
        hasDecimalNumber = false
        displayValue = brain.clear()
        history.text = brain.getHistory()
    }
}

