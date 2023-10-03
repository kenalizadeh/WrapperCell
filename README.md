# WrapperCell

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

**Easily conform your view to ConfigurableView**
```swift
struct TextContent {
    var string: String
    var color: UIColor
    var font: UIFont
}

extension UILabel: ConfigurableView {

    public struct Item {
        let content: TextContent
    }

    public func configure(_ item: Item) {
        self.setText(content: item.content)
    }

    public func reset() {
        self.setText(content: nil)
    }
}

typealias LabelCell = WrapperCell<UILabel>
```

## Installation

WrapperCell is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WrapperCell'
```

## Author

Kenan Alizadeh, kananalizade@gmail.com

## License

WrapperCell is available under the MIT license. See the LICENSE file for more info.
