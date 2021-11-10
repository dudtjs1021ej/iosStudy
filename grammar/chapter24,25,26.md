## 📒CHAPTER24 타입 중첩

- __중첩 타입__ : 타입 내부에 새로운 타입을 정의하고 구현

- Ex) 클래스 안에 새 클래스, 클래스 안에 새 구조체, 구조체 안에 새 열거형 ...
- 중첩 타입 왜 구현? -> 이름이 같은 구조체라도 속하는 구조체의 종류에 따라 제공하는 정보가 다르기 떄문

```swift
import UIKit

struct Sports{
    enum GameType{ //같은 GameType이라도 내부 구현은 다름
        case football, basketball
    }
    
    var gameType: GameType
    
    struct GameInfo{
        var time: Int
        var player: Int
    }
    
    var gameInfo: GameInfo{
        switch self.gameType{
        case .basketball:
            return GameInfo(time: 40, player: 5)
            
        case .football:
            return GameInfo(time: 90, player: 11)
        
        }
    }
}

struct ESports{
    enum GameType{ //같은 GameType이라도 내부 구현은 다름
        case online, offline
    }
    
    var gameType: GameType
    
    struct GameInfo{
        var location: String
        var pakage: String
    }
    
    var gameInfo: GameInfo{
        switch self.gameType{
        case .online:
            return GameInfo(location: "www.ac.kr", pakage: "LoL")
            
        case .offline:
            return GameInfo(location: "제주", pakage: "LoL")
        }
    }
}

let someGameType: Sports.GameType = .football //중첩 데이터 타입을 사용하고 싶다면 . 사용

```



## 📒CAHPTER25 패턴

- __패턴__ : 어떤 것을 표현하고 싶다면 패턴을 통해 표현
- 1. 값을 해체하거나 무시하는 패턴 : `와일드카드패턴`  `식별자패턴`  `값 바인딩패턴`  `튜플패턴` 
  2.  패턴 매칭을 위한 패턴 : `열거형케이스패턴` `옵셔널패턴` `표현패턴 ` `타입캐스팅패턴`

---

### 25.1 와일드카드 패턴

- 이 자리에 올 것이 무엇이든간에 상관하지 마라 라는 뜻

```swift
let string: String = "ABC"

switch string{
case _: print(string) //어떤 것이 와도 상관없음 -> 항상 실행
}

let ys = ("ys", 24, "Female")
switch ys{
case("ys", _, _): print("hello ys") //이름만 ys면 상관없음
default: print("none")
}
```

---

### 25.2 식별자 패턴

- 변수의 이름에 알맞는 값을 어떤 값과 매치시키는 패턴
- `let someValue: Int = 42` 
  - `Int` 와 `42` 의 타입이 매치 -> `someValue` 는 42 라는 값의 __식별자__가 됨

---

### 25.3 값 바인딩 패턴

- 변수에 매치된 값을 바인딩 하는 것
- `식별자패턴` 은 `값 바인딩 패턴`의 일종

```swift
let ys2 = ("ys", 24, "Female")
switch ys2{
case let (name, age, gender): print("name: \(name) age: \(age) gender: \(gender)") //name, age, gender의 각각의 요소와 바인딩
}
```

---

### 25.4 튜플 패턴

- 소괄호 내에 쉼표로 분리하는 리스트
- 타입과 값이 일치해야함 ex) `let (x, y): (Int, Int) = (1,2)` -> 요소가 모두 `Int` 타입인 튜플과 매치

```swift
let name: String = "ys"
let age: Int = 24
let gender: String? = "Female"

switch (name, age, gender){
case("ys", _, _): print("hello ys")
case(_, _, "Female"?): print("hello Female")
default: print("none")
}
```

---

### 25.5 열거형 케이스 패턴

- 값을 열거형 타입의 case와 매치시킴
- switch구문의 case나 if, while, guard, for-in 구문의 case 조건에서 볼 수 있음

