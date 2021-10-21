//
//  TapGameMode.swift
//  LuckyTap
//
//  Created by Ioannis on 13/4/21.
//  Copyright © 2021 iappetos. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper




extension ViewController {
    
    
    func rerollDiceTap() {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        let today = components.day
       
        print("now: \(String(describing: today))")
        print("last: \(self.dayOfLastPlay)")
        
       
        
        ensureDefaults()
        
        //new last day
        KeychainWrapper.standard.set(today!, forKey: keyDayLastPlay)
       
        
        
       
        
        
        
        if isPaidVersionOn {
           rollDice()
        } else {
            if self.dayOfLastPlay == today {//same day
                       
                if self.dailyTrialsLeft <= 0 { //I have spent my daily trials for today
                        
                    if self.extraTrialsFromAds > 0 {//are there any adExtras left?
                                                    print("I just plaied an adExtra")
                                                    rollDice()
                                         } else { //I have spent the daily trials and I have no adExtras stored. What about bought
                                                    
                                                  if self.extraTrialsBought > 0 {
                                                    print("I plaied a boughtExtra")
                                                        rollDice()
                                                       } else {
                                                             showKiosk()
                                                             print("No trials & No extras")
                                                       }
                                           
                                         }//No ad and boughtextras
                        
                            } else { //less than three times play this day
                                         rollDice()
                                         print("I have not play 3 time today yet")
                            }
                    
                   
            } else { //different day
                     rollDice()
                     print("A new day started but if the observer works I will just check trials left ")
                
            }//different day
            
            
        }//paid version
    
        printMySituaton()
     
        
      
    }//rerollDoce
    
    
    
    
   func selectButton1Tap(){
    if self.selectionOfBtn1 == 1 {
        playSound(file: "applaoud")
    } else {
        playSound(file: "lost")
        self.btn1.isEnabled = false
        self.btn1.backgroundColor = UIColor.gray
        self.lblLuckyQuestion.text = "Not a lucky tap!!!"
        
    }
    
    
    /*
        playSound(file: "btnPop")
        if tapCounter == 0 {
        self.selectionOfBtn1 = 1
        self.btn1.setTitle("1", for: .normal)
        self.lblLuckyQuestion.text = "Do you?"
        } else if tapCounter == 1 {
        self.selectionOfBtn1  = 2
        self.btn1.setTitle("2", for: .normal)
        } else if tapCounter == 2 {
        self.selectionOfBtn1 = 3
        self.btn1.setTitle("3", for: .normal)
        self.lblLuckyQuestion.text = "Really???"
        } else {
         self.selectionOfBtn1 = 4
         self.btn1.setTitle("4", for: .normal)
         self.lblLuckyQuestion.text = "Let's see your luck!!!"
        }
        
        self.btn1.isEnabled = false
        tapsPulseAndResult()
        self.btnReload.isEnabled = false
        */
    }//Func
    
    
    func selectButton2Tap(){
        if self.selectionOfBtn2 == 1 {
            playSound(file: "applaoud")
        } else {
            playSound(file: "lost")
            self.btn2.isEnabled = false
            self.btn2.backgroundColor = UIColor.gray
            self.lblLuckyQuestion.text = "Not a lucky tap!!!"
            
        }
        
        
        /*
        playSound(file: "btnPop")
     
      if tapCounter == 0 {
      self.selectionOfBtn2 = 1
      self.btn2.setTitle("1", for: .normal)
      self.lblLuckyQuestion.text = "Do you?"
      } else if tapCounter == 1 {
      self.selectionOfBtn2  = 2
      self.btn2.setTitle("2", for: .normal)
      } else if tapCounter == 2 {
      self.selectionOfBtn2 = 3
      self.btn2.setTitle("3", for: .normal)
      self.lblLuckyQuestion.text = "Really???"
      } else {
       self.selectionOfBtn2 = 4
       self.btn2.setTitle("4", for: .normal)
       self.lblLuckyQuestion.text = "Let's see your luck!!!"
      }
      self.btn2.isEnabled = false
    tapsPulseAndResult()
       self.btnReload.isEnabled = false*/
    }//Func
    
    func selectButton3Tap(){
        
        if self.selectionOfBtn3 == 1 {
            playSound(file: "applaoud")
        } else {
            playSound(file: "lost")
            self.btn3.isEnabled = false
            self.btn3.backgroundColor = UIColor.gray
            self.lblLuckyQuestion.text = "Not a lucky tap!!!"
            
        }
        
        
        /*
        playSound(file: "btnPop")
     
      if tapCounter == 0 {
      self.selectionOfBtn3 = 1
      self.btn3.setTitle("1", for: .normal)
      self.lblLuckyQuestion.text = "Do you?"
      } else if tapCounter == 1 {
      self.selectionOfBtn3  = 2
      self.btn3.setTitle("2", for: .normal)
      } else if tapCounter == 2 {
      self.selectionOfBtn3 = 3
      self.btn3.setTitle("3", for: .normal)
      self.lblLuckyQuestion.text = "Really???"
      } else {
       self.selectionOfBtn3 = 4
       self.btn3.setTitle("4", for: .normal)
       self.lblLuckyQuestion.text = "Let's see your luck!!!"
      }
      self.btn3.isEnabled = false
      tapsPulseAndResult()
       
       self.btnReload.isEnabled = false*/
    }//Func
    
    
    
    func selectButton4Tap(){
        
        
        
        if self.selectionOfBtn4 == 1 {
            playSound(file: "applaoud")
            self.lblLuckyQuestion.text = "That was a lucky tap!!!"
        } else {
            playSound(file: "lost")
            self.btn4.isEnabled = false
            self.btn4.backgroundColor = UIColor.gray
            self.lblLuckyQuestion.text = "Not a lucky tap!!!"
            
        }
        /*
        playSound(file: "btnPop")
        
       if tapCounter == 0 {
       self.selectionOfBtn4 = 1
       self.btn4.setTitle("1", for: .normal)
       self.lblLuckyQuestion.text = "Do you?"
       } else if tapCounter == 1 {
       self.selectionOfBtn4  = 2
       self.btn4.setTitle("2", for: .normal)
       } else if tapCounter == 2 {
       self.selectionOfBtn4 = 3
       self.btn4.setTitle("3", for: .normal)
       self.lblLuckyQuestion.text = "Really???"
       } else {
        self.selectionOfBtn4 = 4
        self.btn4.setTitle("4", for: .normal)
        self.lblLuckyQuestion.text = "Let's see your luck!!!"
       }
       self.btn4.isEnabled = false
       tapsPulseAndResult()
       self.btnReload.isEnabled = false*/
    }//Func
    
}//extention

