## 📒CHAPTER27 ARC

- __ARC__ : 자동으로 메모리를 관리해주는 방식 / 더이상 필요하지 않은 클래스의 인스턴스 해제
- 컴파일 시에 언제 메모리에서 해제되어야 하는지 결정

---

### 27.2 강한참조

- 인스턴스가 계속해서 메모리에 남아있을 명분을 만들어줌

- 인스턴스에 변수나 상수가 할당하면 참조횟수 +1 , nil을 할당해주면 참조횟수 -1
- 밑의 코드와 같은 강한 참조 순환 문제 발생

```swift
import UIKit

//강한참조 순환 문제
class Person{
    let name: String
    
    init(name: String){
        self.name = name
    }
    var room: Room?
    
    deinit{
        print("\(name) deinit")
    }
}

class Room{
    let number: String
    init(number: String){
        self.number = number
    }
    var host: Person?
    
    deinit{
        print("room \(number) deint")
    }
}

var personYS: Person? = Person(name: "YS")//Person인스턴스 참조 횟수 : 1
var room: Room? = Room(number: "102") //Room인스턴스 참조 횟수 : 1

room?.host = personYS //Person인스턴스 참조 횟수 : 2
personYS?.room = room //Room인스턴스 참조 횟수 : 2

personYS = nil  //Person인스턴스 참조 횟수 : 1
room = nil  //Room인스턴스 참조 횟수 : 1
//불필요하게 메모리에 잔존 -> 메모리 누수
```

- 약한참조와 미소유참조로 해결

---

### 27.3 약한참조

- 인스턴스의 참조 횟수 증가x
- `weak` 키워드
- 자신이 참조한 인스턴스가 메모리에서 해제될 수도 있다는 것 예상해야함
- 참조하는 인스턴스가 해제되면 자동으로 nil할당 -> 따라서 변수만 가능 / 옵셔널만 가능

```swift
class Person{
    let name: String

    init(name: String){
        self.name = name
    }
    var room: Room?

    deinit{
        print("\(name) deinit")
    }
}

class Room{
    let number: String
    init(number: String){
        self.number = number
    }
    weak var host: Person? //약한참조

    deinit{
        print("room \(number) deint")
    }
}

var personYS: Person? = Person(name: "YS")//Person인스턴스 참조 횟수 : 1
var room: Room? = Room(number: "102") //Room인스턴스 참조 횟수 : 1

room?.host = personYS //Person인스턴스 참조 횟수 : 1 -> 약한참조라 횟수 증가x
personYS?.room = room //Room인스턴스 참조 횟수 : 2

personYS = nil  //Person인스턴스 참조 횟수 : 0
//YS deinit

room = nil  //Room인스턴스 참조 횟수 : 0
//room 102 deint
```

---

### 27.4 미소유참조

- 인스턴스의 참조 횟수 증가x
- 자신이 참조하는 메모리가 항상 존재할 것이라고 가정하에 사용
- 참조하는 인스턴스가 해제되어도  nil할당 안됨 -> 따라서 변수, 상수 다 가능 / 옵셔널 아니어도 됨
- `unowned` 키워드
- Ex) 신용카드는 사람(=명의자)가 꼭 존재해야함 -> 이렇게 무조건 존재할거라고 확신하는 경우에 사용

```swift
//미소유참조
class Person{
    let name: String

    init(name: String){
        self.name = name
    }
    var card: CreditCard?

    deinit{
        print("\(name) deinit")
    }
}

class CreditCard{
    let number: UInt
    unowned let owner: Person //미소유참조
    init(number: UInt, owner: Person) {
        self.number = number
        self.owner = owner
    }
    deinit{
        print("card \(number) deint")
    }
}
```

---

### 27.5 미소유 옵셔널 참조 

- 옵셔널로 미소유 표시
- nil이 될 수 있다는게 미소유 참조와 다름

---

### 27.6 미소유참조와 암시적 추출 옵셔널 프로퍼티

