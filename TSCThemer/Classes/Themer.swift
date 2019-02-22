//
//  Themer.swift
//  TSCThemer
//
//  Created by Timothy Costa on 11/30/18.
//

import Foundation

extension Notification.Name {
	static let ThemerDidUpdate = Notification.Name("ThemerDidUpdate")
}

/// Themer simply holds an index and sends ThemerDidUpdate when that index is changed.
@objcMembers public class Themer: NSObject {
	public static let shared = Themer()
	public var index: Int = 0 {
		didSet {
			NotificationCenter.default.post(name: .ThemerDidUpdate, object: self)
		}
	}
}

// MARK: Convenience methods
extension Themer {
	public func set(index: Int, duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
		UIView.animate(withDuration: duration, animations: {
			self.index = index
		}, completion: completion)
	}

	public func pick<V>(_ objects: [V]) -> V? {
		return self.index < objects.count ? objects[self.index] : nil
	}

	public func pick<V>(_ objects: [V], default defaultValue: V) -> V {
		return self.pick(objects) ?? defaultValue
	}
}
