//
//  ViewController.swift
//  testaggio
//  Created by Alessandro Ornano on 01/04/2017.
//  Copyright © 2017 test. All rights reserved.
//
import UIKit
@available(iOS 10.0, *)
class ViewController: UIViewController {
    var blurView: UIVisualEffectView!
    var effect: UIBlurEffectStyle = .light
    var blurEffect : UIBlurEffect!
    var animator: UIViewPropertyAnimator!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This code make more transparent our navigation
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationBar.tintColor = .white
            let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
            navigationBar.titleTextAttributes = textAttributes
            navigationBar.shadowImage = UIImage()
            navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.5, alpha: 0.3)
            navigationBar.isTranslucent = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            effect = .prominent
            if let navigationBar = navigationController?.navigationBar {
                let noEffectView = UIVisualEffectView.init(frame: navigationBar.bounds)
                self.blurEffect = UIBlurEffect(style: effect)
                self.blurView = noEffectView
                navigationBar.addSubview(self.blurView)
                // This line below to don't blur buttons and title
                navigationBar.sendSubview(toBack: self.blurView)
                // Apply the effect:
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.applyBlur), userInfo: nil, repeats: false)
            }
    }
    func applyBlur() {
        print("Apply the blur effect..")
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
        self.blurView.effect = self.blurEffect
        animator.addAnimations {
            self.blurView.effect = nil
        }
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.changeBlurFraction), userInfo: nil, repeats: true)

    }
    func changeBlurFraction() {
        let startNum:CGFloat = 0.0; let stopNum:CGFloat = 200.0
        let randomNum = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(startNum - stopNum) + min(startNum, stopNum)
        var blurFraction = (randomNum / 200)
        blurFraction = blurFraction > 1.0 ? 1.0 : blurFraction
        print("we change the blur fraction to : \(blurFraction)")
        animator.fractionComplete = blurFraction
    }
}
