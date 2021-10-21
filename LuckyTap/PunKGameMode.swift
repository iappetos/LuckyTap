//
//  GameModes.swift
//  LuckyTap
//
//  Created by Ioannis on 13/4/21.
//  Copyright © 2021 iappetos. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper




extension ViewController {
    
    
    func rerollDicePunk() {
        
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
    
    
    
    
   func selectButton1Punk(){
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
        
    }//Func
    
    
    func selectButton2Punk(){
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
       self.btnReload.isEnabled = false
    }//Func
    
    func selectButton3Punk(){
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
       
       self.btnReload.isEnabled = false
    }//Func
    
    
    
    func selectButton4Punk(){
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
       self.btnReload.isEnabled = false
    }//Func
    
    
    
    func tapsPulseAndResult(){
        
        self.tapCounter += 1
        
        if self.tapCounter < 4 {
           //Do Nothing
        } else {
            pulseAllButtons()
            flashAllButtons()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                 self.checkResulShowFeedbackAndInformCounters()
                 self.tapCounter = 0
            }
        }
        
        
    }//Func
    
    func checkResulShowFeedbackAndInformCounters(){
        
       rezizeAllButtonFonts(fontSize: 40)
        
        
        if selectionOfBtn1 == numberOfBtn1 {
            self.scoreCounter += 1
            self.btn1.setTitle("Lucky", for: .normal)
        } else {
            self.btn1.setTitle("Punk", for: .normal)
        }
        
        if selectionOfBtn2 == numberOfBtn2 {
                self.scoreCounter += 1
             self.btn2.setTitle("Lucky", for: .normal)
        } else {
            self.btn2.setTitle("Punk", for: .normal)
        }
        
        if selectionOfBtn3 == numberOfBtn3 {
                self.scoreCounter += 1
            self.btn3.setTitle("Lucky", for: .normal)
        } else {
                    self.btn3.setTitle("Punk", for: .normal)
                }
        
        if selectionOfBtn4 == numberOfBtn4 {
               self.scoreCounter += 1
            self.btn4.setTitle("Lucky", for: .normal)
        } else {
            self.btn4.setTitle("Punk", for: .normal)
        }
        
        print("the score is:  \(self.scoreCounter)")
        
        if self.scoreCounter == 0 {
            
            playSound(file: "whistle")
            self.lblLuckyQuestion.text = "Stay home!!!"
        } else if self.scoreCounter == 1 {
            
             playSound(file: "lost")
           // self.lblLuckyQuestion.font = UIFont.systemFont(ofSize: CGFloat(8))
            self.lblLuckyQuestion.text =  "Smile, it could be worst."
        } else if self.scoreCounter == 2 {
             playSound(file: "lost")
            // self.lblLuckyQuestion.font = UIFont.systemFont(ofSize: CGFloat(8))
            self.lblLuckyQuestion.text =  "Not bad."
        } else if self.scoreCounter == 3 {
             playSound(file: "lost")
           // self.lblLuckyQuestion.font = UIFont.systemFont(ofSize: CGFloat(8))
            self.lblLuckyQuestion.text = "How did you do it?"
        } else if self.scoreCounter == 4 {
           // self.lblLuckyQuestion.font = UIFont.systemFont(ofSize: CGFloat(8))
            playSound(file: "applaoud")
            self.lblLuckyQuestion.text = "This is your lucky day!!!"
        }
        
        
        self.scoreCounter = 0
        
        
        self.btnReload.isEnabled = true
    
        
        if isPaidVersionOn {
            //Do nothing
        } else {
            informCorrectCountersAndStoreData()
           // saveDateOfLastGameInCoreData()
           // saveTrialsLeftOfLastGameInCoreData()
        }
       
      
    }//Func
    
    
    
    func informCorrectCountersAndStoreData(){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let today = components.day
        print("now: \(String(describing: today))")
        print("last: \(self.dayOfLastPlay))")
        
        
        ensureDefaults()
    /*
        if let dayLP = UserDefaults.standard.value(forKey: keyDayLastPlay) as? Int {
                          self.dayOfLastPlay = dayLP
                          print("day of last play: \(dayLP)")
               }//Day self.dayOfLastPlay = ld
    */
        
        if self.dayOfLastPlay == today {//same day

                   if self.dailyTrialsLeft <= 0 { //I have spent my daily trials for today
                                 //I check if I have any extras from Ads
                                 if self.extraTrialsFromAds > 0 {//are there any extras left?
                                    
                                    //deduct and store ads
                                    self.extraTrialsFromAds -= 1
                                    KeychainWrapper.standard.set(self.extraTrialsFromAds, forKey: keyExtrasFromAds)
                                   // UserDefaults.standard.synchronize()
                                    
                                    deductOneFromExtrasTotal()
                                  
                                    print("Ad deducted and total arranged")
                                } else  if self.extraTrialsBought > 0  { //I have no ads extra so I check bought also
                                   
                                    //deduct and store bought
                                    self.extraTrialsBought -= 1
                                    KeychainWrapper.standard.set(self.extraTrialsBought, forKey: keyExtrasBought)
                                    //UserDefaults.standard.synchronize()
                                    
                                    deductOneFromExtrasTotal()
                                    print("Bought deducted and total arranged")
                                    
                                    
                                    //do nothing
                                 } else { //I have spent the daily trials and I have no extras stored
                                 //do nothing
                                   }
                    
                    
                    
                   } else { //less than three times play this day so I m in daily zone
                   
                          deductOneFromDaily()
                            print("Dily Zone , less than 3")
                   }
                
            
        } else { //It is a new different day
            deductOneFromDaily()
          print("different day?")
        }
        
        //Now store this day as Last day
        KeychainWrapper.standard.set(today!, forKey: keyDayLastPlay)
       // UserDefaults.standard.synchronize()
    
       
        
        
    }//Func
    
    
}//extention

