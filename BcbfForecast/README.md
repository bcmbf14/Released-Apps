
# BcbfForecast

___배운점과 추가로 공부해야될 부분들 정리___

# 

___SKT API 등록 및 연동___

# 

___UIVIewController+Alert___

# 

___Codable Model&JSON___

# 

___NSObject Key&Value Coding___

# 

___URLSession API, Playgound Test___

# 

___NumberFormatter, DateFormatter___

# 

___CoreLocation, CLLocationManagerDelegate___

# 

___Privacy 권한요청 및 실패시 대응___

# 


___viewDidLayoutSubviews___

# 

___DataSource Singleton___

# 

___String to Double Type, 소수점 자리수 지정___

# 

___Geocoding, Reverse Geocoding___

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
