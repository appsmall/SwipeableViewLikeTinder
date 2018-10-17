//
//  ViewController.swift
//  SwipeableCardView
//
//  Created by Rahul Chopra on 15/10/18.
//  Copyright © 2018 Rahul Chopra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movedView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var divisor: CGFloat!
    
    
    override func viewDidLoad() {
        divisor = (view.frame.width / 2) / 0.61
    }

    @IBAction func viewPanGestureAction(_ sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: movedView)
        let xFromCenter = movedView.center.x - view.center.x
        movedView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)

        let scale = min(100/abs(xFromCenter), 1)
        movedView.transform = CGAffineTransform(rotationAngle: (xFromCenter / divisor)).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 {
            //Moving in +ve direction
            imageView.image = UIImage(named: "thumb-up")
            imageView.tintColor = UIColor.green
        }
        else {
            //Moving in -ve direction
            imageView.image = UIImage(named: "thumb-down")
            imageView.tintColor = UIColor.red
        }
        
        imageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if movedView.center.x < 75 {
                // Move off to the left side
                UIView.animate(withDuration: 0.4) {
                    self.movedView.center = CGPoint(x: self.movedView.center.x - 200, y: self.movedView.center.y + 75)
                    self.movedView.alpha = 0
                }
                return
            }
            else if movedView.center.x > (self.view.frame.width - 75) {
                // Move off to the right side
                UIView.animate(withDuration: 0.4) {
                    self.movedView.center = CGPoint(x: self.movedView.center.x + 200, y: self.movedView.center.y + 75)
                    self.movedView.alpha = 0
                }
                return
            }
            
            resetCard()
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2) {
            self.movedView.center = self.view.center
            self.imageView.alpha = 0
            self.movedView.alpha = 1
            self.movedView.transform = .identity
        }
    }
}

