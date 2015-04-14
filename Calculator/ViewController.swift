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
    
//    func performOperation(operation:(Double, Double)->Double)
//    {
//        if operandStack.count >= 2{
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    
//    func performOperation(operation:(Double)->Double)
//    {
//        if operandStack.count >= 1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }
    
    func performOperation(operate: (Double,Double) ->Double) {
        if operandStack.count >= 2 {
            displayValue = operate(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operate: (Double) ->Double) {
        if operandStack.count >= 1 {
            displayValue = operate(operandStack.removeLast() )
            enter()
        }
    }
    
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber { enter() }
        
        switch operation {
            case "×": performOperation {$0 * $1}     // Clousure
            case "÷": performOperation {$1 / $0}     // Clousure
            case "+": performOperation {$0 + $1}     // Clousure
            case "-": performOperation {$1 - $0}     // Clousure
            case "√": performOperation { sqrt($0) }     // Clousure            //<== Wierd Error
            default : break
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


