//
//  main.swift
//  Calculator
//
//  Created by daelee on 2023/07/20.
//

import Foundation

// Level 4

class AbstractOperation {
    func calculate(_ firstNumber: Double, _ secondNumber: Double) -> Double {
        return 0
    }
}

class Calculator {
    var operation: AbstractOperation?
    
    init(_ operation: AbstractOperation) {
        self.operation = operation
    }
    
    func setOperation(_ operation: AbstractOperation) {
        self.operation = operation
    }
    
    func calculate(_ firstNumber: Double, _ secondNumber: Double) -> Double {
        guard let operation = self.operation else {
            fatalError("operation is optional. Set operation.")
        }
        return operation.calculate(firstNumber, secondNumber)
    }
}

class AddOperation: AbstractOperation {
    override func calculate(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer + secondNumber
    }
}

class SubtractOperation: AbstractOperation {
    override func calculate(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer - secondNumber
    }
}

class MultiplyOperation: AbstractOperation {
    override func calculate(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer * secondNumber
    }
}

class DivideOperation: AbstractOperation {
    override func calculate(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer / secondNumber
    }
}

let firstNumber: Double = 100
let secondNumber: Double = 20

let calculator = Calculator(AddOperation())
print("addResult : \(calculator.calculate(firstNumber, secondNumber))")

calculator.setOperation(SubtractOperation())
print("subtractResult : \(calculator.calculate(firstNumber, secondNumber))")

calculator.setOperation(MultiplyOperation())
print("multiplyResult : \(calculator.calculate(firstNumber, secondNumber))")

calculator.setOperation(DivideOperation())
print("divideResult : \(calculator.calculate(firstNumber, secondNumber))")
