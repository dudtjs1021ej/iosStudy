## 📒 섹션4 - 디지털 액자 앱

- `Slider` 로 속도를 조절하여 `ImageView`  여러 장을 보여주는 앱

---

### 📌 파일 구조

```bash
└── DigitalFrame
    ├── DigitalFrame
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
    │   ├── Resource
    │   ├── SceneDelegate.swift
    │   └── ViewController.swift
```



---

### 📌 실행 화면

![image](https://user-images.githubusercontent.com/77915491/128843112-e0aea9d3-e1d5-4083-8944-fdc21ec3cac4.png)

---

### 📌 강의 핵심

#### 🔍 imageView animation 관련 메소드

```swift
imgView.animationImages = cuteImages //애니메이션을 만들 이미지 배열을 넣음
imgView.animationDuration = 15 //속도조절 (1초에 한 장씩)
if imgView.isAnimating{ //animating하고 있다면
            imgView.stopAnimating() // 애니메이션 stop
            toggleButton.setTitle("start", for: .normal)
        }
```



#### 🔍 format으로 소수점자리 출력

```swift
speedLabel.text = String(format: "%.2f", speedSlider.value) //소수점 둘쨋자리까지만 
```

