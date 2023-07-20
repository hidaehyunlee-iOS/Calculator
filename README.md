## 1. Level 3

### 1.1. 구현 기능

기본 Calculator 외에 연산 클래스를 만든 후 클래스 간의 관계를 고려하여 Calculator 클래스와 관계 생성

### 1.2. 고민점

```bash
Error: Cannot use instance member within property initializer
```

**class** Calculator에 연산 메서드를 하나씩 만들게 아니라, 메서드는 각 연산 클래스의 메서드를 사용하고 싶었다.

```swift
var addResult = AddOperation().add(firstNumer, secondNumber)
```

그래서 이렇게 프로퍼티을 만들었는데 위 에러가 난 것. 

인스턴스가 만들어지기 전에, 인스턴스 멤버의 값을 다른 멤버에 할당한다는게 생각해보면 말이 안되는 일이긴 하다.

### 1.3. 해결 방법

`lazy` 키워드를 사용해 **lazy** **var** addResult 같은 식으로 변경해주면, 인스턴스를 생성한 후 addResult에 최초 접근 시 할당되는 식으로 순서를 조절해줄 수 있다고 한다.

```swift
class Calculator {
    var firstNumer: Double
    var secondNumber: Double
    
    init(_ firstNumer: Double, _ secondNumber: Double) {
        self.firstNumer = firstNumer
        self.secondNumber = secondNumber
    }
    
    lazy var addResult = AddOperation().add(firstNumer, secondNumber);
    
  	// ...
}

class AddOperation {
    func add(_ firstNumer: Double, _ secondNumber: Double) -> Double {
        return firstNumer + secondNumber
    }
}

// ...
```

### 1.4. 개선점

클래스의 `단일 책임 원칙` 고려하기. 

*하나의 객체는 반드시 하나의 동작만의 책임을 갖는다*는 원칙이다. 책임이 많아질수록 해당 객체의 변경에 따른 영향이 커질수밖에 없다. 이런 상황을 지양하기 위한 원칙이다.

**모듈화**를 통해 Calculator 객체가 담당하는 메서드(책임)을 없애고자 했다.


<br><br>


## 2. Level 4

### 2.1. 구현 기능

AbstractOperation 클래스를 만들어 연산 클래스들을 추상화 (프로토콜 사용 X)



### 2.2. 고민점, 해결 방법

##### 연산 클래스들을 어떻게 추상화 할 건지? 

Calculator 클래스에 AbstractOperation 타입의 operation 프로퍼티를 하나 두고 프로퍼티 값을 변경하는 메서드를 만들어, 프로퍼티에 맞는 override된 calculate 메서드를 실행한다.

##### 옵셔널, 옵셔널 바인딩

```swift
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
```

`operation` 프로퍼티를 옵셔널로 선언했다. 추상 클래스라 값이 없을수도 있으니까.. 그래서 바인딩을 할 때 `guard let` 구문을 사용했는데 아래와 같은 에러가 났다.

> 'guard' body must not fall through, consider using a 'return' or 'throw' to exit the scope

가드 구문 바디에 print("error") 이런식으로 썼는데, 함수의 return값과 같게 가드문도 반환을 해줘야된다는 것 같다. 적절한 return 값을 모르겠어서 고민했는데  `fatalError()` 라는 함수가 있었다. 

정의는 아래와 같다. 

```swift
public func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never
```

`Never` 타입에 대해서는 애플 문서에 아래와 같이 나와있다.

> Use Never as the return type when declaring a closure, function, or method that unconditionally throws an error, traps, or otherwise does not terminate. 

무조건 오류나 트랩, 어찌됐든 종료되지 않는 무언가를 발생시키는 메소드, 함수, 클로저를 정의할 때 반환 값으로 Never을 사용한다. 그럼 적절히 exit code를 반환하지 않을까? 생각한다.

if let 대신 **guard let**을 사용한 이유는, 언래핑된 상수값 operation을 가드 문 밖에서 사용해야 하기 때문이다. 



### 2.3. 개선점

##### 의존성 역전 원칙 준수: 클래스 간의 결합도를 낮춤

Level 3 코드에서는 `Calculator` 클래스가 각각의 연산 클래스를 직접 생성하고  있었다. 즉, 멤버 프로퍼티로 다른 클래스를 참조하고 있기 때문에 연산 클래스가 없으면 `Calculator` 클래스를 정의하지 못하게 된다. 

이렇게  `Calculator` 클래스가 연산 클래스에 **의존성**이 존재하는 상황을 이렇게 클래스간의 **결합도가 높은** 상황이라고 부른다.

<br>

Level 4 에서는  `AbstractOperation` 클래스를 통해 간접적으로 연산 기능에 접근하도록 구현했다. 이렇게 되면 `Calculator` 클래스와 각 연산 클래스들 사이의 결합도가 낮아지고, **의존성 역전 원칙**을 준수하게 된다.

`Calculator` 클래스에서 각각의 연산 기능을 구현할 필요가 없기 때문에 새로운 연산 기능이 추가되거나 변경되더라도 `Calculator` 클래스의 코드를 수정하지 않아도 되는 장점이 생긴다.


