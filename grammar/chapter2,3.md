## &#9997; CHAPTER2 스위프트 처음 시작하기

### 기본 명명규칙
유니코드에서 지원하는 어떤 문자라도 사용 가능 but 예외 존재 

__예외__
- 스위프트에서 미리 정한 예약어나 키워드
- 해당 코드 내에서 이미 사용된 이름
- 연산자로 사용될 수 있는 기호(*,/,+,-)
- 숫자로 시작하는 이름
- 공백이 포함된 이름
---
### 콘솔로그
__로그__ : 애플리케이션의 상태 or 내부 로직 흐름을 관찰할 수 있도록 출력한 정보  
__콘솔로그__ : 디버깅 중 디버깅 콘솔에 보여줄 로그

- ### print()함수
콘솔로그를 남기는 용도
줄바꿈 자동으로 삽입
dump()함수도 존재 -> 인스턴스의 자세한 내부 콘텐츠도 출력

- ### 문자열 보간법
변수나 상수 등의 값을 문자열 내에 나타내고 싶을 때 사용
```swift
 let name:String = "ys"
  print("My name is \(name)")
```
---

### 주석
프로그램 소스코드에 정보를 남기는 목적으로 사용
__퀵헬프__ : option키 + 클릭
```swift
//한줄 주석
/*
여러줄 
주석
*/
```
```swift
//퀵 헬프를 위한 마크업
/// 한줄 주석은 슬래시 3개
/**
여러줄 주석은 별 2개
마크업 문법과 동일**/
```
---

### 변수와 상수
__변수와 상수__ 이용 -> 프로그램에서 사용되는 데이터를 메모리에 임시로 저장
__변수와 상수__는 특정 데이터 타입에 해당되는 값의 이름
- ### 변수
값 변경 가능
__var 키워드__ 사용
var 변수명 : 데이터 타입 = 값   
ex)var name : String = "ys"
```swift
var name: String = "ys"
var age = 100 //타입 추론 사용 -> 자주 사용하지 않는 것 권장
age = 99 // 값 변경 가능
```
- ### 상수
값 변경 불가능
let 키워드 사용
차후 변경 값을 신경쓰지 않아도 됨 -> 가독성 좋음
```swift
let name : String = "ys"
name = "YS" //값 변경 불가능 에러 발생
```

---  
  
## &#9997; CHAPTER3 데이터 타입 기본

__데이터 타입__ : 프로그램 내에서 다뤄지는 데이터 종류
스위프트의 기본 데이터 타입은 모두 __구조체__를 기반으로 구현
모든 데이터 타입의 이름은 첫글자가 대문자 -> __대문자 카멜케이스__

### Int와 UInt
- __Int__ : +,- 부호 포함한 정수 / Int8, Int16, Int32, Int64 
- __UInt__ : - 부호를 포함하지 않는 0을 포함한 정수 / UInt8, UInt16, UInt32, UInt64
- 같은 정수라도 Int와 UInt는 다른 타입으로 인식
```
var integer: Int = -100
var unsignedInteger: UInt = 50
integer = unsignedInteger // 다른타입이므로 에러
integer = Int(unsignedInteger)
```

- 10진수 : 평소에 쓰던 것과 동일하게 작성
- 2진수 : 접두어 0b 사용
- 8진수 : 접두어 0o 사용
- 16진수 : 접두어 0x 사용

---

### Bool
- 참 또는 거짓만으로 값을 가짐
```
var boolean: Bool = true
boolean.toggle() //true/false값 반전
```
---

### Float와 Double
- Float와 Double은 __부동소수 타입__
- __Float__ : 6자리의 숫자 표현 / 32비트 부동소수 표현
- __Double__ : 최소 15자리 십진수 표현 / 64비트 부동소수 표현
```
var floatValue: Float = 1234567890.1 //감당할 수 있는 만큼만 남겨 정확도가 떨어짐
let doubleValue: Double = 1234567890.1 //충분히 수용
```

#### 임의의 수 만들기 -> __random(in:)메소드__

---

### Character
- 문자의 집합이 아니라 단 하나의 문자
```
let alphabet:Character = "A"
```

---

### String
- 문자열, 값의 앞뒤에 큰따옴표 사용
```
let name: String = "ys"
var introduce: String = String() //빈 문자열 생성
introduce.append("My name is") //append메소드로 이어붙임
introduce = introduce + name //+연산자로 이어붙임
print(name.count) //2  -> 글자 수 셀 수 있음
print(introduce.isEmpty) //false -> 빈 문자열인지 확인
```
```
let hello:String = "Hello"
let ys:String = "ys"
var greeting:String = hello + ys //+연산자로 문자열 결합
var isSameString:Bool = true
isSameString = hello == "hi"
print(isSameString) //false
hello.hasPrefix("He") //true -> hasPrefix메소드로 접두어 확인
hello.hasSuffix("llo") //true -> hasSuffix메소드로 접미어 확인
hello.uppercased() //HELLO -> uppercased메소드로 대문자 변환
hello.lowercased() //hello -> lowercased메소드로 소문자 변환
//여러줄을 문자열 쓰고 싶을 때 큰따옴표 3개 사용
greeting = """
안녕하세요
스위프트공부중
"""
```

 - ### 특수문자
    - __\n__ : 줄바꿈 문자
    - __\\__ : 문자열 내에서 백슬래시 표현
    - __\"__ : 문자열 내에서 큰 따옴표 표현
    - __\t__ : 탭 문자
    - __\0__ : 문자열이 끝났음을 알리는 null문자
    
---
    
### Any, AnyObject와 nil
- __Any__ : 스위프트의 모든 데이터 타입을 사용할 수 있다는 뜻
- __AnyObject__ : Any보다 조금 한정된 의미 / 클래스의 인스턴스만 할당
- 둘 다 사용을 권장x -> 오류의 위험이 증가하기 때문
- __nil__ : 특정 타입x / '없음' 이라는 뜻







