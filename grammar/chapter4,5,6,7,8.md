## &#128210; CHAPTER4 데이터 타입 고급

### 4.1 데이터 타입 안심

- swift는 __안정성__이 높음 -> 타입에 민감

- **데이터 타입 안심** : `Int` 타입 변수에 `Character` 타입을 할당하려하면 __컴파일 에러__ 

​             ->    컴파일 시에 타입을 확인(**타입확인**)을 하기 때문에 데이터 타입을 안심하고 사용 가능

- **타입 추론** : 변수나 상수를 선언할 때, 타입을 명시하지 않아도 컴파일러가 할당된 값을 보고 **타입 결정** 

ex) `var name = "ys"`

---

### 4.2 타입 별칭

- **타입 별칭** : 이미 존재하는 데이터 타입에 임의로 다른 이름(별칭) 부여 ,  `typealias` 키워드

```swift
typealias MyInt = Int //Int타입이고 별칭이 MyInt
let age : MyInt = 100
```

---

### 4.3 튜플

- **튜플** : 타입의 이름이 따로 지정되지 않고 프로그래머 마음대로 만드는 타입

```swift
var person0: (String, Int, Double) = ("ys", 100, 180.0)
print(person0.0) //ys -> 인덱스를 통해 print (각 요소가 어떤 것이 있는지 알기 힘듦)

var person1: (name: String, age: Int, height: Double) = ("ys", 100, 180.0)
print(person1.name) //ys -> 요소 이름으로 print

typealias PersonTuple = (name: String, age: Int, height: Double) //튜플 별칭 지정
var person2: PersonTuple = ("ys", 100, 180.0) 
```

---

### 4.4.1 컬렉션형 - 배열

- **배열** : 같은 타입의 데이터를 일렬로 나열하고 순서대로 저장

```swift
var names1: Array<String> = ["ys","ej","yg"] 
var names2: [String] = ["ys","ej","yg"] //배열 선언 두가지 방법

var emptyArr: [Any] = [Any]()
var emptyArr: [Any] = Array<Any>() //빈 배열 선언 두가지 방법

names1.append("sh") //배열 마지막에 "sh" 추가
names1.insert("sm", at:2) //인덱스 2에 "sm" 삽입
print(names1.firstIndex(of: "ys")) //0
print(names1.first) //ys
print(names1.last) //sh

let firstItem: String = names1.removeFirst() //첫번째요소 삭제
let lastItem: String = names1.removeLast() //마지막요소 삭제
let indexZeroItem: String = names1.remove(at:0) //인덱스 0 삭제

```

---

### 4.4.2 컬렉션형 - 딕셔너리

- **딕셔너리** : 순서없이 키와 값의 쌍으로 구성

- 키값 중복해서 사용x

```swift
typealias StringDictionary = [String: Int] //딕셔너리 별칭
var numberForName: Dictionary<String, Int> = Dictionary<String, Int>() //키는 String, 값은 Int인 딕셔너리 생성

var numberForName: [String: Int] = [String: Int]()
var numberForName: StringDictionary = StringDictionary() //모두 같은 표현

var numberForName: [String: Int] = ["ys":100, "ej":50]
print(numberForName["ys"]) //100
print(numberForName.removeValue(forValue: "ys")) //100 -> 삭제됨
```

---

### 4.4.3 컬렉션형 - 세트

- **세트** : 같은 타입의 데이터를 순서없이 하나의 묶음으로 저장
- 중복된 값이 존재x 
- 순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우에 사용
- 배열과 달리 **축약형**이 없음 /  `Set<Int>` -> `[Int]` (x)
- 모두 유일하기 때문에 교집합, 합집합 등 **집합 관계**를 표현할 때 유용

```swift
var names: Set<String> = Set<String>()
var names: Set<String> = [] //빈 세트 생성

var num: Set<Int> = [1,2,3]
num.insert(4)
print(num.remove(2)) //2 -> 삭제됨

let englishStudents: Set<String> = ["ys","ej"]
let koreanStudents: Set<String> = ["ej","sm"]
//교집합 -> {"ej"}
let intersectSet: Set<String> = englishStudents.intersection(koreanStudents) 

//여집합 -> {"ys","sm"}
let symmetricDiffSet: Set<String> = englishStudents.symmetricDifference(koreanStudents)

//합집합 -> {"ys", "ej", "sm"}
let unionSet: Set<String> = englishStudents.union(koreanStudents)

//차집합 -> {"ys"}
let subtractSet: Set<String> = englishStudents.substracting(koreanStudents)

print(koreanStudents.isDisjoint(with:unionSet)) //false -> 서로 배타적인지
print(koreanStudents.isSubSet(with:unionSet)) //true -> koreanStudents가 unionSet의 부분집합인지
print(unionSet.isSuperset(with:koreanStudents)) //true -> unionSet이 koreanStudents의 전체집합인지
```

