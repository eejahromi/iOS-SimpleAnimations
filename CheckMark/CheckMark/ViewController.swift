//
//  ViewController.swift
//  CheckMark
//  Copyright © 2017 Ehsan Jahromi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pathAnimation: CABasicAnimation!
    let pathLayer = CAShapeLayer()
    
    var check: Bool = false {
        didSet {
            if check {
                self.checkBox.layer.addSublayer(self.pathLayer)
                self.pathLayer.strokeEnd = 1.0
                self.pathLayer.removeAllAnimations()
                self.pathLayer.add(self.pathAnimation, forKey:"strokeEnd")
            }
        }
    }
    
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
        
        pathAnimation = CABasicAnimation(keyPath: "strokeEnd")

        checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.checkMarkTapped(sender:))))
        checkBox.center = view.center
        view.addSubview(checkBox)
        
        createPath()
    }
    
    private func createPath() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 120 * 3 / 5))
        path.addLine(to: CGPoint(x: 100 / 2, y: 110))
        path.addLine(to: CGPoint(x: 120, y: 40))
        
        pathLayer.frame = checkBox.bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.white.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 12
        pathLayer.lineJoin = kCALineJoinRound
        pathLayer.lineCap = kCALineCapRound
        
        addAnimation(animation: CABasicAnimation(keyPath:"strokeEnd"), from: 0, to: 1)
    }
    
    private func addAnimation(animation: CABasicAnimation, duration: CFTimeInterval = 0.5, from: Double, to: Double) {
        pathAnimation.duration = duration
        pathAnimation.fromValue = NSNumber(floatLiteral: from)
        pathAnimation.toValue = NSNumber(floatLiteral: to)
    }
    
    //MARK: - Action
    @objc func checkMarkTapped(sender: UIGestureRecognizer) {
        check = !check
    }

}

// MARK: -
extension UIColor {
    convenience public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

