## πCHAPTER24 νμ μ€μ²©

- __μ€μ²© νμ__ : νμ λ΄λΆμ μλ‘μ΄ νμμ μ μνκ³  κ΅¬ν

- Ex) ν΄λμ€ μμ μ ν΄λμ€, ν΄λμ€ μμ μ κ΅¬μ‘°μ²΄, κ΅¬μ‘°μ²΄ μμ μ μ΄κ±°ν ...
- μ€μ²© νμ μ κ΅¬ν? -> μ΄λ¦μ΄ κ°μ κ΅¬μ‘°μ²΄λΌλ μνλ κ΅¬μ‘°μ²΄μ μ’λ₯μ λ°λΌ μ κ³΅νλ μ λ³΄κ° λ€λ₯΄κΈ° λλ¬Έ

```swift
import UIKit

struct Sports{
    enum GameType{ //κ°μ GameTypeμ΄λΌλ λ΄λΆ κ΅¬νμ λ€λ¦
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
    enum GameType{ //κ°μ GameTypeμ΄λΌλ λ΄λΆ κ΅¬νμ λ€λ¦
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
            return GameInfo(location: "μ μ£Ό", pakage: "LoL")
        }
    }
}

let someGameType: Sports.GameType = .football //μ€μ²© λ°μ΄ν° νμμ μ¬μ©νκ³  μΆλ€λ©΄ . μ¬μ©

```



## πCAHPTER25 ν¨ν΄

- __ν¨ν΄__ : μ΄λ€ κ²μ νννκ³  μΆλ€λ©΄ ν¨ν΄μ ν΅ν΄ νν
- 1. κ°μ ν΄μ²΄νκ±°λ λ¬΄μνλ ν¨ν΄ : `μμΌλμΉ΄λν¨ν΄`  `μλ³μν¨ν΄`  `κ° λ°μΈλ©ν¨ν΄`  `ννν¨ν΄` 
  2.  ν¨ν΄ λ§€μΉ­μ μν ν¨ν΄ : `μ΄κ±°νμΌμ΄μ€ν¨ν΄` `μ΅μλν¨ν΄` `ννν¨ν΄ ` `νμμΊμ€νν¨ν΄`

---

### 25.1 μμΌλμΉ΄λ ν¨ν΄

- μ΄ μλ¦¬μ μ¬ κ²μ΄ λ¬΄μμ΄λ κ°μ μκ΄νμ§ λ§λΌ λΌλ λ»

```swift
let string: String = "ABC"

switch string{
case _: print(string) //μ΄λ€ κ²μ΄ μλ μκ΄μμ -> ν­μ μ€ν
}

let ys = ("ys", 24, "Female")
switch ys{
case("ys", _, _): print("hello ys") //μ΄λ¦λ§ ysλ©΄ μκ΄μμ
default: print("none")
}
```

---

### 25.2 μλ³μ ν¨ν΄

- λ³μμ μ΄λ¦μ μλ§λ κ°μ μ΄λ€ κ°κ³Ό λ§€μΉμν€λ ν¨ν΄
- `let someValue: Int = 42` 
  - `Int` μ `42` μ νμμ΄ λ§€μΉ -> `someValue` λ 42 λΌλ κ°μ __μλ³μ__κ° λ¨

---

### 25.3 κ° λ°μΈλ© ν¨ν΄

- λ³μμ λ§€μΉλ κ°μ λ°μΈλ© νλ κ²
- `μλ³μν¨ν΄` μ `κ° λ°μΈλ© ν¨ν΄`μ μΌμ’

```swift
let ys2 = ("ys", 24, "Female")
switch ys2{
case let (name, age, gender): print("name: \(name) age: \(age) gender: \(gender)") //name, age, genderμ κ°κ°μ μμμ λ°μΈλ©
}
```

---

### 25.4 νν ν¨ν΄

- μκ΄νΈ λ΄μ μΌνλ‘ λΆλ¦¬νλ λ¦¬μ€νΈ
- νμκ³Ό κ°μ΄ μΌμΉν΄μΌν¨ ex) `let (x, y): (Int, Int) = (1,2)` -> μμκ° λͺ¨λ `Int` νμμΈ ννκ³Ό λ§€μΉ

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

### 25.5 μ΄κ±°ν μΌμ΄μ€ ν¨ν΄

- κ°μ μ΄κ±°ν νμμ caseμ λ§€μΉμν΄
- switchκ΅¬λ¬Έμ caseλ if, while, guard, for-in κ΅¬λ¬Έμ case μ‘°κ±΄μμ λ³Ό μ μμ