---

### `randomElement()`,  `shuffle()` ,`shuffled()`

- `randomeElement()` : 컬렉션에서 임의의 요소 추출

- `shuffle()` : 컬렉션의 요소를 임의로 섞음

- `shuffled()` : 자신의 요소는 그대로 두고 새로운 컬렉션에 순서를 섞음

---

### 4.5 열거형

- **열거형** : 연관된 항목을 묶어서 표현할 수 있는 타입
- 프로그래머가 정의해준 항목 외에는 추가/수정 **불가능**
- 각 열거형이 고유의 타입으로 인정 
- `enum` 키워드

 ```swift
enum School{
    case primary
    case elementary
    case middle
    case high
}

enum School{
    case primary, elementary, middle, high
}
var level: School = School.primary
level = School.high //같은 타입인 School 내부 항목으로만 값 변경 가능
 ```

- ### 원시값

  - 항목의 원시값 가질 수 있음 -> 즉 특정 타입으로 지정된 값을 가질 수도 있음
  - `rawValue` 를 통해 원시값을 가져옴

  ```swift
  enum School: String{
      case primary = "유치원"
      case elementary = "초딩"
      case middle = "중딩"
      case high = "고딩"
  }
  let level: School = School.high
  print(level.rawValue) //고딩
  
  let level: School = School(rawValue:"고딩") //원시값이 "고딩"인 high
  ```

- ### 연관값

  - 각 항목 옆에 소괄호로 묶어 표현 / 모든 항목이 연관 값을 가질 필요x

  ```swift
  enum MainDish{
      case pasta(taste: String)
      case pizza(dough: String, topping: String)
      case rice
  }
  var dinner: MainDish = MainDish.pizza("치즈크러스트","마요네즈")
  ```

- ### 항목 순회

  - 열거형에 포함된 모든 케이스를 알아야 할 때

  - 열거형 이름 뒤에 `: CaseIterable` 

  - but 플랫폼 별로 사용조건을 추가하거나 열거형의 케이스가 연관 값을 가지는 경우 

    ​	-> allCases프로퍼티 사용x **직접 allCases 구현**해야함

  ```swift
  enum School: CaseIterable{
      case primary
      case elementary
      case middle
      case high
  }
  let allCases: [School] = School.allCases
  print(allCases) //[School.primary,School.elementary,School.middle, School.high ]
  ```

- ### 순환 열거형

  - 열거형의 항목의 연관 값이 열거형 자신의 값이고자 할 때 사용
  - `indirect` 키워드 / 특정 항목에 한정하고 싶으면 `case` 키워드 앞에 or 열거형 전체가 적용하고 싶으면 `enum` 키워드 앞에

  - 순환 알고리즘을 구현할 때 유용  

  ```swift
  
  
  ```

- ### 비교가능한 열거형

  - 앞에 위치한 케이스가 **더 작은 값**으로 비교 가능

  - `:Comparable` 키워드



## &#128210; CHAPTER5 연산자

| 분류            | 설명                          | 예    |
| --------------- | ----------------------------- | ----- |
| **단항 연산자** | 피연산자가 한 개인 연산자     | !A    |
| **이항 연산자** | 피연산자가 두 개인 연산자     | A+B   |
| **삼항 연산자** | 피연산자가 세 개인 연산자     | A?B:C |
| **전위 연산자** | 연산자가 피연산자 앞에 위치   | !A    |
| **중위 연산자** | 연산자가 피연산자 사이에 위치 | A+B   |
| **후위 연산자** | 연산자가 피연산자 뒤에 위치   | A!    |

---

### 5.1.1 할당 연산자

- `A=B` : A에 B값 할당

---

### 5.1.2 산술 연산자

- `A+B` / `A-B` / `A*B` / `A/B` / `A%B`

---

### 5.1.3 비교 연산자

- `A == B` / `A >= B` / `A<= B` / `A>B` /` A<B` / `A!=B` / `A === B` : 같은 인스턴스인지 비교 / `A !== B` / `A ~= B` : A와 B가 패턴이 매치되는지 확인하여 불리언 값 반환

---

### 5.1.4 삼항 조건 연산자

- `question ? A : B` : 참이면 A, 거짓이면 B 반환

---

### 5.1.5 범위 연산자

