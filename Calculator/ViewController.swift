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


