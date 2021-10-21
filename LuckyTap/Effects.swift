//
//  Effects.swift
//  LuckyPunk
//
//  Created by Ioannis on 4/5/20.
//  Copyright © 2020 iappetos. All rights reserved.
//

import Foundation
import UIKit



extension ViewController {
    
    func flashAllButtons(){
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.4
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           self.btn1.layer.add(flash, forKey: nil)
           self.btn1.titleLabel?.layer.add(flash, forKey: nil)
        
           self.btn2.layer.add(flash, forKey: nil)
           self.btn2.titleLabel?.layer.add(flash, forKey: nil)
        
           self.btn3.layer.add(flash, forKey: nil)
           self.btn3.titleLabel?.layer.add(flash, forKey: nil)
        
           self.btn4.layer.add(flash, forKey: nil)
           self.btn4.titleLabel?.layer.add(flash, forKey: nil)
       }
    
    
    
    func pulseAllButtons(){
           let pulse = CASpringAnimation(keyPath: "transform.scale")
           pulse.duration = 0.6
           pulse.fromValue = 0.95
           pulse.toValue = 1.0
           pulse.autoreverses = true
           pulse.repeatCount = 2
           pulse.initialVelocity = 0.5
           pulse.damping = 1.0
           
           self.btn1.layer.add(pulse, forKey: nil)
           self.btn2.layer.add(pulse, forKey: nil)
           self.btn3.layer.add(pulse, forKey: nil)
           self.btn4.layer.add(pulse, forKey: nil)
       }
    
    
    
    
    
    func flashBtnOne(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.4
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        self.btn1.layer.add(flash, forKey: nil)
        self.btn1.titleLabel?.layer.add(flash, forKey: nil)
    }
    
    
    func flashBtnTwo(){
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.4
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           self.btn2.layer.add(flash, forKey: nil)
           self.btn2.titleLabel?.layer.add(flash, forKey: nil)
       }
    func flashBtnThree(){
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.4
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           self.btn3.layer.add(flash, forKey: nil)
           self.btn3.titleLabel?.layer.add(flash, forKey: nil)
       }
    
    
    func flashBtnFour(){
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.4
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           self.btn4.layer.add(flash, forKey: nil)
           self.btn4.titleLabel?.layer.add(flash, forKey: nil)
       }
    
    
    func pulseButtonOne(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        self.btn1.layer.add(pulse, forKey: nil)
    }
    
    func pulseButtonTwo(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        self.btn2.layer.add(pulse, forKey: nil)
    }
    
    
    func pulseButtonThree(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        self.btn3.layer.add(pulse, forKey: nil)
    }
    
    
    func pulseButtonFour(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        self.btn4.layer.add(pulse, forKey: nil)
    }
    
    
    func shakeAllButtons(){
        shakeButtonOne()
        shakeButtonTwo()
        shakeButtonThree()
        shakeButtonFour()
    }
    
    
    
    
    func shakeButtonOne(){
           let shake = CASpringAnimation(keyPath: "position")
           shake.duration = 0.1
           shake.repeatCount = 2
           shake.autoreverses = true
         
           let button1 = btn1.center
        
        
           let fromPoint = CGPoint(x: button1.x - 5, y: button1.y)
           let fromValue = NSValue(cgPoint: fromPoint)
        
           let toPoint = CGPoint(x: button1.x + 5, y: button1.y)
           let toValue = NSValue(cgPoint: toPoint)
        
           shake.fromValue = fromValue
           shake.toValue = toValue
           self.btn1.layer.add(shake, forKey: nil)
           
        
       }//F
    
    
    func shakeButtonTwo(){
              let shake = CASpringAnimation(keyPath: "position")
              shake.duration = 0.1
              shake.repeatCount = 2
              shake.autoreverses = true
            
              let button2 = btn2.center
           
           
              let fromPoint = CGPoint(x: button2.x - 5, y: button2.y)
              let fromValue = NSValue(cgPoint: fromPoint)
           
              let toPoint = CGPoint(x: button2.x + 5, y: button2.y)
              let toValue = NSValue(cgPoint: toPoint)
           
              shake.fromValue = fromValue
              shake.toValue = toValue
              self.btn2.layer.add(shake, forKey: nil)
              
           
          }//F
    
    func shakeButtonThree(){
              let shake = CASpringAnimation(keyPath: "position")
              shake.duration = 0.1
              shake.repeatCount = 2
              shake.autoreverses = true
            
              let button3 = btn3.center
           
           
              let fromPoint = CGPoint(x: button3.x - 5, y: button3.y)
              let fromValue = NSValue(cgPoint: fromPoint)
           
              let toPoint = CGPoint(x: button3.x + 5, y: button3.y)
              let toValue = NSValue(cgPoint: toPoint)
           
              shake.fromValue = fromValue
              shake.toValue = toValue
              self.btn3.layer.add(shake, forKey: nil)
              
           
          }//F
    
    func shakeButtonFour(){
              let shake = CASpringAnimation(keyPath: "position")
              shake.duration = 0.1
              shake.repeatCount = 2
              shake.autoreverses = true
            
              let button4 = btn4.center
           
           
              let fromPoint = CGPoint(x: button4.x - 5, y: button4.y)
              let fromValue = NSValue(cgPoint: fromPoint)
           
              let toPoint = CGPoint(x: button4.x + 5, y: button4.y)
              let toValue = NSValue(cgPoint: toPoint)
           
              shake.fromValue = fromValue
              shake.toValue = toValue
              self.btn4.layer.add(shake, forKey: nil)
              
           
          }//F
    
    
    
    
    
    func rezizeAllButtonFonts(fontSize: Float) {
        
        self.btn1.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.btn2.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.btn3.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.btn4.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        
         
        
    }
    
    
    
    
       func freezeButtons() {
           self.btn1.isEnabled = false
           self.btn2.isEnabled = false
           self.btn3.isEnabled = false
           self.btn4.isEnabled = false
       }
       
       func enableButtons() {
              self.btn1.isEnabled = true
              self.btn2.isEnabled = true
              self.btn3.isEnabled = true
              self.btn4.isEnabled = true
          }
   
    
    func emptyButtonLabels() {
        self.btn1.setTitle("", for: .normal)
        self.btn2.setTitle("", for: .normal)
        self.btn3.setTitle("", for: .normal)
        self.btn4.setTitle("", for: .normal)
    }
    
    

 
    
    
}//ext

