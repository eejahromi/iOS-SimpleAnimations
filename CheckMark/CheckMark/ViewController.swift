//
//  ViewController.swift
//  CheckMark
//  Copyright © 2017 Ehsan Jahromi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var checkBox:UIView = {
        let box = UIView()
        box.frame = CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0)
        box.layer.cornerRadius = box.bounds.size.width/2
        box.layer.masksToBounds = true
        box.backgroundColor = UIColor(red: 1, green: 81, blue: 134)
        return box
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        checkBox.center = view.center
        view.addSubview(checkBox)
    }

}

extension UIColor {
    convenience public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

