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
    
    var brain = CalculatorBrain()               // Hook in the controller.
    
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
    
 
    
   
    
    @IBAction func operate(sender: UIButton)
    {

        if userIsInTheMiddleOfTypingANumber { enter() }
        if let operation = sender.currentTitle
        {
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            } else
            {
                displayValue = 0        // Another Lame choice .
            }
        }
        
        }


    
    @IBAction func enter()
    {
        userIsInTheMiddleOfTypingANumber=false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            
        } else {
            // Something in here... RJ TODO
            // Assignment goes in here.
            displayValue = 0    // Lame.. is should be nil or an error message.
        
        }
        
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


