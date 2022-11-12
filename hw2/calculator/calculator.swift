//
//  calculator.swift
//  calculator
//
//  Created by Songli Wu on 2022/9/29.
//

import UIKit

class calculator: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    var operations = [
        "+": Operation.BinaryOp{
            (op1,op2) in
            return op1+op2
        },
        
        "-": Operation.BinaryOp{
            (op1,op2) in
            return op1-op2
        },
        
        "*": Operation.BinaryOp{
            (op1,op2) in
            return op1*op2
        },
        
        "/": Operation.BinaryOp{
            (op1,op2) in
            return op1/op2
        },
        
        "%": Operation.BinaryOp{
            (op1,op2) in
            return op1 .truncatingRemainder(dividingBy: op2) 
        },
        
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        
        "Clear": Operation.UnaryOp{
            _ in
            return 0
        },
        
        "pi":Operation.Constant(3.14),
        "=":Operation.EqualOp
    
    ]
    
    struct Intermediate {
        var firstOp:Double
        var waitingOperation: (Double,Double)->Double
    }
    var pendingOp: Intermediate?=nil
    
    func performOperation(operation:String,operand:Double)->Double?{
        if let op = operations[operation]{
            switch op {
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp:operand,waitingOperation: function)
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                return pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
            case .UnaryOp(let function):
                return function(operand)
            }
            
        }
        return nil
    }

}