```swift
let someValue: Int = 30
if case 0...100 = someValue{ //if κ΅¬λ¬Έμ caseμ‘°κ±΄
    print("0<=\(someValue)<=100")
}

enum MainDish{
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = .pasta(taste: "ν¬λ¦Ό")

func whatIsThis(dish: MainDish){
    guard case .pasta(let taste) = dish else{ //guard κ΅¬λ¬Έμ case μ‘°κ±΄
        print("is not a pasta")
        return
    }
    print("\(taste) pasta!")
}
whatIsThis(dish: dinner)

while case .pasta(let taste) = dinner{ //whileκ΅¬λ¬Έμ case μ‘°κ±΄
    print("\(taste) pasta!")
    break
}
```

---

### 25.6 μ΅μλ ν¨ν΄

- μ΅μλ λλ μμμ  μΆμΆ μ΅μλ μ΄κ±°νμ κ°μΈμ Έ μλ κ°μ λ§€μΉμν¬ λ μ¬μ©

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
    print(number) //nilμ μΆλ ₯λμ§ μμ
}
```

---

### 25.7 νμμΊμ€ν ν¨ν΄

- `is` ν¨ν΄ /  `as` ν¨ν΄

```swift
let someValue: Any = 100
switch someValue{
  case is String: print("it is string!") //νμμ΄ Stringμ΄λ©΄ μΆλ ₯
  case let value as Int: print(value + 1) //νμ νμΈκ³Ό λμμ μΊμ€νκΉμ§ ν ν valueμ μ μ₯
  default: print("String Int λ€ μλ")
}
```

---

### 25.8 νν ν¨ν΄

- `switch` κ΅¬λ¬Έμ `case` λ μ΄λΈμμλ§ μ¬μ© κ°λ₯
- λ§€μ° μ μ©ν ν¨ν΄

- `~=` μ°μ°μ μ¬μ© -> μ€λ³΅μ μνκ±°λ μλ‘ μ μνκ±°λ κ΅¬ννλ©΄ μνλλλ‘ ν¨ν΄μ μμ±ν  μ μμ

```swift
let number = 10
if (1...10) ~= number {
  print("numberλ 1~10")
}
```



## πCHAPTER26 whereμ 

- νΉμ  ν¨ν΄κ³Ό κ²°ν©νμ¬ __μ‘°κ±΄__μ μΆκ° or νμμ λν __μ μ½__ μΆκ°

---

#### κ° λ°μΈλ© ν¨ν΄μμ whereμ  μ¬μ©

```swift
//κ° λ°μΈλ© ν¨ν΄μμ whereμ  μ¬μ©
let tuples: [(Int, Int)] = [(1,2), (1,-1)]
for tuple in tuples{
    switch tuple{
    case let (x, y) where x > y: print("x>y")
    default: print("x<=y")
    }
}
```

----

#### μ΅μλν¨ν΄μμ whereμ  μ¬μ©

```swift
let arrayOptionalInt : [Int?] = [1, nil, 3, nil]
for case let number? in arrayOptionalInt where number >= 2{
    print(number) //nilμ μΆλ ₯λμ§ μμ & 2μ΄μμ κ°λ§ μΆλ ₯
}
```

---

#### νμμΊμ€νν¨ν΄μμ whereμ  μ¬μ©

```swift
let anyValue: Any = "ABC"
switch anyValue{
case let value where value is Int: print("value is Int")
case let value where value is String: print("value is String")
default: print("none")
}
```

---

#### ννν¨ν΄μμ whereμ  μ¬μ©

```swift
var point: (Int, Int) = (2,2)
switch point{
case (0, 0): print("μμ ")
case(-2...2, -2...2) where point.0 != 1: print("xκ° 1μ΄ μλκ³  μμ κ³Ό κ°κΉμ΅λλ€")
default: print("μμ μ΄ μλκ³  μμ κ³Ό κ°κΉμ§μμ΅λλ€")
}
```

---

#### whereμ μ νμ© ν΄ νλ‘ν μ½ μ΅μ€νμμ νλ‘ν μ½ μ μ½ μΆκ°

```swift
protocol SelfPrintable{
    func printSelf()
}

extension Int: SelfPrintable{}

extension SelfPrintable where Self: FixedWidthInteger{
    func printSelf(){
        print("FixedWidthInteger μ μ€μνλ νμ \(type(of:self))")
    }
}
Int(-8).printSelf() //FixedWidthInteger μ μ€μνλ νμ Int
```

---

#### whereμ μ νμ©ν΄ νμ μ μ½ μΆκ°

```swift
//whereμ μ νμ©ν΄ Tκ° BinaryInteger νλ‘ν μ½μ μ€μνλ νμμΌλ‘ λ§λ¦
func double<T>(integerValue: T) -> T where T: BinaryInteger{
    return integerValue*2
    
}
```

---

#### whereμ μ νμ©ν΄ μ λ€λ¦­ νμμ μ°κ΄νμ μ μ½ μΆκ°

```swift
protocol Talkable{}
protocol CalltoAll{
    func calltoAll()
}
extension Array: CalltoAll where Element: Talkable{ //Elementνμμ΄ Talkable νλ‘ν μ½μ μ€μνλ κ²½μ°λ§
 func calltoAll() {}
}
```

