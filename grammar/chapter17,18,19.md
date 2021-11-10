## &#128210;CHAPTER17 서브스크립트

- 서브스크립트 : 클래스와 구조체 열거형이 타입의 요소에 접근하는 단축 문법
- `setter` / `getter` 메서드 구현 안해도 인덱스를 통해 값을 가져올 수 있음
- 서브스크립트 중복 정의 가능 (여러 개 구현)

- 입출력 매개변수 inout 은 못가짐

---

### 17.2 서브스크립트 구현

```swift
import UIKit

var str = "Hello, playground"

struct Student{
    var name: String
    var number: Int
}

class School{
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String){
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    func addStudents(names: String ...){
        for name in names{
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int = 0) -> Student? {
        if index < self.number{
            return self.students[index]
        }
        return nil
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "ys", "ej", "sm", "sh")
let student: Student? = highSchool[1] //학생1 ej
print("\(student?.number) \(student?.name)") //Optional(1) Optional("ej")
print(highSchool[]?.name) //Optional("ys") -> 기본값이 0이기 때문에 학생0 ys
```

---

### 17.3 복수 서브스크립트

- 하나의 타입이 여러개의 서브스크립트를 가질 수 있음 (다양한 매개변수 타입으로)

---

### 17.4 타입 서브스크립트

- 인스턴스가 아니라 타입 자체에서 사용할 수 있는 서브스크립트
- `static` 키워드 
- 클래스의 경우 `class` 키워드

```swift
//타입 서브스크립트
enum School: Int{
    case elementary = 1, middle, high, uiversity
    
    static subscript(level: Int) -> School? {
        return School(rawValue: level)
    }
}

let school: School? = School[2]
print(school) //School.middle
```



## &#128210;CHAPTER 18 상속

### 18.1 클래스 상속

- 다른 클래스를 상속하면 부모 클래스의 프로퍼티와 메소드 그대로 사용 가능 -> 다시 작성할 필요 없으니 용이

```swift
class Person{
    var name: String = ""
    var age: Int = 0
    
    var introduction: String{ //연산 프로퍼티
        return "이름:\(name) 나이:\(age)"
    }
    func speak(){
        print("가나다라마")
    }
}

class Student: Person{ //Person의 자식클래스 Student -> Person의 프로퍼티와 메소드 사용 가능
    var grade: String = "F"
    func study(){
        print("Study hard")
    }
}

let person: Person = Person()
person.name = "ys"
person.age = 24
print(person.introduction) //이름:ys 나이:24

let student: Student = Student()
student.name = "ej"
student.age = 25
student.grade = "A"
print(student.speak()) //가나다라마 -> Person의 메소드 사용
print(student.study()) //Study hard
```

---

### 18.2 재정의

- 부모클래스의 특성을 그대로 사용하지 않고 기능을 변경하여 사용하는 것 
- `override` 키워드
- 재정의 했지만 필요에 따라 부모 클래스의 특성을 사용하고 싶다면? -> `super` 키워드 사용

```swift
class Person{
    var name: String = ""
    var age: Int = 0
    
    var introduction: String{
        return "이름:\(name) 나이:\(age)"
    }
    func speak(){
        print("가나다라마")
    }
    
    class func introduceClass() -> String{
        return "hi class"
    }
}

class Student: Person{ //Person의 자식클래스 Student
    var grade: String = "F"
    func study(){
        print("Study hard")
    }
    
    override func speak() { //override 키워드를 이용하여 재정의
        print("난 학생")
    }
    
    class func introClass(){
        print(super.introduceClass()) //super키워드로 Person의 introduceClass 사용
    }
}

let student: Student = Student()
print(Student.introClass()) //hi class
student.speak() //난 학생
```

#### 18.2.2 프로퍼티 재정의

