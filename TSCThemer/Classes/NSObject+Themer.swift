//
//  NSObject+Themer.swift
//  TSCThemer
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation

public typealias ThemeBlock = (AnyObject) -> Void

private typealias Keyer = [String : ThemeBlock]
private typealias Indexer = [Int:Keyer]
private typealias Theme = [Themer:Indexer]
private typealias Value = [Themer: [Int : [ String : Any] ] ]

public extension NSObject {
	// MARK: Main method for TSCThemer

	/// Sets a theme on the given object
	///
	/// - Parameters:
	///   - themer: The Themer to use
	///   - index: Corresponds to Themer.index
	///   - key: For example "TextColor", "Font", "BackgroundColor", "Layout"
	///   - block: A block that will be executed when the theme updates.  Called immediately if indexes match.
	public func setTheme(themer: Themer = Themer.shared, index: Int, key: String, block: ThemeBlock?) {
		self.themes[themer, orAdd: [:] ][index, orAdd: [:] ][key] = block
		if themer.index == index {
			block?(self)
		}
	}
}

public extension NSObject {
	// MARK: Convenience method for setting themes

	/// Convenience method for setting multiple themes on the given object using the given selector
	///
	/// - Parameters:
	///   - objects: Objects to theme
	///   - selector: The setter to use
	///   - themer: The Themer to use
	///   - key: For example "TextColor", "Font", "BackgroundColor", "Layout"
	public func setThemes<T>(with objects: [T], selector: Selector, themer: Themer = Themer.shared) {
		assert(self.responds(to: selector), "Invalid selector: '\(selector)'")
		let key = NSStringFromSelector(selector)
		for (idx, val) in objects.enumerated() {
			self.setTheme(themer: themer, index: idx, key: key, block: { (obj) in
				let obj = obj as! NSObject
				let _ = obj.perform(selector, with: val)
			})
		}
	}
}

fileprivate extension NSObject {
	// MARK: Private variable and update method
	fileprivate var themes: Theme {
		get {
			if let themes = objc_getAssociatedObject(self, &themeKey) as? Theme {
				return themes
			}
			NotificationCenter.default.addObserver(self, selector: #selector(tscUpdateTheme(_:)), name: .ThemerDidUpdate, object: nil)
			let initValue: Theme = [:]
			objc_setAssociatedObject(self, &themeKey, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			return initValue
		}
		set {
			objc_setAssociatedObject(self, &themeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	@objc fileprivate func tscUpdateTheme(_ notification: Notification) {
		guard let themer = notification.object as? Themer else { return }

		let keyer = self.themes[themer]?[themer.index] ?? [:]
		for theme in keyer.values {
			theme(self)
		}
	}
}

private var themeKey = ""
private var valueKey = ""
