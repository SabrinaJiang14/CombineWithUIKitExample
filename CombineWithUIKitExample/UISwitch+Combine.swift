//
//  UISwitch+Combine.swift
//  CombineWithUIKitExample
//
//  Created by sabrina on 2020/11/18.
//

import UIKit
import Combine

extension UISwitch {
    var valueChanged : CustomPublisher<UISwitch> {
        return controlEvent(for: .valueChanged)
    }
}