- 인스턴스 프로퍼티나 타입 프로퍼티 재정의 가능 -> `setter`  /` getter`  / 프로퍼티 감시자 재정의 한다는 뜻
- 저장 프로퍼티는 재정의x
- 부모클래스의 프로퍼티와 이름과 타입이 일치해야함
- 읽기 전용 프로퍼티 -> 읽기 쓰기 프로퍼티 (o)   /    읽기 쓰기 프로퍼티 -> 읽기 전용 프로퍼티 (x)

```swift
class Person{
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int{ //읽기만 가능한 연산 프로퍼티
        return self.age+1
    }
}

class Student: Person{
    var grade: String = "F"
    
    override var koreanAge: Int{ //읽기쓰기 가능한 연산 프로퍼티로 재정의
        get{
            return super.koreanAge //super 키워드를 사용하여 get은 부모 클래스 그대로 사용
        }
        set{
            self.age = newValue - 1
        }
    }
}

let person: Person = Person()
person.age = 24
//person.koreanAge = 25 //error
print(person.koreanAge) //25

let student: Student = Student()
student.age = 24
student.koreanAge = 27
print(student.age) //26
```

#### 18.2.3 프로퍼티 감시자 재정의

- 상수 저장 프로퍼티나 읽기전용 연산 프로퍼티는 프로퍼티 감시자 재정의 불가능

- 부모 클래스의 프로퍼티 감시자도 같이 동작함
- 프로퍼티 접근자와 감시자는 동시에 재정의 불가능

```swift
class Person{
    var name: String = ""
    var age: Int = 0{
        didSet{
            print("Person age \(self.age)")
        }
    }
    var koreanAge: Int{
        return self.age+1
    }
}

class Student: Person{
    override var age: Int{
        didSet{
            print("Student age \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get{
            return super.koreanAge
        }
        set{
            self.age = newValue - 1
        }
    }
}

let student: Student = Student()
student.name = "ys"
student.age = 24
//Person age 24 -> 부모 클래스의 프로퍼티 감시자도 동작하기 때문에 p339
//Student age 24

student.koreanAge = 15
//Peson age 14
//Student age 14
```

#### 18.2.4 서브스크립트 재정의

- 부모클래스의 서브스크립트의 매개변수와 리턴타입이 같아야함

```swift
class School{
  var students: [Student] = [Student]()
  
  subscript(number: Int) -> Student{
    print("School subscript")
    return students[number]
  }
}

class MiddleSchool: School{
  var middleStudents: [Student] = [Student]()
  
  override subscript(index: Int) -> Student{
    print("middleSchool")
    return middleStudents[index]
  }
}
```

#### 18.2.5 재정의 방지

- `final` 키워드 -> 재정의 할 수 없도록 제한

```swift
final class Person{
  final var name: String = ""
}
class Student: Person{ //error 
  
}
```

---

### 18.3 클래스의 이니셜라이져

- __지정 이니셜라이저__ : 부모클래스의 이니셜라이저 호출 가능, 클래스의 모든 프로퍼티 초기화해야 함, 클래스에 하나 이상 정의해야함 (부모클래스의 지정 이니셜라이저가 역할 충분히 하면 자식클래스는 없어도 됨)
- __편의 이니셜라이저__ : 초기화를 좀 더 쉽게 도와주는 역할, 지정 이니셜라이저를 내부에서 호출, 필수요소x 

```swift
init(매개변수){ //지정 이니셜라이저
  
}
convenience init(매개변수){ //편의 이니셜라이저
  
}
```

- 3가지 규칙
  - 자식클래스의 지정 이니셜라이저는 __부모클래스의 지정 이니셜라이저__를 반드시 호출해야함
  - 편의 이니셜라이저는 __자신을 정의한 클래스의 다른 이니셜라이저__를 반드시 호출해야함
  - 편의 이니셜라이저는 __지정 이니셜라이저__를 호출 해야 함

#### 18.3.3 2단계 초기화

- 프로퍼티를 초기화 하기 전에 값에 접근하는 것을 막음

- 1단계 : 클래스에 정의한 저장 프로퍼티 초기값 할당

- 2단계 : 저장 프로퍼티들을 사용자 정의할 수 있음

