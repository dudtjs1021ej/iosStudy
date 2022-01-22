## 📒섹션2 도서관리프로그램

### 📌 파일구조

```bash
└── BookManager
    ├── BookManager
    │   ├── Book.swift
    │   ├── BookManager.swift
    │   └── main.swift
    └── BookManager.xcodeproj
```

- **Book.swift**
  - <u>`Book` 구조체</u> - `name`, `genre`, `author` 변수
- **BookManager.swift**
  - <u>`BookManager` 클래스</u> - `Book` 배열인 `bookList` 변수 / `showAllBooks`메소드 / `countBooks`메소드 / `searchBook` 메소드 / `removeBook` 메소드 

---

### 📌 문법

#### 배열 선언

```swift
//모두 같은 표현
var bookList = [Book] () //강의에서는 타입추론을 사용
var bookList: Array<Book> = Array<Book>()
var bookList: [Book] = [Book]()
```



#### 배열 요소 추가

```swift
//같은 표현
bookList += [bookObject] //강의에서는 +연산자 사용
bookList.append(bookObject)
```



#### 배열의 enumerated()

- (Index, value) 로 이루어진 튜플 리턴
- 값과 인덱스가 모두 필요할 때 사용

```swift
 func removeBook(name: String){
        for (index, value) in bookList.enumerated(){ //enumerated : 튜플로 인덱스와 값을 넘겨줌
            if value.name == name { //배열의 값 사용
                bookList.remove(at: index) //배열의 인덱스 사용
            }
            
        }
    }
```

