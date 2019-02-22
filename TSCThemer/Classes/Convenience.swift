//
//  Convenience.swift
//  TSCThemer
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation
import UIKit

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
