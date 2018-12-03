# TSCThemer

[![CI Status](https://img.shields.io/travis/timothycosta/TSCThemer.svg?style=flat)](https://travis-ci.org/timothycosta/TSCThemer)
[![Version](https://img.shields.io/cocoapods/v/TSCThemer.svg?style=flat)](https://cocoapods.org/pods/TSCThemer)
[![License](https://img.shields.io/cocoapods/l/TSCThemer.svg?style=flat)](https://cocoapods.org/pods/TSCThemer)
[![Platform](https://img.shields.io/cocoapods/p/TSCThemer.svg?style=flat)](https://cocoapods.org/pods/TSCThemer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TSCThemer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TSCThemer'
```

## Usage

TSCThemer has only two essential parts.  A simple `Themer` class with a single member variable `index`, and an extension to `NSObject`.

When changing the index a notification is triggered, which executes the blocks registered via the extension.

To add a block use `setTheme()`
```
/// Sets a theme on the given object
///
/// - Parameters:
///   - themer: The Themer to use
///   - index: Corresponds to Themer.index.  Indexes need not be sequential.
///   - key: For example "TextColor", "Font", "BackgroundColor", "Layout"
///   - block: A block that will be executed when the theme updates.  Called immediately if indexes match.
public func setTheme(themer: Themer = Themer.shared, index: Int, key: String, block: ThemeBlock?)
```

Convenience methods are provided for common UIKit methods such as: `backgroundColor`, `textColor`, `text`, `attributedText`, etc.

```
self.view.themeBackgroundColor([.red, .blue])
self.button.themeTintColor([.red, .green])
```

## Author

timothycosta, tim@timothycosta.com

## License

TSCThemer is available under the MIT license. See the LICENSE file for more info.
