## πμΉμ 5 - νμ κ°μ νλ©΄ μ±

- μ΄λ¦, μ΄λ©μΌ, λΉλ°λ²νΈ, μ νλ²νΈ, λΈλ‘κ·Έ μ£Όμλ₯Ό μλ ₯λ°λ μ±
- μ νλ³λ‘ μ¨μΌνλ ` KeyBoard Type` κ³Ό ν€λ³΄λλ₯Ό λ΄λ¦¬κΈ° μν΄ `delegate` λ₯Ό μ¬μ©νλ λ²μ λ°°μ΄λ€.

---

### π νμΌ κ΅¬μ‘°

```swift
βββ SignUpForm
βΒ Β  βββ AppDelegate.swift
βΒ Β  βββ Assets.xcassets
βΒ Β  βΒ Β  βββ AccentColor.colorset
βΒ Β  βΒ Β  βΒ Β  βββ Contents.json
βΒ Β  βΒ Β  βββ AppIcon.appiconset
βΒ Β  βΒ Β  βΒ Β  βββ Contents.json
βΒ Β  βΒ Β  βββ Contents.json
βΒ Β  βββ Base.lproj
βΒ Β  βΒ Β  βββ LaunchScreen.storyboard
βΒ Β  βΒ Β  βββ Main.storyboard
βΒ Β  βββ Info.plist
βΒ Β  βββ SceneDelegate.swift
βΒ Β  βββ ViewController.swift
```

---

### π μ€ν νλ©΄

![image](https://user-images.githubusercontent.com/77915491/128857555-ae2445c8-ec3a-475e-8f98-49bcc2f6322f.png)

---

### π κ°μ ν΅μ¬

#### π νλ‘ν μ½

- `required` ν€μλ - λ°λμ κ΅¬νν΄μΌνλ€



#### π ν€λ³΄λ νμ

- **email TextField** : ` KeyBoard Type` - `E-mail Address` μ ν -> @ ν¬ν¨λ ν€λ³΄λ
- **password TextField**: `Secure Text Entry` μ²΄ν¬ -> μλ ₯ κ° λ³΄μ΄μ§ μμ
- **Tel TextField** : ` KeyBoard Type` -`Phone Pad`  μ ν -> μ«μλ§ μλ ν€λ³΄λ

- **site TextField** : ` KeyBoard Type` - `URL` μ ν -> / .com ν¬ν¨λ ν€λ³΄λ



#### π delegate μ¬μ©

- #### ν€λ³΄λ λ΄λ¦¬κ² νκΈ° 

  1. `UITextFieldDelegate` μ±ν
  2. **returnλ²νΌ** λλ₯΄λ©΄ ν€λ³΄λ λ΄λ¦¬κ² νκΈ° 

  ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
  ```

  3. **λ€λ₯Έ λ·° ν΄λ¦­** μ ν€λ³΄λ λ΄λ¦¬κ² νκΈ°

  ```swift
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
  ```

  

