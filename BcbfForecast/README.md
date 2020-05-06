
# BcbfForecast

___배운점과 추가로 공부해야될 부분들 정리___



<details markdown="1">
<summary> SKT API 등록 및 연동 </summary>

- API는 SK Open API를 사용했다. 해당 링크는 [여기](https://openapi.sk.com/content/API)로 가면 확인할 수 있다. 
- 특별히 설명할 것은 없는데, 다른 좋은 API들이 많다. 활용해서 뭘 더 만들어보면 재밌을 것 같다. 어려울 것..도 같고 ?ㅎㅎ
- 당장 흥미가 가는 것은 역시나 T map, 그리고 광범위하게 쓰일 수 있는 11번가 API. 이거 2개가 제일 흥미가 가긴 한다. 
# 
![image](https://user-images.githubusercontent.com/60660894/81121311-63fbb600-8f69-11ea-828f-36e54aeb4a12.png)

</details>



<details markdown="1">
<summary> UIVIewController+Alert </summary>

이건 뭐 간단하지만, 그만큼 많이 쓰이므로 하나 첨부
```swift 

extension UIViewController {
    
    func show(message:String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
}
```

</details>



<details markdown="1">
<summary> Codable Model&JSON </summary>

- JSON Pasing 같은 경우에 애초에 Codable 쓰다가 모델링이 제대로 안되면 자꾸 Crash나는 문제때문에 SwiftyJSON을 썼잖아?
- 음, 이번에 Codable을 좀 배운 것 같고 
  - Codable을 좀 더 깊이 파볼 것. 
  - Codable과 Codable이 없던 이전(iOS8)에는 어떻게 했는지 알아볼 것. 
  - ObjectMapper 라이브러리인가? 그거 한 번 사용해볼 것. 
  - Codable과 SwiftyJSON ObjectMapper의 차이, 장단점 등을 파악해볼 것. 

# 

- 그래서 일단 결국은 Codable 부터인데, 요약하면 
  - 전체 데이터 중에 내가 원하는 것만 빼올 수 있다. 
  - 데이터 구조와 모델링을 똑같이 해야한다. 
  - 데이터의 항목?아이템?이름과 구조체의 상수(let) 변수 이름은 동일해야 한다. 
  
- 정말 많이 쓰이므로 잘 숙지해 둘 것. 

```swift 
struct WeatherSummary: Codable {
    
    struct Weather: Codable {
        struct Minutely: Codable{
            struct Sky: Codable {
                let code: String
                let name: String
            }
            
            struct Temperature:Codable {
                let tc: String
                let tmax: String
                let tmin: String
            }
            
            let sky: Sky
            let temperature: Temperature
            
        }
        
        let minutely: [Minutely]
    }
    
    struct Result: Codable {
        let code: Int
        let message: String
        
    }
    
    let weather: Weather
    let result: Result
}

```

```
{
    "weather": {
        "minutely": [
        {
        "station": {
        "longitude": "127.01562",
        "latitude": "37.48891",
        "name": "서초",
        "id": "401",
        "type": "KMA"
        },
        "wind": {
        "wdir": "163.60",
        "wspd": "1.50"
        },
        "precipitation": {
        "sinceOntime": "0.00",
        "type": "0"
        },
        "sky": {
        "code": "SKY_A01",
        "name": "맑음"
        },
        "rain": {
        "sinceOntime": "0.00",
        "sinceMidnight": "0.00",
        "last10min": "0.00",
        "last15min": "0.00",
        "last30min": "0.00",
        "last1hour": "0.00",
        "last6hour": "0.00",
        "last12hour": "0.00",
        "last24hour": "0.00"
        },
        "temperature": {
        "tc": "13.80",
        "tmax": "28.00",
        "tmin": "12.00"
        },
        "humidity": "",
        "pressure": {
        "surface": "",
        "seaLevel": ""
        },
        "lightning": "0",
        "timeObservation": "2020-05-06 07:19:00"
        }
        ]
    },
    "common": {
        "alertYn": "Y",
        "stormYn": "N"
    },
    "result": {
        "code": 9200,
        "requestUrl": "/weather/current/minutely?version=2&lat=37.498206&lon=127.02761&appKey=l7xx3db99b1125e3421e9ad660651d5563b1",
        "message": "성공"
    }
}
```
</details>

<details markdown="1">
<summary> NSObject Key&Value Coding </summary>
</details>

<details markdown="1">
<summary> URLSession API, Playgound Test </summary>

- 몰랐는데, playground를 만들어서 API를 테스트 해볼 수가 있드라. 
- 그냥 원하는 이름으로 ㅇㅇㅇApi처럼 playground를 하나 만들고 테스트 하면 돼. 
- 라이브러리 안쓰고 URLSession을 사용했어. 
- URLSession와 Alamofire의 차이가 무엇인지, 장단점을 찾아보도록 해. 
- 여기서의 핵심은, 
    - URLSession 사용해서 request, response 하는 부분 
    - 에러나 기타 상태코드에 따른 예외처리 
    - playground testing 
    - DispatchGroup, DispatchQueue 생성 
    - group.enter(), group.leave()
    - defer와 completion: @escaping 사용해서 비동기로 받아온 데이터 리턴받기
    - parameter하고 header넣어서 처리하기 


</details>

<details markdown="1">
<summary> NumberFormatter, DateFormatter </summary>

여기선 포매터가 2종류가 쓰였어. 중요하니까 공부 잘해.         
특이한 것은 DateFormatter인데 사용할 때, dateFormat에 "M.d (E)", "HH:00" 값을 넣어서 포맷을 바꿔주고 있어. "M.d (E)"가 뭔지 모르겠다야? 공부해.      
````swift

let tempFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0 //소수점이 0인 경우엔 출력하지 않고
    f.maximumFractionDigits = 1 //나머지 경우에는 1자리만 출력한다.
    return f
}()

let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.locale =  Locale(identifier: "Ko_kr")
    return f
}()