- `A...B` : A이상 B이하
- `A.. <B` : A이상 B미만
- `A...` : A이상
- `...A` : A이하
- `..<A` : A미만

---

### 5.1.6 부울 연산자

- `!B` : B의 불리언 값의 참, 거짓 반전
- `A && B` : A와 B의 불리언 AND 논리 연산 실행
- `A || B` : A와 B의 불리언 OR 논리 연산 실행

---

### 5.1.7 비트 연산자

- `~A` : A의 비트를 반전한 결과를 반환
- `A & B` :  A와 B의 비트 AND 논리 연산 실행
- `A | B` :  A와 B의 비트 OR 논리 연산 실행
- `A ^ B` :  A와 B의 비트 XOR 논리 연산 실행
- `A >> B` / `A << B` : A의 비트를 B만큼 비트 이동

---

### 5.1.8 복합 할당 연산자

- `A += B` / `A-=B` / `A*=B` / `A /=B` / `A%=B` / `A<<= N` / `A &= B` / `A |= B` / `A ^= B`

---

### 5.1.9 오버플로우 연산자

- 기본연산자로 오버플로우 대비 가능
- `UInt8` 타입을 사용할 때 음의 정수로 선언해도 오버플로 빼기 연산을 사용하면 오류 없이 오버플로 처리
- `&+` / `&-` / `&*`

---

### 5.1.10 기타 연산자

- `A ?? B` : A가 nil이 아니면 A를 반환, nil이면 B반환
- `-A` : A의 부호 변경
- `O!` : 옵셔널값을 강제로 추출
- `V?` : 옵셔널값을 안전하게 추출하거나 V가 옵셔널임을 표현

---

### 5.2 연산자 우선순위 결합방향

- 스위프트는 연산자 우선순위를 지정 -> 우선순위가 높은 연산자가 낮은 연산자보다 먼저 실행
- 연산자가 연산하는 결합방향도 지정됨
- `higherThan` , `lowerThan`, `associactivity` 로 우선순위 및 결합 방향 지정

```swift
let intValue: Int = 1
let resultValue1: Int = intValue << 3 + 5 //비트 연산자가 우선순위가 높기 때문에 8+5 =13
let resultValue2: Int = intValue*3 + 5 //*연산자가 먼저 실행 3+5 = 8
```

---

### 5.3 사용자 정의 연산자

- #### 전위 연산자 정의와 구현

  - `prefix` 키워드

  ```swift
  prefix operator **
  prefix func **(value:Int)->Int{
      return value*value
  }
  let five: Int = 5
  let value: Int = **five //25
  ```



- #### 후위 연산자 정의와 구현

  - `postfix` 키워드

  ```swift
  postfix operator **
  postfix func **(value: Int) -> Int{
      return value + 10
  }
  let five: Int = 5
  let value: Int = five** //15
  ```



- #### 중위 연산자 정의와 구현

  - **우선순위 그룹** 명시 가능

  ```swift
  precedencegroup 우선순위그룹이름 {
      higherThan : 더 낮은 우선순위 그룹 이름
      lowerThan : 더 높은 우선순위 그룹 이름
      associactivity : 결합방향 (left/right/none)  //결합방향이 없는 부등호 연산자는 연속적으로 사용x (1<2<3)
      assignment : 할당방향 사용 (true/false) //옵셔널체이닝 관련 (true면 옵셔널 체이닝을 할 때 오른쪽부터 체이닝)
  }
  ```

  - `infix` 키워드

  ```swift
  infix operator ** : MultiplicationPrecedence //우선순위그룹 MultiplicationPrecedence
  func **(value1: Int, value2: Int)->Int{
      return value1*value2 + 10
  }
  let five: Int = 5
  let three: Int = 3
  let result: Int = value1 ** value2 //25
  ```





## &#128210; CHAPTER6 흐름 제어

- 소괄호는 생략 가능하나 중괄호는 생략x

### 6.1.1 조건문 - if 구문

- if 구문의 조건 값이 꼭 **Bool 타입**이어야함
- 조건을 충족하면 바로 if문 빠져나옴

```swift
let first: Int = 5
let second: Int = 8
if first < second {
    print("first<second")
}else if first > second{
    print("first>second")
}else{
    print("first==second")
}
```

---

### 6.1.2  조건문 - switch 구문

- `break` 키워드 선택 사항 / 안써도 알아서 실행 
- 만약 `break` 하지 않고 연속으로 실행하고 싶다면 `fallthrough` 키워드 사용
- 열거형 값이 아니면 꼭 `default` 작성
- 부동소수타입, 문자열, 튜플 다 사용 가능
- 미리 지정된 조건 값을 제외하고 다른 값을 실행문 안으로 가져오기 가능

