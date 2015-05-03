//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Robbie on 02/05/2015.
//  Copyright (c) 2015 Robbie. All rights reserved.
// 

import Foundation

class CalculatorBrain
{
    enum Op : Printable       //<== Protocol
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double)->Double)
        
        // A computed Prop to allow the Op to print itself.
        var description: String
            {
            get {
                switch self
                    {
                    case .Operand(let operand):
                        return "\(operand)"
                    case .UnaryOperation(let symbol, _):
                        return symbol
                    case .BinaryOperation(let symbol, _):
                        return symbol
                    }
                }
            }
    }// End Op
    
    // Private makes it class private
    // Public make is completely public such as for a framework.
    // default is application public.
    private var opStack = [Op]()                            // Arry of Op
    private var knownOps = [String:Op]()                    // Alt Syntax ->  Dictionary<String,Op>()
    
    init()
    {
        func learnOp(op:Op)
        {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("-") {$1-$0})
        learnOp(Op.BinaryOperation("÷") {$1/$0})
        learnOp(Op.BinaryOperation("+",+))
        learnOp(Op.UnaryOperation("√",sqrt))
    }
    
    func pushOperand(operand: Double) -> Double?
    {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?
    {
        if let operational = knownOps[symbol]        //Returns an optional Op
        {
            opStack.append(operational)
        }
        return evaluate()
    }
    
    //recursive helper function that returns a touple.
    // somewhat mind bending.. best review  !.. I never really got on with recursion.. !
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps:[Op])
    {
        if !ops.isEmpty
        {
            var remainingOps = ops
            let op=remainingOps.removeLast()
            switch op
            {
            case .Operand(let operand):
                    return (operand, remainingOps)
            case .UnaryOperation(_,  let operation):        // underscore "_" means I don't care about this
                    let operatandEvaluation = evaluate(remainingOps)
                    if let operand = operatandEvaluation.result
                    {
                    return (operation(operand),operatandEvaluation.remainingOps)
                    }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
            
        }
      return (nil, ops)
    }
    
    func evaluate()-> Double?{          // Make it an optional so you can return an error state.
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    
}