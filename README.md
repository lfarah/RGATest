# RGATest

## How to Generate App
Open ```RGATest.xcworkspace``` and press <kbd>Command</kbd>+<kbd>R</kbd>

## General Explanation of code and app
Chosen architecture: MVVM
* `Contact.swift` : Model
* `ContactViewModel.swift`: ViewModel
* `Constants.swift`: Used to manage global variables: [Blog Post talking about it here](http://www.jessesquires.com/swift-namespaced-constants/)
* `Networker.swift`: Used to make all network requests
* `ContactsViewController.swift`: Main ViewController with list
* `ContactDetailViewController.swift`: Detail ViewController with more informations about the contact
* `AddContactViewController.swift`: ViewController that handles user creation and editing

## Extra Functionalities
* Search for contact
* Tap on contact's email to send an email

## What Should Change if I had more time
* I'd mock my tests, making it easy to simulate different database scenarios.
* I'd use BDD using the [Quick Framework](https://github.com/Quick/Quick)

## Libraries Used

#### [EZSwiftExtensions](https://github.com/goktugyil/EZSwiftExtensions)
* Description: A collection of useful extensions for the Swift Standard Library, Foundation, and UIKit.
* Justification: I manage and use EZSwiftExtensions in every single project I work on because it allows me to code faster with amazing extensions like ```UIImageView.roundSquareImage``` or ```Date.fromString("", format: "")```. It has a CocoaPods Quality index of 96(which is pretty high), with several tests, ensuring the library is stable

#### [Alamofire](https://github.com/Alamofire/Alamofire)
* Description: Elegant HTTP Networking in Swift
* Justification: Alamofire is the Swift version of AFNetworking, which is used by millions of apps around the world. It is one of the biggest Swift libraries and I used it because it is way easier and looks much better than using Apple's ```NSURLSession```

#### [Kingfisher](https://github.com/onevcat/Kingfisher)
* Description: A lightweight, pure-Swift library for downloading and caching images from the web.
* Justification: Kingfisher handles async image downloading and cache, making sure the UI is not blocked or the table view doesn't have a recycling problem. It is, by far, the easiest ways to load images in a TableView

#### [Swiftlint](https://github.com/realm/SwiftLint)
* Description: A tool to enforce Swift style and conventions
* Justification: Swiftlint enforces me to write pretty Swift code, giving me issues and errors if I use more spaces that I was supposed to, force-unwrapped, wrote a long method name, etc... I use it on every single project. It basically allows me to write better and more stable code

#### [SkyFloatingLabelTextField](https://github.com/Skyscanner/SkyFloatingLabelTextField)
* Description: A beautiful and flexible text field control implementation of "Float Label Pattern". Written in Swift.
* Justification: SkyFloatingLabelTextField let's me create a really cool UITextField with animations out of the box, with almost no code. They implement `IBInspectable` to make it easy to customize stuff directly from the Storyboard

#### [KMPlaceholderTextView](https://github.com/MoZhouqi/KMPlaceholderTextView)
* Description: A UITextView subclass that adds support for multiline placeholder written in Swift.
* Justification: KMPlaceholderTextView makes it really easy to implement placeholder text in UITextViews

#### [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
* Description: Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.
* Justification: Managing keyboards is always a pain, specially when you have to deal with smaller screens. IQKeyboardManagerSwift takes care of all in the whole projecte with 1 (ONE) line of code

#### [DatePickerDialog](https://github.com/squimer/DatePickerDialog-iOS-Swift)
* Description: DatePickerDialog is an iOS drop-in classe that displays an UIDatePicker within an UIAlertView.
* Justification: DatePickerDialog is one of the libraries I manage. The UX looks much better to have a DatePicker than just having a number keyboard.

#### [ImagePicker](https://github.com/hyperoslo/ImagePicker)
* Description: 📷 Reinventing the way ImagePicker works.
* Justification: HyperOslo is one of the biggest iOS open source groups. I've used many of their libraries. ImagePicker makes it really easy to implement a camera with album access with a much better UI & UX then the Apple's `UIImagePicker`.

#### [SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift)
* Description: Beautiful animated Alert View. Written in Swift
* Justification: Apple's UIAlertController is really ugly and specially bad because it [always gives some ugly errors](http://stackoverflow.com/questions/29365540/swift-attempt-to-present-uialertcontroller-whose-view-is-not-in-the-window-hiera). SCLAlertView is a really easy to implement and really nice AlertView that already gives me special colors for Error, Success and Warnings.