```swift
let tupleValue : (name: String, age: Int) = ("ys", 24)
switch tupleValue{
    case ("ys",10):
    	print("정확합니다")
    case("ys", let age):
    	print("이름만 맞았습니다 \(age)살입니다")
    case(let name, 24):
    	print("나이만 맞았습니다 \(name)입니다")
    default:
    	print("누굴찾나요?")
}
```

- 열거형에서 case가 추가될 가능성이 있다면? -> 와일드카드 case(`case_`) 와 `unknown` 속성 사용

```swift
enum Menu{
    case chicken
    case pizza
}
let lunchMenu: Menu = .pizza
switch lunchMenu{
    case .chicken:
    	print("무주지마세요")
    case .pizza:
    	print("피클주지마세요")
    @unknown case _:  //unknown속성 사용 -> 해당 구문이 모든 case에 대응하지 않음을 알 수 있음
    	print("오늘메뉴뭐죠?")
}
```

---

### 6.2.1 반복문 - for-in 구문

```swift
for i in 1..3{
    print(i)
}

var result: Int =10
for _ in 0..2{ //시퀀스에 해당하는 값이 필요없다면 와일드카드 식별자 사용
    result += 1
}
```

---

### 6.2.2 반복문 - while 구문

```swift
var names: [String] = ["ys","ej","sm"]
while names.isEmpty == false{
    print("bye \(names.removeFirst())")
}
```

---

### 6.2.3 반복문 - repeat-while 구문

```swift
var names: [String] = ["ys","ej","sm"]
repeat{
     print("bye \(names.removeFirst())")
}while names.isEmpty == false
```

---

###  6.3 구문 이름표

- `break` 키워드나 `continue` 키워드를 쓸 때 어느 구문에 해당하는지 헷갈려 사용
- `구문이름:` 으로 사용

```swift
var number: [Int] = [1,2,3,4,5]
numbersLoop: for num in numbers{
    if(num>3)
    	continue numbersLoop
    
    removeLoop: while true{
        if numbers.first != num{
            break numbersLoop
        }
        numbers.removeFirst()
    }
}
```



## &#128210; CHAPTER7 함수

### 7.1 함수와 메소드

- **메소드** : 특정 타입에 연관되어 사용하는 함수
- **함수** : 모듈 전체에 전역적으로 사용할 수 있는 함수

---

### 7.2 함수의 정의와 호출

- 함수에서 소괄호 생략 불가
- 오버라이드와 오버로드 모두 지원
- 함수 내부 코드가 단 한줄이고 결과값의 타입이 함수의 반환 타입과 일치하면 `return` 키워드 생략 가능

#### 매개변수

- 매개변수가 필요 없다면 매개변수 위치 공란으로 비워도 됨

```swift
func introduce(name: String)->String{
    "이름은"+name //return 생략
}
func helloworld()-> String{ //매개변수 비워도됨
    return "hello world" 
}
```

- **전달인자 레이블** : 함수 내부에서 전달인자 레이블 사용x 
- **와일드카드 식별자**를 이용해 전달 인자 레이블을 사용하지 않을 수 있음 
- 전달인자 레이블만 다르게 사용해도 **오버로드(중복정의)** 가능

```swift
func sayHello(from myName: String, to name:String){ //전달인자 레이블 : from, to
    return "hello \(name) I'm \(myName)"
}
print(sayHello(from: "ys", to: "sm"))

func sayHello(_ myName: String,_ name:String){ //전달인자 레이블을 _로
    return "hello \(name) I'm \(myName)"
}
print(sayHello("ys", "sm"))
```

- 매개변수 **기본 값** 지정 가능

```swift
func sayHello(myName: String="ys", name:String){ //myName 기본값 "ys"
    return "hello \(name) I'm \(myName)"
} 
```

- **가변 매개변수** : 0개 이상의 값을 받아올 수 있음 / 함수마다 가변 매개변수는 한개만 가질 수 있음

```swift
func sayHello(myName: String, names:String...){ //가변매개변수 name
    for name in names{
        print("hello \(name) I'm \(myName)")
    }
}
```

- **inout 매개변수** : 값을 복사가 아닌 참조함 (C언어의 포인터와 유사) / 전달될 변수 또는 상수 앞에 `&` 붙임

```swift
var numbers: [Int] = [1,2,3]
func referenceParameter(_ arr: inout[Int]){ //inout 매개변수
    arr[1] = 5
}
 referenceParameter(&numbers)
print(numbers[1]) //5
```



