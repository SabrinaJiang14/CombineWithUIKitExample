//
//  UIButton+Combine.swift
//  CombineWithUIKitExample
//
//  Created by sabrina on 2020/11/18.
//
import UIKit
import Combine

extension UIButton {
    var tap : CustomPublisher<UIButton> {
        return controlEvent(for: .touchUpInside)
    }
}
