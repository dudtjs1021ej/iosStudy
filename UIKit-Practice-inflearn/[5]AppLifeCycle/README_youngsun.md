## ๐ ์น์ 6 - ์ฑ ์๋ช์ฃผ๊ธฐ(App Life Cycle)

### ๐ ๊ฐ์ ํต์ฌ

#### ๐ ViewController ์๋ช ์ฃผ๊ธฐ

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2613D13C58C64DE32C838B">

```swift
class ViewController: UIViewController {

    //view๊ฐ ์ฌ๋ผ์ค๊ณ  ๋์ ๋ฐ๋ก ํธ์ถ -> 1๋ฒ ํธ์ถ
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //view๊ฐ ๋ํ๋๊ธฐ ์ ์ ํธ์ถ
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    //view๊ฐ ๋ํ๋๊ณ  ๋์ ํธ์ถ
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    //view๊ฐ ์ฌ๋ผ์ง๊ธฐ ์ ์ ํธ์ถ
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    //view๊ฐ ์ฌ๋ผ์ง๊ณ  ๋์ ํธ์ถ
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }

}
```



#### ๐ ์ฑ ์๋ช์ฃผ๊ธฐ

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {


    //launch finish ๋๊ธฐ ์ ์ ํธ์ถ
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("willFinishLaunchingWithOptions")
        return true
    }

    //launch finish๋๊ณ  ํธ์ถ -> 1๋ฒ ํธ์ถ
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    //ํ์ฑํํ  ๋๋ง๋ค ํธ์ถ -> ์ฌ๋ฌ๋ฒ ํธ์ถ
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }
    
    //๋นํ์ฑํ ๋  ๋ ํธ์ถ
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
    
    //์ฑ์ด background์์ foreground๋ก ์ด๋ ๋ ๋ ์คํ (์์ง foreground์์ ์คํ์ค์ด์ง ์์)
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    //์ฑ์ด background ์ํ์ผ ๋ ์คํ
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

```

