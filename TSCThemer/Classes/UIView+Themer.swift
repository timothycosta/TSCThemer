//
//  UIView+Themer.swift
//  Pods-TSCThemer_Example
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation
import UIKit

extension NSObject {
	public func setThemes<T>(with objects: [T], selector:Selector, themer: Themer = Themer.shared) {
		assert(self.responds(to: selector), "Invalid selector: '\(selector)'")
		for (idx, val) in objects.enumerated() {
			self.setTheme(themer: themer, index: idx, key: NSStringFromSelector(selector), block: { (obj) in
				let _ = obj.perform(selector, with: val)
			})
		}
	}

}

extension UIView {
	public func themeBackgroundColor(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: #selector(setter: UIView.backgroundColor))
	}
	public func themeTintColor(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: #selector(setter: UIView.tintColor))
	}
}

extension UILabel {
	public func themeText(_ texts: [String]) {
		self.setThemes(with: texts, selector: #selector(setter: UILabel.text))
	}
	public func themeAttributedText(_ texts: [NSAttributedString]) {
		self.setThemes(with: texts, selector: #selector(setter: UILabel.attributedText))
	}
	public func themeTextColors(_ colors: [UIColor]) {
		self.setThemes(with: colors, selector: #selector(setter: UILabel.textColor))
	}
}

extension CALayer {
	public func themeBackgroundColor(_ colors: [UIColor]) {
		self.setThemes(with: colors.map( { $0.cgColor } ), selector: #selector(setter: CALayer.backgroundColor))
	}
	public func themeBorderColor(_ colors: [UIColor]) {
		self.setThemes(with: colors.map( { $0.cgColor } ), selector: #selector(setter: CALayer.borderColor))
	}
}
