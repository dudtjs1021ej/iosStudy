## ๐CHAPTER27 ARC

- __ARC__ : ์๋์ผ๋ก ๋ฉ๋ชจ๋ฆฌ๋ฅผ ๊ด๋ฆฌํด์ฃผ๋ ๋ฐฉ์ / ๋์ด์ ํ์ํ์ง ์์ ํด๋์ค์ ์ธ์คํด์ค ํด์ 
- ์ปดํ์ผ ์์ ์ธ์  ๋ฉ๋ชจ๋ฆฌ์์ ํด์ ๋์ด์ผ ํ๋์ง ๊ฒฐ์ 

---

### 27.2 ๊ฐํ์ฐธ์กฐ

- ์ธ์คํด์ค๊ฐ ๊ณ์ํด์ ๋ฉ๋ชจ๋ฆฌ์ ๋จ์์์ ๋ช๋ถ์ ๋ง๋ค์ด์ค

- ์ธ์คํด์ค์ ๋ณ์๋ ์์๊ฐ ํ ๋นํ๋ฉด ์ฐธ์กฐํ์ +1 , nil์ ํ ๋นํด์ฃผ๋ฉด ์ฐธ์กฐํ์ -1
- ๋ฐ์ ์ฝ๋์ ๊ฐ์ ๊ฐํ ์ฐธ์กฐ ์ํ ๋ฌธ์  ๋ฐ์

```swift
import UIKit

//๊ฐํ์ฐธ์กฐ ์ํ ๋ฌธ์ 
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

var personYS: Person? = Person(name: "YS")//Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1
var room: Room? = Room(number: "102") //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1

room?.host = personYS //Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 2
personYS?.room = room //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 2

personYS = nil  //Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1
room = nil  //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1
//๋ถํ์ํ๊ฒ ๋ฉ๋ชจ๋ฆฌ์ ์์กด -> ๋ฉ๋ชจ๋ฆฌ ๋์
```

- ์ฝํ์ฐธ์กฐ์ ๋ฏธ์์ ์ฐธ์กฐ๋ก ํด๊ฒฐ

---

### 27.3 ์ฝํ์ฐธ์กฐ

- ์ธ์คํด์ค์ ์ฐธ์กฐ ํ์ ์ฆ๊ฐx
- `weak` ํค์๋
- ์์ ์ด ์ฐธ์กฐํ ์ธ์คํด์ค๊ฐ ๋ฉ๋ชจ๋ฆฌ์์ ํด์ ๋  ์๋ ์๋ค๋ ๊ฒ ์์ํด์ผํจ
- ์ฐธ์กฐํ๋ ์ธ์คํด์ค๊ฐ ํด์ ๋๋ฉด ์๋์ผ๋ก nilํ ๋น -> ๋ฐ๋ผ์ ๋ณ์๋ง ๊ฐ๋ฅ / ์ต์๋๋ง ๊ฐ๋ฅ

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
    weak var host: Person? //์ฝํ์ฐธ์กฐ

    deinit{
        print("room \(number) deint")
    }
}

var personYS: Person? = Person(name: "YS")//Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1
var room: Room? = Room(number: "102") //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1

room?.host = personYS //Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 1 -> ์ฝํ์ฐธ์กฐ๋ผ ํ์ ์ฆ๊ฐx
personYS?.room = room //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 2

personYS = nil  //Person์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 0
//YS deinit

