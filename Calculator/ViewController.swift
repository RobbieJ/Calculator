//
//  ViewController.swift
//  Calculator
//
//  Created by Robbie on 10/04/2015.
//  Copyright (c) 2015 Robbie. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!        // <-- Unwrap the Optional Varible.
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            //println("Digit = \(digit)")
        } else
        {
            display.text = digit
            userIsInTheMiddleOfTypingANumber=true
        }
        
    }
    
    var operandStack  = Array<Double>()
    
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber { enter() }
        
        switch operation {
            case "×": perfomOperation {$0 * $1}     // Clousure
            case "÷": perfomOperation {$1 / $0}     // Clousure
            case "+": perfomOperation {$0 + $1}     // Clousure
            case "-": perfomOperation {$1 - $0}     // Clousure
            case "√": perfomOperation { sqrt($0) }     // Clousure            //<== Wierd Error
            default : break
        }
    }


    
    func perfomOperation(operation: (Double, Double) ->Double)
    {
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double)
    {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    @IBAction func enter()
    {
        userIsInTheMiddleOfTypingANumber=false
        operandStack.append(displayValue)
    }

    var displayValue : Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber=false
        }
    }
    
    
} // End of ViewController Class


