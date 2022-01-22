## 📒 섹션 9 - SlectCar 앱

- `PickerView` 로 선택한 차를 `imageView` 로 보여주는 앱

### 📌 파일 구조



---

### 📌 실행 화면

<p align="center">
  <image src = "image/capture.png" width="60%">
</p>


  

---

### 📌 강의 핵심

#### UIView 둥글게 만들기

```swift
imageView.layer.cornerRadius = 50.0
imageView.layer.masksToBounds = true
```



#### UIPickerView 

- `UIPickerViewDelegate`, `UIPickerViewDataSource` 채택
- `numberOfComponents` , `pickerView(**_** pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int` 구현

```swift
func numberOfComponents(in pickerView: UIPickerView) -> Int { //컴포넌트 개수 리턴
        return 2
    }
    
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //컴포넌트별 요소 개수 리턴
        if component == 0{
            return carCompanyName.count
        }else{
            return carModel.count
        }
    }
```

- `pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?`  : 요소들의 이름 지정

```swift
 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { //0번 컴포넌트
            return carCompanyName[row]
        }else{ //1번 컴포넌트
            return carModel[row]
        }
    }
```

- `pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)` : 선택된 요소 이벤트 처리

```swift
 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 && row == 0{
            carModel = tesla
            carModelImage = teslaImageNames
        }else if component == 0 && row == 1{
            carModel = lamborghini
            carModelImage = lamborghiniImageNames
        }else if component == 0 && row == 2{
            carModel = porsche
            carModelImage = porscheImageNames
        }
        pickerView.reloadAllComponents() //reload
        
        imageView.image = UIImage(named: carModelImage[pickerView.selectedRow(inComponent: 1)])
    }
```