#### 반환이 없는 함수

``` swift
func sayHello(){ //void 생략가능
    print("hello")
}
func sayHello()->Void{
    print("hello")
}
```

#### 데이터 타입으로서의 함수

- 스위프트의 함수는 **일급 객체**이므로 하나의 데이터 타입으로 사용 가능-
- 함수를 **전달인자**로 받거나 **리턴값으로** 돌려주기 가능

```swift
typealias CalculateInt = (Int, Int) -> Int //함수 타입 사용
func addInts(_ a:Int, _ b: Int) -> Int{
    return a+b
}
func mulInts(_ a:Int, _ b: Int) -> Int{
    return a*b
}
var mathFunction: CalculateInt = addInt 

func printMathResult(_ mathFunction: CalculateInt, _ a:Int, _ b: Int){ //함수를 매개변수로
    print(mathFunction(a,b))
}

func chooseMathResult(_ toAdd: Bool)-> CalcaulateInt{ //함수를 리턴
    return toAdd ? addInts : mulInts 
}

```

---

### 7.3 중첩 함수

- 함수안에 함수를 넣을 수 있음
- 중첩 함수를 담은 함수가 중첩 함수를 반환하면 외부에서도 사용 가능

```swift
typelias MoveFunc = (Int) -> Int
func functionMove(_ shouldGoLeft: Bool) -> MoveFunc{
    func goLeft(_ current: Int) -> Int{
        return current - 1
    }
    func goRight(_ current: Int) -> Int{
        return current + 1
    }
    return shouldGoLeft ? goLeft : goRight
}
```

---

### 7.4 종료되지 않는 함수

- = 비반환 메소드 / 비반환 함수
- 반환 타입을 `Never` 로 명시
- 대표적으로 `fatalError` 함수

---

### 7.5 반환 값을 무시할 수 있는 함수

- 프로그래머가 **의도적으로** 반환 값을 사용하지 않을 때 반환 값을 무시해도 된다는 `discardableResult` 선언 사용

```swift
@discardableResult func resultSay(_ something: String) -> String{
    print(something)
    return something
}
resultSay("say") //반환값을 사용하지 않아도 컴파일러가 경고하지 않음
```





## &#128210; CHAPTER8 옵셔널

- **안정성**을 담보하는 기능

### 8.1 옵셔널 사용

- 옵셔널 변수 또는 상수가 아니면 `nil` 할당 불가능

- **물음표**를 붙여서 옵셔널 선언
- 왜 변수에 `nil`이 있다고 가정? -> 전달인자의 값이 잘못된 값인 경우 처리못했음을 nil로 반환해 **오류가 있음**을 알림 / 매개변수가 옵셔널인 것을 보고 이 매개변수는 값이 없어도 됨을 바로 알 수 있음(**암묵적 커뮤니케이션)**

```swift
//옵셔널 열거형의 정의
public enum Optional<Wrapped>: ExpressibleByNilLiteral{
    case none //nil일 때
    case some(Wrapped) //값이 있을 때 -> some의 연관 값인 Wrapped에 값이 할당
    public int(_ some: Wrapped)
}
```

- switch문으로 옵셔널 값을 확인할 수 있음 but 더 안전하고 편리하게 추출하는 방법 o

---

### 8.2 옵셔널 추출

- #### 강제 추출

  - 가장 간단하지만 가장 위험한 방법 -> **런타임 오류**가 일어날 가능성이 높기 때문
  - 강제 추출 시 옵셔널에 값이 없다면(=`nil`이라면) 바로 런타임 에러

  ```swift
  var myName: String? = "ys"
  var youngSun: String = myName!
  
  myName = nil
  youngSun = myName //런타임 에러 (myName이 nil이기 때문)
  ```

- #### 옵셔널 바인딩

  - `if` 나 `while` 구문을 통해 옵셔널에 값이 있는지 확인
  - 조금 더 **안전**하고 **세련**됨

  ```swift
  var myName: String? = "ys"
  if let name = myName{ //옵셔널 바인딩 
      print("My name is \(name)") //nil이 아닐 때
  }else{
      print("My name is nil") //nil일때
  }
  ```

- #### 암시적 추출 옵셔널

  - nil을 할당 하고 싶지만 매번 옵셔널 바인딩으로 값을 추출하기 귀찮을 때 사용
  - nil때문에 런타임 에러가 발생하지 않을 것이라는 **확신**이 있을 때 사용
  - 사용 지양

  ```swift
  var myName: String! = "ys"
  ```

  