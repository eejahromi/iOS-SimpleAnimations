//
//  ViewController.swift
//  CheckMark
//  Copyright © 2017 Ehsan Jahromi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    let pathLayer = CAShapeLayer()
    var pathAnimation: CABasicAnimation!
    var reversePathAnimation: CABasicAnimation!
    
    var check: Bool = false {
        didSet {
            if check {
                self.checkBox.layer.addSublayer(self.pathLayer)
                self.pathLayer.strokeEnd = 1.0
                self.pathLayer.removeAllAnimations()
                self.pathLayer.add(self.pathAnimation, forKey:"strokeEnd")
            } else {
                pathLayer.strokeEnd = 0.0
                pathLayer.removeAllAnimations()
                pathLayer.add(reversePathAnimation, forKey:"strokeEnd")
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
        
        checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(ViewController.checkMarkTapped(sender:))))
        checkBox.center = view.center
        view.addSubview(checkBox)
        
        pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        reversePathAnimation = CABasicAnimation(keyPath:"strokeEnd")
        reversePathAnimation.delegate = self

        createPath()
        addAnimation(animation: pathAnimation, from: 0, to: 1)
        addAnimation(animation: reversePathAnimation, from: 1, to: 0)
    }
    
    private func createPath() {
        /**
                           * <- (3)
                         *
         (1) ->  *     *
                  *  *
           (2) ->  *
         */
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 120 * 3 / 5)) // (1)
        path.addLine(to: CGPoint(x: 100 / 2, y: 110)) // (2)
        path.addLine(to: CGPoint(x: 120, y: 40))      // (3)
        
        pathLayer.frame = checkBox.bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.white.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 12
        pathLayer.lineJoin = kCALineJoinRound
        pathLayer.lineCap = kCALineCapRound
    }
    
    private func addAnimation(animation: CABasicAnimation, duration: CFTimeInterval = 0.5, from: Double, to: Double) {
        animation.duration = duration
        animation.fromValue = NSNumber(floatLiteral: from)
        animation.toValue = NSNumber(floatLiteral: to)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        pathLayer.removeFromSuperlayer()
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

