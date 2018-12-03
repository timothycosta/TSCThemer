//
//  UIView+Themer.swift
//  Pods-TSCThemer_Example
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation
import UIKit

extension NSObject {
	public func setThemes<T>(with objects: [T], selector:String, themer: Themer = Themer.shared) {
		assert(self.responds(to: Selector(selector)), "Invalid selector: '\(selector)'")
		let sel = Selector(selector)
		for (idx, val) in objects.enumerated() {
			self.setTheme(themer: themer, index: idx, key: selector, block: { (obj) in
				let _ = obj.perform(sel, with: val)
			})
		}
	}
}

extension UIView {
	public func themeBackgroundColor(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: "setBackgroundColor:")
	}
	public func themeTintColor(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: "setTintColor:")
	}
}

extension UILabel {
	public func themeText(_ texts: [String]) {
		self.setThemes(with: texts, selector: "setText:")
	}
	public func themeAttributedText(_ texts: [NSAttributedString]) {
		self.setThemes(with: texts, selector: "setAttributedText:")
	}
	public func themeTextColors(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: "setTextColor:")
	}
}

extension CALayer {
	public func themeBackgroundColor(_ colors: [UIColor]) {
		self.setThemes(with: colors.map( { $0.cgColor } ), selector: "setBackgroundColor:")
	}
	public func themeBorderColor(_ colors: [UIColor]) {
		self.setThemes(with: colors.map( { $0.cgColor } ), selector: "setBorderColor:")
	}
}