room = nil  //Room์ธ์คํด์ค ์ฐธ์กฐ ํ์ : 0
//room 102 deint
```

---

### 27.4 ๋ฏธ์์ ์ฐธ์กฐ

- ์ธ์คํด์ค์ ์ฐธ์กฐ ํ์ ์ฆ๊ฐx
- ์์ ์ด ์ฐธ์กฐํ๋ ๋ฉ๋ชจ๋ฆฌ๊ฐ ํญ์ ์กด์ฌํ  ๊ฒ์ด๋ผ๊ณ  ๊ฐ์ ํ์ ์ฌ์ฉ
- ์ฐธ์กฐํ๋ ์ธ์คํด์ค๊ฐ ํด์ ๋์ด๋  nilํ ๋น ์๋จ -> ๋ฐ๋ผ์ ๋ณ์, ์์ ๋ค ๊ฐ๋ฅ / ์ต์๋ ์๋์ด๋ ๋จ
- `unowned` ํค์๋
- Ex) ์ ์ฉ์นด๋๋ ์ฌ๋(=๋ช์์)๊ฐ ๊ผญ ์กด์ฌํด์ผํจ -> ์ด๋ ๊ฒ ๋ฌด์กฐ๊ฑด ์กด์ฌํ ๊ฑฐ๋ผ๊ณ  ํ์ ํ๋ ๊ฒฝ์ฐ์ ์ฌ์ฉ

```swift
//๋ฏธ์์ ์ฐธ์กฐ
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
    unowned let owner: Person //๋ฏธ์์ ์ฐธ์กฐ
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

### 27.5 ๋ฏธ์์  ์ต์๋ ์ฐธ์กฐ 

- ์ต์๋๋ก ๋ฏธ์์  ํ์
- nil์ด ๋  ์ ์๋ค๋๊ฒ ๋ฏธ์์  ์ฐธ์กฐ์ ๋ค๋ฆ

---

### 27.6 ๋ฏธ์์ ์ฐธ์กฐ์ ์์์  ์ถ์ถ ์ต์๋ ํ๋กํผํฐ

- ์๋ก ์ฐธ์กฐํด์ผํ๋ ํ๋กํผํฐ์ ๊ฐ์ด ์์ด์ผ๋๊ณ ,  ํ๋ฒ ์ด๊ธฐํํ๋ฉด ๊ทธ ์ดํ nil์ ํ ๋นํ  ์ ์๋ ์กฐ๊ฑด์ ๊ฐ์ถ์ด์ผํ๋ค๋ฉด?

  -> ex) ํ์ฌ์ CEO๊ฐ ์์ด์ผํ๋ฉฐ CEO๋ ๋จ ํ๊ฐ์ ํ์ฌ๋ฅผ ์ด์ํจ 

  -> Company๋ฅผ ์ด๊ธฐํํ ๋ CEO์ธ์คํด์ค๊ฐ ํ๋กํผํฐ๋ก ํ ๋น๋์ด์ผ ํ๊ณ , Company๊ฐ ์กด์ฌํ๋ ํ ceo ํ๋กํผํฐ๋ ๊ผญ CEO ์ธ์คํด์ค๊ฐ ์กด์ฌํด์ผํจ

```swift
class Company{
    let name: String
    var ceo: CEO! //์์์  ์ถ์ถ ์ต์๋ ํ๋กํผํฐ(ceo๋ ๊ผญ ์์ด์ผํจ)
    
    init(name: String, ceoName: String){
        self.name = name
        self.ceo = CEO(name:ceoName, company: self)
    }
}

class CEO{
    let name: String
    unowned let company: Company //๋ฏธ์์ ์ฐธ์กฐ ์์ ํ๋กํผํฐ
    init(name: String, company: Company){
        self.name = name
        self.company = company
    }
}
```

---

### 27.7 ํด๋ก์ ์ ๊ฐํ์ฐธ์กฐ ์ํ

- ํด๋ก์ ๊ฐ ์ฐธ์กฐ ํ์์ด๊ธฐ ๋๋ฌธ์ ๋ฐ์ 

