//
//  main.swift
//  Calculator
//
//  Created by daelee on 2023/07/20.
//

import Foundation

// Level 3

class Calculator {
    var firstNumer: Double
    var secondNumber: Double
    
    init(_ firstNumer: Double, _ secondNumber: Double) {
        self.firstNumer = firstNumer
        self.secondNumber = secondNumber
    }
    
    lazy var addResult = AddOperation().add(firstNumer, secondNumber);
    lazy var subtractResult = SubtractOperation().subtract(firstNumer, secondNumber);
    lazy var multiplyResult = MultiplyOperation().multiply(firstNumer, secondNumber);
    lazy var divideResult = DivideOperation().divide(firstNumer, secondNumber);
}

class AddOperation {
    func add(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer + secondNumber
    }
}

class SubtractOperation {
    func subtract(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer - secondNumber
    }
}

class MultiplyOperation {
    func multiply(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer * secondNumber
    }
}

class DivideOperation {
    func divide(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer / secondNumber
    }
}

let firstNumber: Double = 100
let secondNumber: Double = 20
let calculator = Calculator(firstNumber, secondNumber)

print("addResult : \(calculator.addResult)")
print("subtractResult : \(calculator.subtractResult)")
print("multiplyResult : \(calculator.multiplyResult)")
print("divideResult : \(calculator.divideResult)")
