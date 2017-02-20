# RGATest

# Contents


## How to Generate App

#### Xcode
Open ```RGATest.xcworkspace``` and press <kbd>Command</kbd>+<kbd>R</kbd>

#### Testflight
1. [Open this link]() and type your iTunes email account
2. Open your email and accept to test RGATest
3. Download the Testflight app
4. Copy the redeem code you got from Testflight's email and paste in Testflight's app
5. Download ```RGATest```

## Libraries Used

#### EZSwiftExtensions
* Description: A collection of useful extensions for the Swift Standard Library, Foundation, and UIKit.
* Justification: I use EZSwiftExtensions in every single project I work on because it allows me to code faster with amazing extensions like ```UIImageView.roundSquareImage``` or ```Date.fromString("", format: "")```. It has a CocoaPods Quality index of 96(which is pretty high), with several tests, ensuring the library is stable

#### Alamofire
* Description: Elegant HTTP Networking in Swift
* Justification: Alamofire is the Swift version of AFNetworking, which is used by millions of apps around the world. It is one of the biggest Swift libraries and I used it because it is way easier and looks much better than using Apple's ```NSURLSession```

#### Kingfisher
* Description: A lightweight, pure-Swift library for downloading and caching images from the web.
* Justification: Kingfisher handles async image downloading, making sure the UI is not blocked or the table view doesn't have a recycling problem. It is, by far, the easiest ways to load images in a TableView
