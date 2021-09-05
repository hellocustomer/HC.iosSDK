# HC.iosSDK ![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HelloCustomer?color=gre)
---

HelloCustomer touchpoint sdk for iOS plaftorm. 

## Requirements (TBD)

Min ios version, min swift version and min xcode version

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate HC.iosSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'HelloCustomer', '~> 0.0.1'
```

## Usage (TBD)

After you successfully installed sdk in your project you can request showing quesionaire in this way:
```swift
    
    @IBAction func didButtonClicked(_ sender: Any) {
        HelloCustomerTouchPoint.load(                  // you can request loading questionaire data in any place 
            touchPointId: "touchPointId",              // your touchpointId
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