let target = WeaterDataSource.shared.forecastList[indexPath.row]

dateFormatter.dateFormat = "M.d (E)"
cell.dateLabel.text = dateFormatter.string(for: target.date)

dateFormatter.dateFormat = "HH:00"
cell.timeLabel.text = dateFormatter.string(for: target.date)
    
````

</details>




<details markdown="1">
<summary> CoreLocation, CLLocationManagerDelegate </summary>

사용자 위치 가져오는 것은 CoreLocation 프레임워크 인가봐. 자세한 건 다음에 공부해야할 것 같다.        
간단하게만 CLLocationManagerDelegate에 대해서 볼건데, 대략 소개해볼게.             
자세한 내용은 [공식문서](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate)에 있고, 여기서는 내가 사용한 코드만 적어놓을 게. 그게 이해하기 오히려 더 편할거야.       

````swift

extension ViewController: CLLocationManagerDelegate {
    
    func updateCurrentLocation(){
        locationManager.startUpdatingLocation() //사용자의 위치가 업데이트 될때마다 델리게이트를 통해 알려줌
    }
    
    
    //위치정보가 업데이트 될떄마다 반복적으로 알려줌
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let loc = locations.first {
            print(loc.coordinate)
            
            //        Geocoding
            //        특정 주소나 명칭을 사용해서 좌표를 얻는 것
            //        Reverse Geocoding
            //        좌표를 주소로 바꾸는 것
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(loc) { [weak self] (placemarks, error) in
                //                하나의 명칭에 대한 여러가지 명칭이 있을 수 있어서 배열로 전달해줌
                if let place = placemarks?.first {
                    
                    //미국 기준이기 때문에 우리나라 구랑 동을 받아와야 함
                    if let gu = place.locality, let dong = place.subLocality {
                        self?.locationLabel.text = "\(gu) \(dong)"
                    }else{
                        self?.locationLabel.text = place.name
                    }
                }
            }
            
            
            //        샘플에서는 뷰디드로드에서 호출했는데, 뷰디드로드에서 현재 로케이션 정보를 받아올 수 없으니
            //        이델리게이트에서 호출한다.
            WeaterDataSource.shared.fetch(location: loc) { [weak self] in
                self?.listTableView.reloadData()
            }
            
        }
        
        //계속 알려주면 배터리가 소모되니까 한번만 받고 그만받기. 배터리절약. 위치기반 배터리 아주중요.
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        show(message: error.localizedDescription)
        manager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            updateCurrentLocation()
        default:
            print("")
            //            fatalError()
        }
    }
    
}


````

</details>

<details markdown="1">
<summary> Privacy 권한요청 및 실패시 대응 </summary>

여기서는 음, 위치를 알기위한 권한요청을 사용했어. veiwwillappear에 사용했는데 실패하면 그냥 얼랏만 띄워주거나 해서 처리를 했어. 근데 상황에따라서 얼랏에다가 이벤트를 줘서 설정화면으로 바로 보내버리거야 해야하거든. 아니면 메시지를 띄워주던가 말이야. 그거 잘생각해서 바꿔보도록 하고. 그리고 case에 대해서 다시 공부해보자. notDetermined, denied, restricted 등등. 정확히 어떨때쓰는건지 분류해서 잘 사용해야해. 앱의 매우 중요한 기능이 동작하지 않을 수 있으니까. 

````swift

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    locationLabel.text = "업데이트 중..."

    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            updateCurrentLocation()
        case .denied, .restricted:
            show(message: "위치 서비스 사용 불가")
        default:
            fatalError()
        }


    } else{
        show(message: "위치 서비스 사용 불가")
    }

}


````


</details>

<details markdown="1">
<summary> viewDidLayoutSubviews </summary>

viewDidLayoutSubviews같은 경우에는 이럴 때 썼어.   
나는 첫번째 셀의 높이를 가져와야해. 근데 viewDidLoad에서 쓰자니 아직 셀이 완성?되지 않은거야.     
그래서 이름 그대로 '레이아웃서브뷰를 그리는게 완료될때' 호출되는 viewDidLayoutSubviews를 오버라이드해서 거기에 내가 원하는 코드를 적었어.     
아래처럼.       