- __2단계 초기화__를 오류없이 처리하기 위해 -> __안전확인 4단계__

  1. 자식클래스의 지정 이니셜라이저가 부모클래스의 이니셜라이저를 호출하기 전에 자신의 프로퍼티 모두 초기화

  2. 자식클래스의 지정 이니셜라이저는 상속받은 프로퍼티에 값을 할당하기 전에 반드시 부모클래스의 이니셜라이저 호출
  3. 편의 이니셜라이저는 프로퍼티 값 할당 전에 다른 이니셜라이저 호출
  4. 초기화 1단계를 마치기 전까지 이니셜라이저는 인스턴스 메서드 호출x 인스턴스 프로퍼티값 읽기x

#### 18.3.4 이니셜라이저 상속 및 재정의

```swift
class Person{
  var name: String
  var age: Int
  
  init(name: String, age: Int){
    self.name = name
    self.age = age
  }
  
  convenience init(name: String){
    self.init(name: name, age: 0)
  }
}

class Student: Person{
  var major: String
  
  override init(name: String, age: Int){ //지정이니셜라이저 -> override 수식 붙임
    self.major = "swift"
    super.init(name: name, age: age)
  }
  
  convenience init(name: String){ //편의이니셜라이저 -> 부모클래스의 편의이니셜라이저와 동일하기 때문에 안붙임
    self.init(name: name, age: 7)
  }
}
```

#### 18.3.5 이니셜라이저 자동 상속

- 기본적으로 이니셜라이저는 부모클래스의 이니셜라이저를 상속x
- 자식클래스에서 지정 이니셜라이저를 구현하지 않거나 / 부모클래스의 지정 이니셜라이저를 모두 재정의한 경우 -> 자동 상속

#### 18.3.6 요구 이니셜라이저

- `required` 수식어
- 반드시 재정의 해야하는 이니셜라이저

```swift
class Person{
  var name: String
  required init(){ //요구 이니셜라이저
    self.name="us"
  }
}
```



## &#128210;CHAPTER19 타입캐스팅

### 19.3 데이터 타입 확인

- 인스턴스의 타입을 확인 : `is` 연산자

```swift
let coffee: Coffee = Coffee(shot: 1)
let ame: Americano = Americano(shot:2, iced: false)
print(coffee is ame) //false
print(ame is coffee) //true -> Coffee 클래스가 부모이기때문에
```

- 메타 타입 : 타입의 타입 / `.Type` / ex) `let intType: Int.Type = Int.self //Int`

---

### 19.4 다운캐스팅

- 자신의 다른 타입을 다른 인스턴스인 척 할 수 있음
- 부모클래스의 타입을 자식클래스의 타입으로 캐스팅하는 것 -> 다운캐스팅
- `as!` / `as?` 

```swift
//다운캐스팅
class Coffee{
    let name: String
    let shot: Int
    
    var description: String{
        return "\(shot)shot \(name)"
    }
    
    init(shot: Int){
        self.shot = shot
        self.name = "coffee"
    }
}

class Lattee: Coffee{
    var flavor: String
    override var description: String{
        return "\(shot)shot \(flavor)lattee"
    }
    
    init(flavor: String, shot: Int){
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americano: Coffee{
    let iced: Bool
    
    override var description: String{
        return "\(shot)shot \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool){
        self.iced = iced
        super.init(shot: shot)
    }
}

let coffee: Coffee = Coffee(shot: 1)
let americano: Americano = Americano(shot: 2, iced: true)

if let _: Americano = coffee as? Americano{ //1shot coffee -> 다운캐스팅 실패
    print("americano!")
}else{
    print(coffee.description)
}

if let _: Coffee = americano as? Coffee{ //coffee! -> 다운캐스팅 성공
    print("coffee!")
}else{
    print(americano.description)
}
```

---

### 19.5 Any, AnyObject의 타입캐스팅

- 클래스의 인스턴스만 수용가능 - `AnyObject`

- 모든 타입 가능 - `Any`

