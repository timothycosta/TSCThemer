//
//  NSObject+Themer.swift
//  TSCThemer
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation

public typealias ThemeBlock = (AnyObject) -> ()

private typealias Keyer = [String : ThemeBlock]
private typealias Indexer = [Int:Keyer]
private typealias Theme = [Themer:Indexer]

public extension NSObject {

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

	private var themes: Theme {
		get {
			if let themes = objc_getAssociatedObject(self, &themerKey) as? Theme {
				return themes
			}
			NotificationCenter.default.addObserver(self, selector: #selector(tscUpdateTheme(_:)), name: .ThemerDidUpdate, object: nil)
			let initValue: Theme = [:]
			objc_setAssociatedObject(self, &themerKey, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			return initValue
		}
		set {
			objc_setAssociatedObject(self, &themerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	@objc fileprivate func tscUpdateTheme(_ notification: Notification) {
		guard let themer = notification.object as? Themer, let keyer = self.themes[themer]?[themer.index] else { return }
		for theme in keyer.values {
			theme(self)
		}
	}
}

private var themerKey = ""