````swift

override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if topInset == 0.0 {
        let first = IndexPath(row: 0, section: 0)
        if let cell = listTableView.cellForRow(at: first)  {
            topInset = listTableView.frame.height - cell.frame.height

            var inset = listTableView.contentInset
            inset.top = topInset
            listTableView.contentInset = inset
        }
    }
}

````


</details>

<details markdown="1">
<summary> DataSource Singleton </summary>

이것도 진짜 너무너무너무너무 중요하다.        
실무에서 너무너무너무 자주 쓰이는 부분이야.         
근데 아직 난 잘 몰라. 초보라서..ㅠㅠ      
쨌건, 서버에서 받아오는 데이터를 싱글톤으로 갖고있다가 어디든 쓰는거야.        
앱델리게이트나, 씬델리게이트에 객체를 두지 않아도 된다는거지.      
지금은 이렇게 간단하게 표현했지만, 저 WeatherSummary와 ForecastData가 서버에서 받아오는 데이터고 따라서 저 객체에 값을 넣을 수 있는 메소드가 존재해.               
두개 메소드는 private으로 쓰이는 것, 커스텀 큐를 만들어 사용한 것에 유의하도록 해. 

````swift

class WeaterDataSource {
    static let shared = WeaterDataSource()
    
    private init() {}
    
    var summary: WeatherSummary?
    var forecastList = [ForecastData]()
    
    let group = DispatchGroup()
    let workQueue = DispatchQueue(label: "apiQueue", attributes: .concurrent)
    
    func fetch(location: CLLocation, completion: @escaping () -> ()){}
    private func fetchSummary(lat: Double, lon:Double, completion: @escaping () -> ()){}
    private func fetchForecast(lat: Double, lon:Double, completion: @escaping () -> ()){}

}

````




</details>

<details markdown="1">
<summary> String to Double Type, 소수점 자리수 지정 </summary>

Formatter는 엄청나게 많이 활용이 되지? 중요해 매우.      
나같은 경우엔 그냥 구글링해서 갖고온 뭐 

````swift
String(format: "%02f", 0.12344567)
````

를 사용하곤 했지. 저거랑 지금 배운거랑 차이점도 한 번 알아보자. 
        
일단 여기서는 포매터를 하나 만들었어. 이렇게 타입은 numberFormatter야.     

````swift
let tempFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0 //소수점이 0인 경우엔 출력하지 않고
    f.maximumFractionDigits = 1 //나머지 경우에는 1자리만 출력한다.
    return f
}()

````

그리고 사용할 곳으로 가서 이렇게 사용했어. 이걸 어디 익스텐션이나 다른걸로 만들어놓는 방법도 생각해보자.     


````swift

let max = Double(data.temperature.tmax) ?? 0.0
let min = Double(data.temperature.tmin) ?? 0.0

let maxStr = tempFormatter.string(for: max) ?? "-"
let minStr = tempFormatter.string(for: min) ?? "-"
cell.minMaxLabel.text = "최대 \(maxStr)º 최소 \(minStr)º"

let current = Double(data.temperature.tc) ?? 0.0
let currentStr = tempFormatter.string(for: current) ?? "-"
cell.currentTemperatureLabel.text = currentStr

````

참, string으로 컨버팅하는 메소드는 2가지가 있어. 차이는 큰 건 없지만, 입력 타입이 달라. 그래서 any를 많이 쓰는 것 같아. 

````swift

                
tempFormatter.string(from: NSNumber)
tempFormatter.string(for: Any?)

````



</details>

<details markdown="1">
<summary> Geocoding, Reverse Geocoding </summary>

- Geocoding
    - 특정 주소나 명칭을 사용해서 좌표를 얻는 것
- Reverse Geocoding
    - 좌표를 주소로 바꾸는 것
           
###### 

일단 지금 내가 해야하는 건 locationManager로 가져온 locations으로 현재 위치를 표시해야 하잖아?   
그래서 그걸 관할하는 인터페이스인 CLGeocoder를 생성했어.    
그리고 .reverseGeocodeLocation를 이용해서 placemarks를 리턴 받았어.   
placemarks이 왜 s냐면 같은 장소라도 여러가지 명칭이 있을 수 있기 때문이래.    
그리고, placemarks는 미국기준이라서 그걸 다시 한번 바꿔줘야해.    
우리나라의 '구'에 해당하는건 locality, '동'에 해당하는건 subLocality야.     
그리고 그걸 사용하면 되는것이지.


````swift

let geocoder = CLGeocoder()
geocoder.reverseGeocodeLocation(loc) { [weak self] (placemarks, error) in
    //                하나의 명칭에 대한 여러가지 명칭이 있을 수 있어서 배열로 전달해줌
    if let place = placemarks?.first {

        //미국 기준이기 때문에 우리나라 구랑 동을 받아와야 함
        if let gu = place.locality, let dong = place.subLocality {
            self?.locationLabel.text = "\(gu) \(dong)"
        }else{
            self?.locationLabel.text = place.name
        }
    }
}
            
````


</details>


# 


