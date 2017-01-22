//
//  CalculatorBrain.swift
//  Calculator
//  Created by Ana Perez on 11/20/16.
//  Copyright © 2016 Ana Perez. All rights reserved.

import Foundation

class CalculatorBrain
{
    fileprivate enum Op: CustomStringConvertible {
        case operand(Double)
        case unaryOperation(String, (Double) -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .operand(let operand):
                    return "\(operand)"
                case .unaryOperation(let symbol, _):
                    return symbol
                case .binaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    fileprivate var opStack = [Op]()
    
    
    fileprivate var knownOps = [String:Op]()
    
    init() {
        func learnOp(_ op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.binaryOperation("+", +))
        learnOp(Op.binaryOperation("−") {$1 - $0})
        learnOp(Op.binaryOperation("×", *))
        learnOp(Op.binaryOperation("÷") {$1 / $0})
        learnOp(Op.unaryOperation("√", sqrt))
        learnOp(Op.unaryOperation("sin", sin))
        learnOp(Op.unaryOperation("cos", cos))
        
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return opStack.map {$0.description} as NSArray
        }
        set {
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NumberFormatter().number(from: opSymbol)?.doubleValue {
                        newOpStack.append(.operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    
    fileprivate func evaluate(_ ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .operand(let operand):
                return (operand, remainingOps)
            case .unaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .binaryOperation(_, let operation):
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
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(_ operand: Double) -> Double? {
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    func performOperation(_ symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clear() -> Double {
        if !opStack.isEmpty {
            opStack.removeAll()
        }
        return 0
    }
    
    func hasDecimalPoint(_ digit: String) -> Bool{
        if digit == "." {
            return true
        }
        return false
    }
    
    func isPI(_ digit: String) -> Bool {
        if digit == "π" {
            return true
        }
        return false
    }
    
    func getPI() -> Double{
        return M_PI
    }
    
    func getHistory() -> String{
        return opStack.description
    }
}