- Introduceํ๋กํผํฐ๋ก ํด๋ก์  ํธ์ถ -> ํด๋ก์ ๋ ์ฐธ์กฐ ํ์๋ฅผ ์ฆ๊ฐ์ํด (์์ ์ ํ๋กํผํฐ๋ก ๊ฐ๋ ์ธ์คํด์ค๋..) -> ๊ฐํ ์ฐธ์กฐ ์ํ ๋ฐ์

  -> ํ๋๋ชฉ๋ก์ผ๋ก ํด๊ฒฐ

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
personYS = nil //->deinit ์ด ํธ์ถ๋์ง ์์ -> ์ธ์คํด์ค๊ฐ ๋ฉ๋ชจ๋ฆฌ์์ ํด์ ๋์ง ์์
```

---

#### 27.7.1 ํ๋ ๋ชฉ๋ก 

- ํด๋ก์  ๋ด๋ถ์์ ๋งค๊ฐ๋ณ์ ๋ชฉ๋ก ์ด์  ์์น์ ์์ฑ
- ์ฐธ์กฐ ๋ฐฉ์๊ณผ ์ฐธ์กฐ ๋์์ [] ๋๊ดํธ๋ก ๋ฌถ์ / ํ๋๋ชฉ๋ก ๋ค์๋ `in` ํค์๋ ์ฌ์ฉ
- ๊ฐ ํ์์ ๊ฐ์ด ๋ณ๊ฒฝ ๋๋๋ผ๋ ํด๋ก์ ์ ํ๋๋ชฉ๋ก์ ํตํ ๋ณ์์ ๋ณํจ ์์
- ์ฐธ์กฐ ํ์์ ํ๋ ๋ชฉ๋ก์์ ์ด๋ค ๋ฐฉ์์ ์ฐธ์กฐํ  ๊ฒ์ธ์ง ๊ฒฐ์ 
  - **๊ฐํ ํ๋**
  - **์ฝํ ํ๋** : ํ๋๋ชฉ๋ก์์ ํ๋ํ๋ ์์ ์ต์๋ ์์๋ก ์ง์ ๋จ (์ด๋ฏธ ํด์ ๋ ์ํ์ผ ์๋ ์๊ธฐ ๋๋ฌธ)
  - **๋ฏธ์์  ํ๋**

```swift
class Person{
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        [unowned self] in //ํ๋๋ชฉ๋ก์ self๋ฅผ ๋ฏธ์์ ์ฐธ์กฐํ๋๋ก ๋ช์
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
personYS = nil //->deinit ์ด ํธ์ถ๋จ
```



## ๐CHAPTER28 ์ค๋ฅ์ฒ๋ฆฌ

- ์ค๋ฅ์ฒ๋ฆฌ : ํ๋ก๊ทธ๋จ์ด ์ค๋ฅ๋ฅผ ์ผ์ผ์ผฐ์ ๋ ๊ฐ์งํ๊ณ  ํ๋ณต์ํค๋ ๊ฒ
- `Error` ํ๋กํ ์ฝ ์ฑํํด ์ค๋ฅ๋ฅผ ํํ

---

### 28.3 ์ค๋ฅ ํฌ์ฐฉ ๋ฐ ์ ๋ฆฌ

- ์ค๋ฅ๋ฅผ ์ฒ๋ฆฌํ๊ธฐ ์ํ 4๊ฐ์ง ๋ฐฉ๋ฒ
  1. ํจ์์์ ๋ฐ์ํ ์ค๋ฅ๋ฅผ ํด๋น ํจ์๋ฅผ ํธ์ถํ ์ฝ๋์ ์๋ฆฌ๋ ๋ฐฉ๋ฒ
  2. `do-catch` ๊ตฌ๋ฌธ์ ์ด์ฉํ์ฌ ์ค๋ฅ๋ฅผ ์ฒ๋ฆฌํ๋ ๋ฐฉ๋ฒ
  3. ์ต์๋ ๊ฐ์ผ๋ก ์ค๋ฅ๋ฅผ ์ฒ๋ฆฌํ๋ ๋ฐฉ๋ฒ
  4. ์ค๋ฅ๊ฐ ๋ฐ์ํ์ง ์์ ๊ฒ์ด๋ผ ํ์ ํ๋ ๋ฐฉ๋ฒ



#### 28.3.1 ํจ์์์ ๋ฐ์ํ ์ค๋ฅ ์๋ฆฌ๊ธฐ

- `throw` ํค์๋๋ก ์ค๋ฅ๋ฅผ ๋์ง ์ ์์

```swift
func vend(itemNamed name: String) throws{
  guard let item = self.inventory[name] else{
    throw VendingMachineError.invalidSelection
  }
  ...
}
```

#### 28.3.2 do-catch ๊ตฌ๋ฌธ์ ์ด์ฉํ์ฌ ์ค๋ฅ์ฒ๋ฆฌ

```swift
do{
  try ์ค๋ฅ๋ฐ์๊ฐ๋ฅ์ฝ๋
  ์ค๋ฅ๊ฐ ์์ผ๋ฉด ์คํํ  ์ฝ๋
}catch ์ค๋ฅํจํด1{
  ์ฒ๋ฆฌ์ฝ๋
}catch ์ค๋ฅํจํด2 where ์ถ๊ฐ์กฐ๊ฑด{
  ์ฒ๋ฆฌ์ฝ๋
}
//--------------------------------------------
do{
  try vendingMachine.vend(itemNamed: itemNamed)
}catch VendingMachineError.invalidSelection{
  print("์ ํจํ์ง์์์ ํ")
}
```

#### 28.3.3 ์ต์๋๊ฐ์ผ๋ก ์ค๋ฅ์ฒ๋ฆฌ

- `try?` ํํ ์ฌ์ฉ -> ๋์ํ๋ ์ฝ๋๊ฐ ์ค๋ฅ๋ฅผ ๋์ง๋ฉด nil ๋ฆฌํด

```swift
let x: Optional = try? someThrowingFunction(shoudThrowError: true)
```

#### 28.3.4 ์ค๋ฅ๊ฐ ๋ฐ์ํ์ง ์์ ๊ฒ์ด๋ผ๊ณ  ํ์ ํ๋ ๋ฐฉ๋ฒ

- `try!` ํํ ์ฌ์ฉ -> ์ค์ ๋ก ์ค๋ฅ๊ฐ ๋ฐ์ํ๋ฉด ๋ฐํ์ ์ค๋ฅ -> ํ๋ก๊ทธ๋จ ๊ฐ์  ์ข๋ฃ

```swift
let x: Optional = try! someThrowingFunction(shoudThrowError: true)
```

#### 28.3.5 ๋ค์ ๋์ง๊ธฐ

- `rethrows` ํค์๋ ์ฌ์ฉ -> ์ต์ ํ๋ ์ด์์ ์ค๋ฅ๊ฐ ๋ฐ์ ๊ฐ๋ฅํ ํจ์๋ฅผ ๋งค๊ฐ๋ณ์๋ก ์ ๋ฌ ๋ฐ์์ผ ํจ
- ์ค์ค๋ก ์ค๋ฅ๋ฅผ ๋์ง์ง ๋ชปํจ == ์์ ์ ๋ด๋ถ์ ์ง์ ์ ์ผ๋ก `throws` ๊ตฌ๋ฌธ ์ฌ์ฉ ๋ถ๊ฐ๋ฅ
- But `catch` ์  ๋ด๋ถ์ `throws` ๊ตฌ๋ฌธ ์์ฑ ๊ฐ๋ฅ

```swift
func someThrowingFunction() throws {
    enum SomeError: Error{
        case justSomeError
    }
    
    throw SomeError.justSomeError
}
//๋ค์ ๋์ง๊ธฐ ํจ์
func someFunction(callback: () throws -> Void) rethrows {
    try callback() //์ค๋ฅ๋ฅผ ๋ค์ ๋์ง๊ธฐ๋ง ํจ (์ฒ๋ฆฌx)
}
do {
    try someFunction(callback: someThrowingFunction) {
        
    }catch{
        print(error)
    }
}
```

#### 28.3.6 ํ์ฒ๋ฆฌ defer

- ํ์ฌ ์ฝ๋ ๋ธ๋ก์ ๋๊ฐ๊ธฐ ์ ์ ๊ผญ ์คํํด์ผ ํ๋ ์ฝ๋ ์์ฑํด์ค ์ ์์
- ์ฝ๋ ๋ธ๋ก์ ๋น ์ ธ๋๊ฐ๊ธฐ ์ ์ ๋ฌด์กฐ๊ฑด ์คํ ๋ณด์ฅ
- `break` `return`  ๊ฐ์ด ๊ตฌ๋ฌธ์ ๋น ์ ธ๋๊ฐ๋ ์ฝ๋๋ ์์ฑ x

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



## ๐CHAPTER29 ๋ฉ๋ชจ๋ฆฌ์์ 

- ์ค์ํํธ๋ ๋ฉ๋ชจ๋ฆฌ๋ฅผ ์๋์ผ๋ก ๊ด๋ฆฌ -> ํ๋ก๊ทธ๋๋จธ๊ฐ ๋ฉ๋ชจ๋ฆฌ ์ ๊ทผ์ ๋ํด ์ ๊ฒฝ ์ธ ํ์x

---

### 29.2 ์์ถ๋ ฅ ๋งค๊ฐ๋ณ์์์์ ๋ฉ๋ชจ๋ฆฌ ์ ๊ทผ ์ถฉ๋

```swift
var step: Int = 1
func increment(_ numberL inout Int){
  number += step
}
increment(&step) //์ค๋ฅ ๋ฐ์!
```

---

### 29.3 ๋ฉ์๋ ๋ด๋ถ์์ self ์ ๊ทผ์ ์ถฉ๋

```swift
struct GamePlayer{
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth(){
        self.health = GamePlayer.maxHealth //์์ ์ธ self์ ์ฅ๊ธฐ์ ์ผ๋ก ์ ๊ทผ
    }
    
