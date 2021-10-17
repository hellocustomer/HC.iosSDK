# HC.iosSDK ![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HelloCustomer?color=gre)
---

HelloCustomer touchpoint sdk for iOS plaftorm. 

## Requirements

Min ios version: iOS 12

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate HC.iosSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'HelloCustomer', '~> 0.0.1'
```

## Usage (TBD)

After you successfully installed sdk in your project you can request showing quesionaire in this way:
```swift
        
    @IBAction func didButtonClicked(_ sender: Any) { // you can request loading questionaire data in any place eg. #viewDidLoad() and show when you want
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "YY/MM/dd hh:mm"
        
        //Put metadata which you need to add
        let customMetadata = [
            "testDate": dateFormmater.string(from: Date()),
            "userBattery": String(UIDevice.current.batteryLevel)
        ]
        
        HelloCustomerTouchPoint.load( 
            config: HelloCustomerTouchPointConfig(
                authorization: "<YOUR AUTHORIZATION HEADER HERE>",
                companyId: "<YOUR COMPANY_ID HERE>",
                touchpointId: "<YOUR TOUCHPOINT_ID HERE>",
                questionFont: UIFont(name: "Earwig Factory", size: UIFont.labelFontSize)!, //optional, default systemFont 14 will be used
                hintFont: UIFont(name: "Comic Sans MS", size: UIFont.labelFontSize)!, //optional, default systemFont 10 will be used
                metadata: customMetadata, //optional metadata for additional loging
                respondentFirstName: "User first name", //optional user first name
                respondentLastName: "Last name", //optional user last name
                respondentEmailAddress: "email" //optional user email address
            ),
            viewController: self,
            resultDelegate: onTouchPointResult
        )
    }
    
    private func onTouchPointResult(result: TouchPointLoadResult) {
        switch result {
        case .success(let modal):                     // when questionaire will be downloaded successfully you can show it
            modal.display()
        case .error(let error):
            print(error)                              // or in case of error you can handle it
        }
    }

```

More examples will be added when libary will be stable

