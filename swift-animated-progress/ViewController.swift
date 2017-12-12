//
//  ViewController.swift
//  swift-animated-progress
//
//  Created by Andrew Gorzny on 2017-12-11.
//  Copyright © 2017 Andrew Gorzny. All rights reserved.
//
//  Tutorial based on this: https://www.youtube.com/watch?v=O3ltwjDJaMk


import UIKit

class ViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    var mainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Draw Circle

        
        let center = view.center
        
        //Track layer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.init(hexString: "#9FE3FD").cgColor
        trackLayer.lineWidth = 16
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound

        self.view.layer.addSublayer(trackLayer)

        
        //Add Label
        mainLabel.frame = CGRect(x: 0, y: (view.frame.height/2)-10, width: view.frame.width, height: 30.0)
        mainLabel.text = "TAP"
        mainLabel.textColor = UIColor.white
        mainLabel.font = mainLabel.font.withSize(28)
        mainLabel.textAlignment = .center
        
        view.addSubview(mainLabel)
        
        // Solid Fill Layer (animated)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 16
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(shapeLayer)
        

        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateMe)))
    }
    
    @objc private func animateMe() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1.5
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
    
        shapeLayer.add(animation, forKey: "basicAnimation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

