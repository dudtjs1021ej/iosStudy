## 📒 섹션 8 - 항공권 검색 UI 

- `datePicker` 로 항공권 날짜를 선택하고 `UILabel` 에 띄우는 앱

### 📌 파일 구조

```bash
.
└── FlightBooking
    ├── FlightBooking
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

<p align="center">
  <image src = "image/capture.png" width="60%">
</p>


---

### 📌 강의 핵심

#### isHidden을 상요하여 UIView 숨기기

```swift
returnDateLabel.isHidden = true //true면 보이지 않음
returnDateButton.isHidden = true
selectDatePicker.isHidden = true
```



#### DateFormat

- dateFormat을 정하고 datePicker로 선택한 날짜 받아오기

```swift
@IBAction func selectedDateAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-d hh:mma" //format 정함
        
        let dateString = formatter.string(from: sender.date) //UIDatePicker(=sender) 로 선택한 날짜를 포맷에 맞게 가져옴
        
        if buttonTag == 1{
            departDateButton.setTitle(dateString, for: .normal)
        }else{
            returnDateButton.setTitle(dateString, for: .normal)
        }
    }
```



#### @IBAction의 sender를 활용

- sender를 사용하면 코드가 더 간결해짐

```swift
@IBAction func showReturnDateAction(_ sender: UISwitch) {
      //sender 사용x @IBOutlet으로 받아오고 hidden으로 체크해서 사용
        if returnDateButton.isHidden == false{
            returnDateButton.isHidden = true
            returnDateLabel.isHidden = true
        }else{
            returnDateButton.isHidden = false
            returnDateLabel.isHidden = false
        }
      
      //sender 사용 o -> 코드가 간결해짐
      returnDateButton.isHidden = !sender.isOn //UISwitch의 상태와 hidden은 반대
        returnDateLabel.isHidden = !sender.isOn
}
```