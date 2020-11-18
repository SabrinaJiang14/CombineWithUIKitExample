//
//  ViewController.swift
//  CombineWithUIKitExample
//
//  Created by sabrina on 2020/11/18.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mSwitch: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    var cancellables:Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.tap.sink { [weak self] (btn) in
            self?.label.text = "Button Tap"
        }.store(in: &cancellables)
        
        mSwitch.valueChanged.map({ $0.isOn })
            .assign(to: \.isEnabled, on: button)
            .store(in: &cancellables)
    }


}