- 서로 참조해야하는 프로퍼티에 값이 있어야되고,  한번 초기화하면 그 이후 nil을 할당할 수 없는 조건을 갖추어야한다면?

  -> ex) 회사엔 CEO가 있어야하며 CEO는 단 한개의 회사를 운영함 

  -> Company를 초기화할때 CEO인스턴스가 프로퍼티로 할당되어야 하고, Company가 존재하는 한 ceo 프로퍼티는 꼭 CEO 인스턴스가 존재해야함

```swift
class Company{
    let name: String
    var ceo: CEO! //암시적 추출 옵셔널 프로퍼티(ceo는 꼭 있어야함)
    
    init(name: String, ceoName: String){
        self.name = name
        self.ceo = CEO(name:ceoName, company: self)
    }
}

class CEO{
    let name: String
    unowned let company: Company //미소유참조 상수 프로퍼티
    init(name: String, company: Company){
        self.name = name
        self.company = company
    }
}
```

---

### 27.7 클로저의 강한참조 순환

- 클로저가 참조 타입이기 때문에 발생 

- Introduce프로퍼티로 클로저 호출 -> 클로저는 참조 횟수를 증가시킴 (자신을 프로퍼티로 갖는 인스턴스도..) -> 강한 참조 순환 발생

  -> 획득목록으로 해결

```swift
class Person{
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        var introduction: String = "My name us \(self.name)"
        guard let hobby = self.hobby else{
            return introduction
        }
        introduction += " "
        introduction += "my hobby is \(hobby)"
        return introduction
    }
    
    init(name: String, hobby: String? = nil){
        self.name = name
        self.hobby = hobby
    }
    
    deinit{
        print("\(name) deinit")
    }
}

var personYS: Person? = Person(name: "YS", hobby: "eating")
print(personYS?.introduce())
personYS = nil //->deinit 이 호출되지 않음 -> 인스턴스가 메모리에서 해제되지 않음
```

---

#### 27.7.1 획득 목록 

- 클로저 내부에서 매개변수 목록 이전 위치에 작성
- 참조 방식과 참조 대상을 [] 대괄호로 묶음 / 획득목록 뒤에는 `in` 키워드 사용
- 값 타입은 값이 변경 되더라도 클로저의 획득목록을 통한 변수엔 변함 없음
- 참조 타입은 획득 목록에서 어떤 방식을 참조할 것인지 결정
  - **강한 획득**
  - **약한 획득** : 획득목록에서 획득하는 상수 옵셔널 상수로 지정됨 (이미 해제된 상태일 수도 있기 떄문)
  - **미소유 획득**

```swift
class Person{
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        [unowned self] in //획득목록에 self를 미소유참조하도록 명시
        var introduction: String = "My name us \(self.name)"
        guard let hobby = self.hobby else{
            return introduction
        }
        introduction += " "
        introduction += "my hobby is \(hobby)"
        return introduction
    }
    
    init(name: String, hobby: String? = nil){
        self.name = name
        self.hobby = hobby
    }
    
    deinit{
        print("\(name) deinit")
    }
}

var personYS: Person? = Person(name: "YS", hobby: "eating")
print(personYS?.introduce())
personYS = nil //->deinit 이 호출됨
```



## 📒CHAPTER28 오류처리

- 오류처리 : 프로그램이 오류를 일으켰을 때 감지하고 회복시키는 것
- `Error` 프로토콜 채택해 오류를 표현

---

### 28.3 오류 포착 및 정리

- 오류를 처리하기 위한 4가지 방법
  1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 알리는 방법
  2. `do-catch` 구문을 이용하여 오류를 처리하는 방법
  3. 옵셔널 값으로 오류를 처리하는 방법
  4. 오류가 발생하지 않을 것이라 확신하는 방법



#### 28.3.1 함수에서 발생한 오류 알리기

- `throw` 키워드로 오류를 던질 수 있음

```swift
func vend(itemNamed name: String) throws{
  guard let item = self.inventory[name] else{
    throw VendingMachineError.invalidSelection
  }
  ...
}
```

