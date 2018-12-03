//
//  Dictionary+Themer.swift
//  Pods-TSCThemer_Example
//
//  Created by Timothy Costa on 12/3/18.
//

import Foundation

extension Dictionary {
	public subscript(key: Key, orAdd def: @autoclosure () -> Value) -> Value {
		mutating get {
			if let v = self[key] {
				return v
			}
			let v = def()
			self[key] = v
			return v
		}
		set {
			self[key] = newValue
		}
	}
}
