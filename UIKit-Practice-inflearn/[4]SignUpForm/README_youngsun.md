## 📒섹션 5 - 회원 가입 화면 앱

- 이름, 이메일, 비밀번호, 전화번호, 블로그 주소를 입력받는 앱
- 유형별로 써야하는 ` KeyBoard Type` 과 키보드를 내리기 위해 `delegate` 를 사용하는 법을 배운다.

---

### 📌 파일 구조

```swift
├── SignUpForm
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Base.lproj
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── Info.plist
│   ├── SceneDelegate.swift
│   └── ViewController.swift
```

---

### 📌 실행 화면

![image](https://user-images.githubusercontent.com/77915491/128857555-ae2445c8-ec3a-475e-8f98-49bcc2f6322f.png)

---

### 📌 강의 핵심

#### 🔍 프로토콜

- `required` 키워드 - 반드시 구현해야한다



#### 🔍 키보드 타입

- **email TextField** : ` KeyBoard Type` - `E-mail Address` 선택 -> @ 포함된 키보드
- **password TextField**: `Secure Text Entry` 체크 -> 입력 값 보이지 않음
- **Tel TextField** : ` KeyBoard Type` -`Phone Pad`  선택 -> 숫자만 있는 키보드

- **site TextField** : ` KeyBoard Type` - `URL` 선택 -> / .com 포함된 키보드



#### 🔍 delegate 사용

- #### 키보드 내리게 하기 

  1. `UITextFieldDelegate` 채택
  2. **return버튼** 누르면 키보드 내리게 하기 

  ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
  ```

  3. **다른 뷰 클릭** 시 키보드 내리게 하기

  ```swift
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
  ```

  

