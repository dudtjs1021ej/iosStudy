## π μΉμ 9 - SlectCar μ±

- `PickerView` λ‘ μ νν μ°¨λ₯Ό `imageView` λ‘ λ³΄μ¬μ£Όλ μ±

### π νμΌ κ΅¬μ‘°



---

### π μ€ν νλ©΄

<p align="center">
  <image src = "image/capture.png" width="60%">
</p>


  

---

### π κ°μ ν΅μ¬

#### UIView λ₯κΈκ² λ§λ€κΈ°

```swift
imageView.layer.cornerRadius = 50.0
imageView.layer.masksToBounds = true
```



#### UIPickerView 

- `UIPickerViewDelegate`, `UIPickerViewDataSource` μ±ν
- `numberOfComponents` , `pickerView(**_** pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int` κ΅¬ν

```swift
func numberOfComponents(in pickerView: UIPickerView) -> Int { //μ»΄ν¬λνΈ κ°μ λ¦¬ν΄
        return 2
    }
    
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //μ»΄ν¬λνΈλ³ μμ κ°μ λ¦¬ν΄
        if component == 0{
            return carCompanyName.count
        }else{
            return carModel.count
        }
    }
```

- `pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?`  : μμλ€μ μ΄λ¦ μ§μ 

```swift
 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { //0λ² μ»΄ν¬λνΈ
            return carCompanyName[row]
        }else{ //1λ² μ»΄ν¬λνΈ
            return carModel[row]
        }
    }
```

- `pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)` : μ νλ μμ μ΄λ²€νΈ μ²λ¦¬

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

