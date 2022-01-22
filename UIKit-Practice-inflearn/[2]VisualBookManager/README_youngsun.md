## 📒섹션3 - 비쥬얼 도서 관리 앱

### 📌 파일 구조 

```bash
.
├── VisualBookManager
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
│   ├── Book.swift
│   ├── BookManager.swift
│   ├── Info.plist
│   ├── SceneDelegate.swift
│   └── ViewController.swift
```

---

### 📌 실행 화면

![image](https://user-images.githubusercontent.com/77915491/128832195-81be2ee5-8b75-4188-80ba-2165f3acdeb0.png)

---

### 📌 강의 핵심

- `@IBAction` , `@IBOutlet`으로 `storyBoard` 의 실제 UI와 연결

```swift
@IBOutlet weak var nameTextField: UITextField! //@IBOutlet 사용
@IBOutlet weak var authorTextField: UITextField!
@IBOutlet weak var genreTextField: UITextField!

@IBAction func registerAction(_ sender: Any){ //@IBAction 사용
        var bookTemp = Book()
        bookTemp.name = nameTextField.text!
        bookTemp.author = authorTextField.text!
        bookTemp.genre = genreTextField.text!
        
        myBookManager.registerBook(bookObject: bookTemp)
        outputTextView.text = "\(nameTextField.text!) has been registered"
        countLabel.text = "\(myBookManager.countBooks())"
}
```

