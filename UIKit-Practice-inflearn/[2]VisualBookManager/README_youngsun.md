## πμΉμ3 - λΉμ₯¬μΌ λμ κ΄λ¦¬ μ±

### π νμΌ κ΅¬μ‘° 

```bash
.
βββ VisualBookManager
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
βΒ Β  βββ Book.swift
βΒ Β  βββ BookManager.swift
βΒ Β  βββ Info.plist
βΒ Β  βββ SceneDelegate.swift
βΒ Β  βββ ViewController.swift
```

---

### π μ€ν νλ©΄

![image](https://user-images.githubusercontent.com/77915491/128832195-81be2ee5-8b75-4188-80ba-2165f3acdeb0.png)

---

### π κ°μ ν΅μ¬

- `@IBAction` , `@IBOutlet`μΌλ‘ `storyBoard` μ μ€μ  UIμ μ°κ²°

```swift
@IBOutlet weak var nameTextField: UITextField! //@IBOutlet μ¬μ©
@IBOutlet weak var authorTextField: UITextField!
@IBOutlet weak var genreTextField: UITextField!

@IBAction func registerAction(_ sender: Any){ //@IBAction μ¬μ©
        var bookTemp = Book()
        bookTemp.name = nameTextField.text!
        bookTemp.author = authorTextField.text!
        bookTemp.genre = genreTextField.text!
        
        myBookManager.registerBook(bookObject: bookTemp)
        outputTextView.text = "\(nameTextField.text!) has been registered"
        countLabel.text = "\(myBookManager.countBooks())"
}
```

