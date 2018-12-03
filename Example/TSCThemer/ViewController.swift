//
//  ViewController.swift
//  TSCThemer
//
//  Created by timothycosta on 11/30/2018.
//  Copyright (c) 2018 timothycosta. All rights reserved.
//

import UIKit
import TSCThemer

class ViewController: UIViewController {

	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var toggle: UISwitch!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.toggle.addTarget(self, action: #selector(toggleRandomViews), for: .valueChanged)
		self.segmentedControl.addTarget(self, action: #selector(changeTheme(_:)), for: .valueChanged)

		let tintColors = [UIColor.red, UIColor.green]

		self.toggle.themeTintColor(tintColors)
		self.toggle.setThemes(with: tintColors, selector: "setOnTintColor:")
		self.toggle.isOn = false

		self.segmentedControl.themeTintColor(tintColors)

		self.view.themeBackgroundColor([.white, .black])

		self.label.themeTextColors([.black, .white])
		self.label.themeText(["Toggle Random Views", "Turn Random Views On or Off"])
    }

	lazy var randomViews: [UIView] = {
		var views = [UIView]()
		let colors: [UIColor] = [.red, .yellow, .blue, .black, .green, .purple]
		let size = self.view.frame.size
		for _ in 0...1000 {
			let v = UIView(frame: CGRect(x: self.randomFloat(size.width), y: self.randomFloat(size.height), width: self.randomFloat(100.0), height: self.randomFloat(100.0)))
			v.alpha = 0.0
			views.append(v)
			self.view.insertSubview(v, at: 0)
			let first = colors[Int(arc4random_uniform(UInt32(colors.count)))]
			let second = colors[Int(arc4random_uniform(UInt32(colors.count)))]
			v.themeBackgroundColor([first, second])
		}
		return views
	}()

	@objc func toggleRandomViews() {
		UIView.animate(withDuration: 0.25) {
			for v in self.randomViews {
				v.alpha = self.toggle.isOn ? 1.0 : 0.0
			}
		}
	}

	func randomFloat(_ max: CGFloat) -> CGFloat {
		return CGFloat(arc4random_uniform(UInt32(max)))
	}

	@objc func changeTheme(_ sender: AnyObject?) {
		UIView.animate(withDuration: 0.25) {
			Themer.shared.index = self.segmentedControl.selectedSegmentIndex
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