#### 28.3.2 do-catch 구문을 이용하여 오류처리

```swift
do{
  try 오류발생가능코드
  오류가 없으면 실행할 코드
}catch 오류패턴1{
  처리코드
}catch 오류패턴2 where 추가조건{
  처리코드
}
//--------------------------------------------
do{
  try vendingMachine.vend(itemNamed: itemNamed)
}catch VendingMachineError.invalidSelection{
  print("유효하지않은선택")
}
```

#### 28.3.3 옵셔널값으로 오류처리

- `try?` 표현 사용 -> 동작하던 코드가 오류를 던지면 nil 리턴

```swift
let x: Optional = try? someThrowingFunction(shoudThrowError: true)
```

#### 28.3.4 오류가 발생하지 않을 것이라고 확신하는 방법

- `try!` 표현 사용 -> 실제로 오류가 발생하면 런타임 오류 -> 프로그램 강제 종료

```swift
let x: Optional = try! someThrowingFunction(shoudThrowError: true)
```

#### 28.3.5 다시 던지기

- `rethrows` 키워드 사용 -> 최소 하나 이상의 오류가 발생 가능한 함수를 매개변수로 전달 받아야 함
- 스스로 오류를 던지지 못함 == 자신의 내부에 직접적으로 `throws` 구문 사용 불가능
- But `catch` 절 내부엔 `throws` 구문 작성 가능

```swift
func someThrowingFunction() throws {
    enum SomeError: Error{
        case justSomeError
    }
    
    throw SomeError.justSomeError
}
//다시 던지기 함수
func someFunction(callback: () throws -> Void) rethrows {
    try callback() //오류를 다시 던지기만 함 (처리x)
}
do {
    try someFunction(callback: someThrowingFunction) {
        
    }catch{
        print(error)
    }
}
```

#### 28.3.6 후처리 defer

- 현재 코드 블록을 나가기 전에 꼭 실행해야 하는 코드 작성해줄 수 있음
- 코드 블록을 빠져나가기 전에 무조건 실행 보장
- `break` `return`  같이 구문을 빠져나가는 코드는 작성 x

```swift
func someFunction(){
    print("1")
    defer{
        print("2")
    }
    
    do{
        defer{
            print("3")
        }
        print("4")
    }
    
    defer{
        print("5")
    }
    print("6")
}

someFunction()
//1
//4
//3
//6
//5
//2
```



## 📒CHAPTER29 메모리안전

- 스위프트는 메모리를 자동으로 관리 -> 프로그래머가 메모리 접근에 대해 신경 쓸 필요x

---

### 29.2 입출력 매개변수에서의 메모리 접근 충돌

```swift
var step: Int = 1
func increment(_ numberL inout Int){
  number += step
}
increment(&step) //오류 발생!
```

---

### 29.3 메소드 내부에서 self 접근의 충돌

```swift
struct GamePlayer{
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth(){
        self.health = GamePlayer.maxHealth //자신인 self에 장기적으로 접근
    }
    
    mutating func shareHealth(with teammate: inout GamePlayer){ //다른 캐릭터의 인스턴스를 입출력 매개변수로 받음 -> 메모리 접근 충돌 여지 있음
        balance(&teammate.health, &health)
    }
}

var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
oscar.shareHealth(with: &oscar) //오류발생
```

---

### 29.4 프로퍼티 접근 중 충돌

- 메모리 안전 때문에 구조체의 프로퍼티 메모리에 접근하는 티이밍 겹치는 것 무조건 제한x
- 세 가지 조건 충족한다면 메모리 동시에 접근하더라도 안전
  1. 연산 프로퍼티나 클래스 프로퍼티가 아닌 인스턴스의 **저장 프로퍼티**에만 접근
  2. 전역변수가 아닌 **지역변수**일 때
  3. 클로저에의해 획득 되지 않았거나 비탈출 클로저에 의해서만 획득되었을 때