```swift
let someValue: Int = 30
if case 0...100 = someValue{ //if 구문의 case조건
    print("0<=\(someValue)<=100")
}

enum MainDish{
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = .pasta(taste: "크림")

func whatIsThis(dish: MainDish){
    guard case .pasta(let taste) = dish else{ //guard 구문의 case 조건
        print("is not a pasta")
        return
    }
    print("\(taste) pasta!")
}
whatIsThis(dish: dinner)

while case .pasta(let taste) = dinner{ //while구문의 case 조건
    print("\(taste) pasta!")
    break
}
```

---

### 25.6 옵셔널 패턴

- 옵셔널 또는 암시적 추출 옵셔널 열거행에 감싸져 있는 값을 매치시킬 때 사용

```swift
var optionalValue: Int? = 100

if case .some(let value) = optionalValue{
    print(value)
}

if case let value? = optionalValue{
    print(value)
}

while case .some(let value) = optionalValue{
    print(value)
    break
}

let arrayOptionalInt : [Int?] = [1, nil, 3, nil]
for case let number? in arrayOptionalInt{
    print(number) //nil은 출력되지 않음
}
```

---

### 25.7 타입캐스팅 패턴

- `is` 패턴 /  `as` 패턴

```swift
let someValue: Any = 100
switch someValue{
  case is String: print("it is string!") //타입이 String이면 출력
  case let value as Int: print(value + 1) //타입 확인과 동시에 캐스팅까지 한 후 value에 저장
  default: print("String Int 다 아님")
}
```

---

### 25.8 표현 패턴

- `switch` 구문의 `case` 레이블에서만 사용 가능
- 매우 유용한 패턴

- `~=` 연산자 사용 -> 중복정의하거나 새로 정의하거나 구현하면 원하는대로 패턴을 완성할 수 있음

```swift
let number = 10
if (1...10) ~= number {
  print("number는 1~10")
}
```



## 📒CHAPTER26 where절

- 특정 패턴과 결합하여 __조건__을 추가 or 타입에 대한 __제약__ 추가

---

#### 값 바인딩 패턴에서 where절 사용

```swift
//값 바인딩 패턴에서 where절 사용
let tuples: [(Int, Int)] = [(1,2), (1,-1)]
for tuple in tuples{
    switch tuple{
    case let (x, y) where x > y: print("x>y")
    default: print("x<=y")
    }
}
```

----

#### 옵셔널패턴에서 where절 사용

```swift
let arrayOptionalInt : [Int?] = [1, nil, 3, nil]
for case let number? in arrayOptionalInt where number >= 2{
    print(number) //nil은 출력되지 않음 & 2이상의 값만 출력
}
```

---

#### 타입캐스팅패턴에서 where절 사용

```swift
let anyValue: Any = "ABC"
switch anyValue{
case let value where value is Int: print("value is Int")
case let value where value is String: print("value is String")
default: print("none")
}
```

---

#### 표현패턴에서 where절 사용

```swift
var point: (Int, Int) = (2,2)
switch point{
case (0, 0): print("원점")
case(-2...2, -2...2) where point.0 != 1: print("x가 1이 아니고 원점과 가깝습니다")
default: print("원점이 아니고 원점과 가깝지않습니다")
}
```

---

#### where절을 활용 해 프로토콜 익스텐션의 프로토콜 제약 추가

```swift
protocol SelfPrintable{
    func printSelf()
}

extension Int: SelfPrintable{}

extension SelfPrintable where Self: FixedWidthInteger{
    func printSelf(){
        print("FixedWidthInteger 을 준수하는 타입 \(type(of:self))")
    }
}
Int(-8).printSelf() //FixedWidthInteger 을 준수하는 타입 Int
```

---

#### where절을 활용해 타입 제약 추가

```swift
//where절을 활용해 T가 BinaryInteger 프로토콜을 준수하는 타입으로 만듦
func double<T>(integerValue: T) -> T where T: BinaryInteger{
    return integerValue*2
    
}
```

---

#### where절을 활용해 제네릭 타입의 연관타입 제약 추가

```swift
protocol Talkable{}
protocol CalltoAll{
    func calltoAll()
}
extension Array: CalltoAll where Element: Talkable{ //Element타입이 Talkable 프로토콜을 준수하는 경우만
 func calltoAll() {}
}
```

