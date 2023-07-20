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