    mutating func shareHealth(with teammate: inout GamePlayer){ //๋ค๋ฅธ ์บ๋ฆญํฐ์ ์ธ์คํด์ค๋ฅผ ์์ถ๋ ฅ ๋งค๊ฐ๋ณ์๋ก ๋ฐ์ -> ๋ฉ๋ชจ๋ฆฌ ์ ๊ทผ ์ถฉ๋ ์ฌ์ง ์์
        balance(&teammate.health, &health)
    }
}

var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
oscar.shareHealth(with: &oscar) //์ค๋ฅ๋ฐ์
```

---

### 29.4 ํ๋กํผํฐ ์ ๊ทผ ์ค ์ถฉ๋

- ๋ฉ๋ชจ๋ฆฌ ์์  ๋๋ฌธ์ ๊ตฌ์กฐ์ฒด์ ํ๋กํผํฐ ๋ฉ๋ชจ๋ฆฌ์ ์ ๊ทผํ๋ ํฐ์ด๋ฐ ๊ฒน์น๋ ๊ฒ ๋ฌด์กฐ๊ฑด ์ ํx
- ์ธ ๊ฐ์ง ์กฐ๊ฑด ์ถฉ์กฑํ๋ค๋ฉด ๋ฉ๋ชจ๋ฆฌ ๋์์ ์ ๊ทผํ๋๋ผ๋ ์์ 
  1. ์ฐ์ฐ ํ๋กํผํฐ๋ ํด๋์ค ํ๋กํผํฐ๊ฐ ์๋ ์ธ์คํด์ค์ **์ ์ฅ ํ๋กํผํฐ**์๋ง ์ ๊ทผ
  2. ์ ์ญ๋ณ์๊ฐ ์๋ **์ง์ญ๋ณ์**์ผ ๋
  3. ํด๋ก์ ์์ํด ํ๋ ๋์ง ์์๊ฑฐ๋ ๋นํ์ถ ํด๋ก์ ์ ์ํด์๋ง ํ๋๋์์ ๋