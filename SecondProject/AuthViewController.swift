//
//  AuthViewController.swift
//  SecondProject
//
//  Created by Sergey Dimitriev on 19/06/2019.
//  Copyright © 2019 Sergey Dimitriev. All rights reserved.
//

import UIKit
import SwiftSVG

class AuthViewController: UIViewController {
    
    @IBOutlet weak var AuthLogo: UIImageView!
    @IBOutlet weak var userIcon: UIView!
    @IBOutlet weak var passwordIcon: UIView!
    
    @IBOutlet weak var LabelUsername: UILabel!
    @IBOutlet weak var InputUsername: UITextField!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var InputPassword: UITextField!
    
    @IBOutlet weak var borderUsername: UILabel!
    @IBOutlet weak var borderPassword: UIView!
    
    @IBOutlet weak var buttonForgot: UIButton!
    @IBOutlet weak var singIn: UIButton!
    @IBOutlet weak var registration: UIButton!
    
    
    @IBOutlet weak var balls_1: UIView!
    @IBOutlet weak var balls_2: UIView!
    @IBOutlet weak var balls_3: UIView!
    @IBOutlet weak var balls_4: UIView!
    @IBOutlet weak var balls_5: UIView!
    @IBOutlet weak var balls_6: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balls_1.setGradientBackgroundFilters(
            colorOne: UIColor(red:81/255, green:206/255, blue:236/255, alpha:1),
            colorTwo: UIColor(red:83/255, green:253/255, blue:195/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 42
        )
        balls_1.layer.cornerRadius = 42

        balls_2.setGradientBackgroundFilters(
            colorOne: UIColor(red:62/255, green:208/255, blue:254/255, alpha:1),
            colorTwo: UIColor(red:8/255, green:95/255, blue:229/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 65
        )
        balls_2.layer.cornerRadius = 65
        
        balls_3.setGradientBackgroundFilters(
            colorOne: UIColor(red:86/255, green:49/255, blue:243/255, alpha:1),
            colorTwo: UIColor(red:58/255, green:226/255, blue:255/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 109
        )
        balls_3.layer.cornerRadius = 109
        
        balls_4.setGradientBackgroundFilters(
            colorOne: UIColor(red:86/255, green:49/255, blue:243/255, alpha:1),
            colorTwo: UIColor(red:58/255, green:226/255, blue:255/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 34
        )
        balls_4.layer.cornerRadius = 34
        
        balls_5.setGradientBackgroundFilters(
            colorOne: UIColor(red:86/255, green:49/255, blue:243/255, alpha:1),
            colorTwo: UIColor(red:58/255, green:226/255, blue:255/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 97
        )
        balls_5.layer.cornerRadius = 97
        
        balls_6.setGradientBackgroundFilters(
            colorOne: UIColor(red:83/255, green:253/255, blue:195/255, alpha:1),
            colorTwo: UIColor(red:81/255, green:206/255, blue:236/255, alpha:1),
            sCGPoint: CGPoint(x: 0.0, y: 0.0),
            eCGPoint: CGPoint(x: 1.0, y: 0.0),
            locations: [0.0, 1.0],
            border: 35
        )
        balls_6.layer.cornerRadius = 35
        
        borderUsername.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        borderPassword.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        
        AuthLogo.frame.size.height = 90
        AuthLogo.frame.size.width = 90
        AuthLogo.image = UIImage(named:"logo")
        AuthLogo.contentMode = .scaleAspectFit
        AuthLogo.translatesAutoresizingMaskIntoConstraints = false
        AuthLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        LabelUsername.textColor = UIColor(red: 132/255, green: 146/255, blue: 166/255, alpha: 1.0)
        labelPassword.textColor = UIColor(red: 132/255, green: 146/255, blue: 166/255, alpha: 1.0)
        
        let user = UIView(SVGNamed: "user") { (svgLayer) in
            svgLayer.fillColor = UIColor(red:132/255, green:146/255, blue:166/255, alpha:1).cgColor
            svgLayer.resizeToFit(self.userIcon.bounds)
        }
        userIcon.addSubview(user)
        userIcon.backgroundColor = UIColor.white
        
        let lock = UIView(SVGNamed: "lock") { (svgLayer) in
            svgLayer.fillColor = UIColor(red:132/255, green:146/255, blue:166/255, alpha:1).cgColor
            svgLayer.resizeToFit(self.passwordIcon.bounds)
        }
        passwordIcon.addSubview(lock)
        passwordIcon.backgroundColor = UIColor.white
        
        buttonForgot.setTitleColor(UIColor.themeMoreButton, for: .normal)
        
        singIn.setTitleColor(.white, for: .normal)
        singIn.setGradientBackground(
            colorOne: UIColor(red:81/255, green:206/255, blue:236/255, alpha:1),
            colorTwo: UIColor(red:83/255, green:253/255, blue:195/255, alpha:1)
        )
        
        
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //contentView = CGPoint(x: 0, y: kbFrameSize.height)
        //print(kbFrameSize.height)
        
        AuthLogo.frame.size.height = 38
        AuthLogo.frame.size.width = 38
        
    }
    
    @objc func kbWillHide() {
        print(CGPoint.zero)
        //contentView = CGPoint.zero
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        InputUsername.resignFirstResponder()
        InputPassword.resignFirstResponder()
    }
}
extension UIColor {
    static var themeMoreButton = UIColor.init(red: 132/255, green: 146/255, blue: 166/255, alpha: 1.0)
}
extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setGradientBackgroundFilters(colorOne: UIColor, colorTwo: UIColor, sCGPoint: CGPoint, eCGPoint: CGPoint, locations: Array<Any>, border: NSNumber) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = locations as! [NSNumber]
        gradientLayer.startPoint = sCGPoint
        gradientLayer.endPoint = eCGPoint
        gradientLayer.cornerRadius = CGFloat(border)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
