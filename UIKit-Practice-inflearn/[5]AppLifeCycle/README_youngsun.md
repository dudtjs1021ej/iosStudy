## 📒 섹션 6 - 앱 생명주기(App Life Cycle)

### 📌 강의 핵심

#### 🔍 ViewController 생명 주기

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2613D13C58C64DE32C838B">

```swift
class ViewController: UIViewController {

    //view가 올라오고 나서 바로 호출 -> 1번 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //view가 나타나기 전에 호출
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    //view가 나타나고 나서 호출
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    //view가 사라지기 전에 호출
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    //view가 사라지고 나서 호출
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }

}
```



#### 🔍 앱 생명주기

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {


    //launch finish 되기 전에 호출
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("willFinishLaunchingWithOptions")
        return true
    }

    //launch finish되고 호출 -> 1번 호출
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    //활성화할 때마다 호출 -> 여러번 호출
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }
    
    //비활성화 될 때 호출
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
    
    //앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    //앱이 background 상태일 때 실행
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

```

