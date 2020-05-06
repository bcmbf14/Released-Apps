
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
</details>

<details markdown="1">
<summary> CoreLocation, CLLocationManagerDelegate </summary>
</details>

<details markdown="1">
<summary> Privacy 권한요청 및 실패시 대응 </summary>
</details>

<details markdown="1">
<summary> viewDidLayoutSubviews </summary>
</details>

<details markdown="1">
<summary> DataSource Singleton </summary>
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


- Product Name
  - 프로젝트네임에는 단순명사(메모,날씨,카메라)등만 적으면 안된다.
  - 원하는 접두어, 접미어를 붙여서 최대한 고유하게 하는 것이 좋다. 
  - 영어 대소문자를 사용한다. 특수문자, 한글, 숫자 등은 적지 않는 것이 좋다.
  - 위의 사항을 어길시, 앱스토어에 앱을 등록 할 때 문제가 생길 수 있다.
 
- Oragnization Identifier 
  - 보통 역도메인 문자열을 입력하는데, 도메인이 없다면 이름을 공백없이 입력해도 좋다.
  
- Bundle Identifier
  - 앱을 유일하게 구별하는 __식별자__ 로 사용한다.

# 
___App Icon___

![image](https://user-images.githubusercontent.com/60660894/79072564-a0e2dd00-7d1c-11ea-8c20-02e0df4c6606.png)

- 점선이 표시된 개별 사각형을 Image Well이라고 부른다.
- 밑에 20pt라고 되어있는 것은 이미지의 크기를 뜻하는 것이고 단위는 point이다. pixel과는 다른 단위이다.
- 2x, 3x라고 써있는 것은 상대적인 해상도를 뜻한다. 레티나 디스플레이가 적용되지 않은 버전은 1x, 레티나 2x, 레티나 HD/슈퍼 레티나 이상은 3x 라고 부른다. 
- 아이콘으로 작성할 이미지는 앱 아이콘이 정사각형에 코너가 약간 둥근 모양이기 때문에, 원형보다는 정사각형이 낫다. 
- 아이콘을 생성하고, 엄청나게 많은 이미지를 일일히 넣어줘야 한다. 번거롭긴 하다. 

[앱 아이콘 다운로드](https://www.flaticon.com/free-icon/compose_148876#term=pencil&page=1&position=18)

[아이폰 해상도 가이드](https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)

[무료 앱 아이콘 생성 사이트](https://appiconmaker.co/)


# 

___Memo Class___

```swift

import Foundation

class Memo {
    var content: String
    var insertData : Date
    
    init(content: String){
        self.content = content
        insertData = Date()
    }
    
    
    static var dummyMemoList = [
        Memo(content: "Lorem Ipsum"),
        Memo(content: "🥰 + 👍 = ❤️")
    
    ]
}

```

- 메모클래스를 생성했고, 더미데이터를 세팅했다. 
- 클래스기 때문에 생성자를 만들어주었고, 날짜형식같은경우는 기본 Date형식을 생성해서 넣어주면 되기 때문에 따로 생성자에 넣지 않았다. 
