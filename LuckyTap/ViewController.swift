//
//  ViewController.swift
//  LuckyPunk
//
//  Created by Ioannis on 23/4/20.
//  Copyright © 2020 iappetos. All rights reserved.
//
//AdMob appID: ca-app-pub-7727480235361635~3974086919
//AdMob unitID: ca-app-pub-7727480235361635/6452910594
//AdMob rewardAdID: ca-app-pub-7727480235361635/9547979238
//testID: ca-app-pub-3940256099942544/2934735716
//testRewardID: ca-app-pub-3940256099942544/1712485313



import UIKit
import GoogleMobileAds
import CoreData
import UserNotifications
import AVFoundation
import SwiftKeychainWrapper
//import IAPReceiptVerifier


//Global Variables
//let appDelegate = UIApplication.shared.delegate as? AppDelegate
//var earned = Int()

class ViewController: UIViewController, AVAudioPlayerDelegate  {
    
   
    var gameMode: Int = 1
    
    let myStoreManager = IAPManager()
    var audioPlayer = AVAudioPlayer()
  
    var rewardedAd: GADRewardedAd?
    var numberOfBtn1 = Int()
    var numberOfBtn2 = Int()
    var numberOfBtn3 = Int()
    var numberOfBtn4 = Int()
    
    var selectionOfBtn1 = Int()
    var selectionOfBtn2  = Int()
    var selectionOfBtn3  = Int()
    var selectionOfBtn4  = Int()
    
    var tapCounter: Int = 0
    var scoreCounter: Int = 0
    
    var dayOfLastPlay = Int()
    var dateOfLastPlay = Date()
    var dailyTrialsLeft: Int = 3
    
    var isDarkModeSelected: Bool = false
    var isPaidVersionOn: Bool = true
    
    var adRewardingCoin: Int = 0
    var extraTrialsTotal: Int = 0
    var extraTrialsFromAds: Int = 0
    var extraTrialsBought: Int = 0
    
    
    let keyTrailsLeft = "dailyTrialsLeft"
    let keyDayLastPlay = "dayOfLastPlay"
    let keyExtrasFromAds = "extrasFromAds"
    let keyExtrasBought = myProductList.extraTrials
    let keyExtrasTotal = "extraTotal"
    
    var boughtProduct: SKProduct?
    
    
    
    
    
    
    
    //Quotes
    let quote1 = "I think we consider too much the luck of the early bird and not enough the bad luck of the early worm.(Franklin D. Roosevelt)"
    let quote2 = "Here’s the thing about luck…you don’t know if it’s good or bad until you have some perspective.(Alice Hoffman)"
    let quote3 = "Learn to recognize good luck when it’s waving at you, hoping to get your attention.(Sally Koslow)"
    let quote4 = "The harder I work, the luckier I get.(Samuel Goldwyn)"
    let quote5 = "Luck is what we make it, not what is thrust upon us. You’ve shown initiative and it has nothing to do with luck.(George Bellairs)"
    let quote6 = "Luck is great, but most of life is hard work.(Iain Duncan Smith)"
    
    
    
    
   // var myGames = [GameData]()
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var lblLuckyQuestion: UILabel!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var btnDarkMode: UIButton!
    @IBOutlet weak var lblGamesLeft: UILabel!
    @IBOutlet weak var lblExtrasLeft: UILabel!
    @IBOutlet weak var btnRewardAd: UIButton!
   
    
    
    
    //MARK: - ViewDidLoad & Actions
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "hh:mm a"
        return tmpFormatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
            loadDefaults()
       
        
        
        
       // refreshContent()
    }
   
    /*
    @objc func dayChanged() -> Bool{
         NotificationCenter.default.addObserver(self, selector: #selector(dayChanged), name: .NSCalendarDayChanged, object: nil)
        return true
    }
    */
    
    //Notification when day changes
    @objc func dayChanged(notification: NSNotification){
        KeychainWrapper.standard.set(3, forKey: keyTrailsLeft)
        self.dailyTrialsLeft = 3
        self.lblGamesLeft.text = "\( self.dailyTrialsLeft)/3 today"
    }
  
    override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(dayChanged), name: .NSCalendarDayChanged, object: nil)
          
            loadFreeOrPaid()
            loadGameMode()
        
            myStoreManager.viewDelegate = self
            
            //AD in the banner
            self.bannerView.adUnitID = "ca-app-pub-7727480235361635/6452910594"
            self.bannerView.rootViewController = self
            self.bannerView.load(GADRequest())
            
            bannerView.delegate = self
         
           
           //rewardedAd
          // GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
           
            rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-7727480235361635/9547979238")
            rewardedAd?.load(GADRequest()) { error in
              if let error = error {
                // Handle ad failed to load case.
               print(error)
              } else {
               print("Ad success") // Ad successfully loaded.
              }
            }
           
          
           
           
          
          // checkIfYouAreInTheSameDay()
           //deleteAllData("GameData")
          // fetchGameData()
          
        if isPaidVersionOn {
            self.lblGamesLeft.text = ""
            self.lblExtrasLeft.text = ""
            self.btnRewardAd.setTitle("", for: .normal)
            self.btnRewardAd.isEnabled  = false
            
        } else {
            loadDefaults()
        }
        
       
            allocateNumbersOnButtons()
        printMySituaton()
        
        }//viewDidLoad
        
    
    func refreshContent() {
           print("it RUN---------------------------")
           if ProductDelivery.isProductAvailable(identifier: myProductList.extraTrials) {
             
               self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
           } else {
               self.lblExtrasLeft.text = "Extra trials not loaded"
           }
           
       }
        
    
    
    
    /*
    
    @IBAction func testBuyingExtras(_ sender: Any) {
        self.extraTrialsBought += 5
        UserDefaults.standard.set(self.extraTrialsBought, forKey: keyExtrasBought)
        
        self.extraTrialsTotal += 5
        UserDefaults.standard.set(self.extraTrialsTotal, forKey: keyExtrasTotal)
        
        if self.extraTrialsTotal == 1 {
                   self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
               } else {
                   self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
               }
        
        
    }
    
    */
    
    
    
    
    
    @IBAction func playRewardingAd(_ sender: Any) {
       
        if isPaidVersionOn {
           // showCompany()
        } else {
             //-------------------------
            rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-7727480235361635/9547979238")
            rewardedAd?.load(GADRequest()) { error in
              if let error = error {
                // Handle ad failed to load case.
               print(error)
              } else {
                
                print("Ad success") // Ad successfully loaded.
                    //execute
                    if self.rewardedAd?.isReady == true {
                    self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                    }
             
              } //if not error
            } //in
            
           //-------------------------
            
            
            
            
            
          /*
            if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: self, delegate:self)
                   }
          */
        }//notPaidVersion
        
        
    }//Func
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func changeToDarkLightMode(_ sender: Any) {
        if isDarkModeSelected {
            self.view.backgroundColor = UIColor.white
            self.lblLuckyQuestion.textColor = UIColor.black
            self.btnDarkMode.setTitle("Dark Background", for: .normal)
            
        } else {
            self.view.backgroundColor = UIColor.black
            self.lblLuckyQuestion.textColor = UIColor.white
             self.btnDarkMode.setTitle("White Background", for: .normal)
        }
       
        isDarkModeSelected = !isDarkModeSelected
        
    }
    
    
    
    
    
    @IBAction func rerollTheDice(_ sender: Any) {
        
        if gameMode == 0 {
            rerollDicePunk()
        } else if gameMode == 1 {
            rerollDiceTap()
        }
        
        
        
      
        
    }//Action
    
    
    
    
    
    
    
    
    
    @IBAction func selectButtonOne(_ sender: Any) {
        
        if gameMode == 0 {
            self.selectButton1Punk()
        } else if gameMode == 1 {
            self.selectButton1Tap()
        }
        
        
    }//Func
    
    
    
    
    @IBAction func selectButtonTwo(_ sender: Any) {
        if gameMode == 0 {
            self.selectButton2Punk()
        } else if gameMode == 1 {
            self.selectButton2Tap()
        }
        
    }//Func
    
    
    
    
    @IBAction func selectButtonThree(_ sender: Any) {
        if gameMode == 0 {
            self.selectButton3Punk()
        } else if gameMode == 1 {
            self.selectButton3Tap()
        }
    }//Func
    
    
    
    @IBAction func selectButtonFour(_ sender: Any) {
        if gameMode == 0 {
            self.selectButton4Punk()
        } else if gameMode == 1 {
            self.selectButton4Tap()
        }
    }//Func
    
    
    
     
    
    
    func  loadGameMode(){
        if gameMode == 0 {
            
        } else if gameMode == 1 {
            self.btn1.layer.masksToBounds = true
            self.btn1.layer.cornerRadius = self.btn1.frame.width/2
            
            self.btn2.layer.masksToBounds = true
            self.btn2.layer.cornerRadius = self.btn1.frame.width/2
            
            self.btn3.layer.masksToBounds = true
            self.btn3.layer.cornerRadius = self.btn1.frame.width/2
            
            self.btn4.layer.masksToBounds = true
            self.btn4.layer.cornerRadius = self.btn1.frame.width/2
        }
       
    }
    
     
    
    //MARK: Functions
    /*
    func checkIfYouAreInTheSameDay(){
       fetchGameData()
        let lastTrialsDate = myGames[0].lastLDatePlayed
        let lastTrialsDay = getDayFromDate(inputDate: lastTrialsDate!)
        let lastTrialsMonth = getMonthFromDate(inputDate: lastTrialsDate!)
        let lastTrialsYear = getYearFromDate(inputDate: lastTrialsDate!)
        
        
        let today = Date()
        let dayOfNow = getDayFromDate(inputDate: today)
        let monthOfNow = getMonthFromDate(inputDate: today)
        let yearOfNow = getYearFromDate(inputDate: today)
        
        
        
        if dayOfNow == lastTrialsDay && monthOfNow == lastTrialsMonth && yearOfNow == lastTrialsYear   { //same day
            
            
            if self.myGames == [] {// First time EVER
                self.dailyTrialsLeft = 3
            } else {
                self.dailyTrialsLeft = Int(myGames[0].daysTrialsLeft)
            }
            
          
            
        } else {
            self.dailyTrialsLeft = 3
        }
        
        
      self.lblGamesLeft.text = "\(self.dailyTrialsLeft) daily trials left "
        
        
    }//func
    
    */
    func rollDice(){
        allocateNumbersOnButtons()
        enableButtons()
        emptyButtonLabels()
        shakeAllButtons()
        rezizeAllButtonFonts(fontSize: 80)
        playSound(file: "btnDice")
        
        self.lblLuckyQuestion.text = "Do you feel lucky today?"
    }
    
    
    
    
     func allocateNumbersOnButtons(){
         var positions = [1, 2, 3, 4]
         var thesi = Int()
         self.numberOfBtn1 = positions.randomElement()!
         
     
         for i in 0...positions.count - 1 {
             if self.numberOfBtn1 == positions[i] {
             thesi = i
             }
         }
         
         positions.remove(at: thesi)
         print(positions)
         
         self.numberOfBtn2 = positions.randomElement()!
         
         
         for i in 0...positions.count - 1 {
             if self.numberOfBtn2 == positions[i] {
                 thesi = i
             }
         }
         
         positions.remove(at: thesi)
         print(positions)
         
          self.numberOfBtn3 = positions.randomElement()!
         
         for i in 0...positions.count - 1 {
             if self.numberOfBtn3 == positions[i] {
                 thesi = i
             }
         }
         
         positions.remove(at: thesi)
         print(positions)
         self.numberOfBtn4 = positions[0]
         
          print(" Button 1 position: \(self.numberOfBtn1)")
          print(" Button 2 position: \(self.numberOfBtn2)")
          print(" Button 3 position: \(self.numberOfBtn3)")
          print(" Button 4 position: \(self.numberOfBtn4)")
          print(" ---------------------------------------")
         
     }//Func
     
     
 
    
    
  
    
    func showKiosk(){
            let myKiosk = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpCounter") as! KioskViewController
        //Hey "myKiosk"(Boss) you have a variable called "extrasDelegate"which is your "intern" and I(self) want to be your "Intern"(legatos)
        
        //PROTOCOLS---------------------------------
       // myKiosk.extrasDelegate = self
       // myKiosk.unlimitedDelegate = self
        
            self.addChild(myKiosk)
            myKiosk.view.frame = self.view.frame
            self.view.addSubview(myKiosk.view)
            myKiosk.didMove(toParent: self)
    }
    
    func loadFreeOrPaid(){
        let isPaid = KeychainWrapper.standard.bool(forKey: myProductList.unlimited ) ?? false
        if isPaid {
                   self.isPaidVersionOn = true
               }
    }//Func
    
  
    
    
    
    func getDayFromDate(inputDate: Date) -> Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: inputDate)
            let day = components.day!
            return day
       }
       
       
       
       func getMonthFromDate(inputDate: Date) -> Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: inputDate)
            let month = components.month!
            return month
       }
       
       func getYearFromDate(inputDate: Date) -> Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: inputDate)
            let year = components.year!
            return year
       }
       
       func getDayOfTodayDate() -> Int {
           let myDate = Date()
           let calendar = Calendar.current
           let components = calendar.dateComponents([.year, .month, .day], from: myDate)

           let year =  components.year!
           let month = components.month!
           let day = components.day!

           print(year)
           print(month)
           print(day)
           
           return day
       }
       
       
       func getMonthOfTodayDate() -> Int {
           let myDate = Date()
           let calendar = Calendar.current
           let components = calendar.dateComponents([.year, .month, .day], from: myDate)

           let year =  components.year!
           let month = components.month!
           let day = components.day!

           print(year)
           print(month)
           print(day)
           
           return month
       }
       
       
       func getYearOfTodayDate() -> Int {
              let myDate = Date()
              let calendar = Calendar.current
              let components = calendar.dateComponents([.year, .month, .day], from: myDate)

              let year =  components.year!
              let month = components.month!
              let day = components.day!

              print(year)
              print(month)
              print(day)
              
              return year
          }
       
    
    func getDayOfLastPlay() -> Int {
           let myDate = Date()
           let calendar = Calendar.current
           let components = calendar.dateComponents([.year, .month, .day], from: myDate)

           let year =  components.year!
           let month = components.month!
           let day = components.day!

           print(year)
           print(month)
           print(day)
           
           return day
       }
    
    
    
    
    func loadDefaults(){
        
        //First I check the date
        if let dayLP = KeychainWrapper.standard.integer(forKey: "dayOfLastPlay") {
                   self.dayOfLastPlay = dayLP
                   print("day of last play: \(dayLP)")
        }//Day
        
        //then I check if I am in the same day
        let today = getDayOfTodayDate()
        if self.dayOfLastPlay == today { //you have plaid today
            
            //Do nothing
            
            
        } else {//first game for today
            //A new day so i will zero your GameConter
           KeychainWrapper.standard.set(3, forKey: keyTrailsLeft)
            
            
        }
        
   
        
        if let dailyTL = KeychainWrapper.standard.integer(forKey: keyTrailsLeft) {
            self.dailyTrialsLeft = dailyTL
            self.lblGamesLeft.text =  "\(dailyTL)/3 today"
            print("daily trials left: \(dailyTL)")
        }
        
       
        
        if let extraTB = KeychainWrapper.standard.integer(forKey: keyExtrasBought) {
           self.extraTrialsBought = extraTB
           print("extrasBought: \(extraTB)")
        }
        
    
        
        if let extraTA = KeychainWrapper.standard.integer(forKey: keyExtrasFromAds) {
           self.extraTrialsFromAds = extraTA
           print("extraFromAds: \(extraTA)")
        }
        
        
        self.extraTrialsTotal = self.extraTrialsFromAds + self.extraTrialsBought
        KeychainWrapper.standard.set(self.extraTrialsTotal, forKey: keyExtrasTotal)
        
        if let extraTotal = KeychainWrapper.standard.integer(forKey: keyExtrasTotal) {
            self.extraTrialsTotal = extraTotal
            print("extraFTotal: \(extraTotal)")
        }
        
        
        if  self.extraTrialsTotal == 1  {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
        } else {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
        }
        
     
        
        if self.dailyTrialsLeft > 0 || self.extraTrialsTotal > 0 {
            enableButtons()
        } else {
            freezeButtons()
        }
        
        if isPaidVersionOn {
                       self.lblGamesLeft.text = ""
                       self.lblExtrasLeft.text = ""
                       self.btnRewardAd.setTitle("", for: .normal)
                       self.btnRewardAd.isEnabled  = false
        }
        
        
        
        
        
    
    }//func
    
    
    
    
    func ensureDefaults(){
        if let lastDay = KeychainWrapper.standard.integer(forKey: keyDayLastPlay) {
            self.dayOfLastPlay = lastDay
        }
        
        if let trialsLeft = KeychainWrapper.standard.integer(forKey: keyTrailsLeft) {
            self.dailyTrialsLeft = trialsLeft
        }
        
        if let adExtras = KeychainWrapper.standard.integer(forKey: keyExtrasFromAds) {
            self.extraTrialsFromAds = adExtras
        }
        
        if let boughtExtras = KeychainWrapper.standard.integer(forKey: keyExtrasBought) {
            self.extraTrialsBought = boughtExtras
        }
        
        if let totalExtras = KeychainWrapper.standard.integer(forKey: keyExtrasTotal) {
            self.extraTrialsTotal = totalExtras    
        }
    }//Func
    
    func deductOneFromDaily(){
        self.dailyTrialsLeft -= 1
         KeychainWrapper.standard.set(self.dailyTrialsLeft, forKey: keyTrailsLeft)
        
        if self.dailyTrialsLeft == 1 {
                   self.lblGamesLeft.text = "\(self.dailyTrialsLeft)/3 today"
        } else {
                   self.lblGamesLeft.text = "\(self.dailyTrialsLeft)/3 today"
        }
        
    }//Func
    
    
    
    func deductOneFromExtrasTotal(){
        
       
        
        
        //deduct and store extraTotal
        self.extraTrialsTotal -= 1
        KeychainWrapper.standard.set(self.extraTrialsTotal, forKey: keyExtrasTotal)
                
       
        
        if self.extraTrialsTotal == 1 {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
        } else {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
        }
    }//Func
    
    
    func addOneOnExtrasTotal(){
           //deduct and store extraTotal
           self.extraTrialsTotal += 1
           KeychainWrapper.standard.set(self.extraTrialsTotal, forKey: keyExtrasTotal)
                   
           
           if self.extraTrialsTotal == 1 {
               self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
           } else {
               self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
           }
       }//Func
    
    
    
    
    
    
    
    
    
    
    func printMySituaton(){
         print("_____________________Report__________________________")
       
        let today = getDayOfTodayDate()
        print("today is the \(today) day")
        
        
        
       
        
        if let dailyTL = KeychainWrapper.standard.integer(forKey: keyTrailsLeft)  {
                   print("Our daily trials left are: \(dailyTL)")
               }
        
        
        if let extraTL = KeychainWrapper.standard.integer(forKey: keyExtrasBought)  {
            print("extras: \(extraTL)")
            print("nothing bought")
        }
        
        
        if let adExtraTL = KeychainWrapper.standard.integer(forKey: keyExtrasFromAds)  {
            print("Ad Mob extras: \(adExtraTL)")
        }
        
        
        print("TOTAL EXTRA = \(self.extraTrialsFromAds)")
        print("_____________________END of Report__________________________")
        
        
    }
    
   
    
    
    func getRandomQuote() -> String {
        let quotes = [quote1, quote2, quote3, quote4, quote5, quote6]
        let randomQuote = quotes.randomElement()!
        return randomQuote
    }//Func
    
    
    /*
    func showCompany() {
             let myProKiosk = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpProCounter") as! PKioskViewController
             self.addChild(myProKiosk)
             myProKiosk.view.frame = self.view.frame
             self.view.addSubview(myProKiosk.view)
             myProKiosk.didMove(toParent: self)
    }
    
    */
    
    
    
    
    
    func  playBtnPopSound(){
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "btnPop", ofType: "wav")!)

        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

        }catch {
            print("there was some error. The error was \(error)")
        }
        audioPlayer.play()
    }
    
    func playSound(file: String){
        
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "wav")!)

               do{
                   audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

               }catch {
                   print("there was some error. The error was \(error)")
               }
               audioPlayer.play()
        
    }
    
    func setLabelsAndButtonsForUnlimited(){
        self.lblGamesLeft.text = ""
        self.lblExtrasLeft.text = ""
        self.btnRewardAd.setTitle("", for: .normal)
        self.btnRewardAd.isEnabled  = false
    }
    
    
    
}//class




   
    
    
    /*
      //  for item in AppContent.main {
            
        if AppContent.main == boughtProduct!.productIdentifier {
                switch item.PurchaseType {
                    
                case .nonConsumable:
                    if ProductDelivery.isProductAvailable(identifier: myProductList.unlimited) {
                      
                        self.lblExtrasLeft.text = "yahdhfhfhf"
                    } else {
                         self.lblExtrasLeft.text = "Locked"
                    }
                    break
                    
                case .consumable:
                    self.lblExtrasLeft.text = "\(item.content) \(ProductDelivery.remainingUnits(identifier: <#T##String#>))"
                    break
               
                }//switch
            }//if
       // }//For
    }//Func
    
}//ext
*/




   //MARK: - Extensions


extension ViewController: RefreshViewDelegate {
    func updatePurchasedItemsInTheView() {
        let extraWasJustBought = ProductDelivery.isProductAvailable(identifier: myProductList.extraTrials)
        let unlimitedWasJustBought = ProductDelivery.isProductAvailable(identifier: myProductList.unlimited)
        if extraWasJustBought {
            
            KeychainWrapper.standard.set(10, forKey: keyExtrasBought)
            KeychainWrapper.standard.set(10, forKey: keyExtrasTotal)
           // KeychainWrapper.standard.synchronize()
           // dealWithExtras()
            
             DispatchQueue.main.async {
            self.lblExtrasLeft.text = "10 extra"
            }
            
        } else if unlimitedWasJustBought {
             DispatchQueue.main.async {
            self.lblExtrasLeft.text = ""
            self.lblGamesLeft.text = ""
            self.btnRewardAd.setTitle("", for: .normal)
            self.btnRewardAd.isEnabled  = false
            self.isPaidVersionOn = true
            }
        }
        print("DELEGATE Refreshhing RULES")
    }//func
    
    
    func dealWithExtras(){
        if let adExtras = KeychainWrapper.standard.integer(forKey: keyExtrasFromAds) {
                   self.extraTrialsFromAds = adExtras
               }
               
               if let boughtExtras = KeychainWrapper.standard.integer(forKey: keyExtrasBought) {
                   self.extraTrialsBought = boughtExtras
               }
               
               if let totalExtras = KeychainWrapper.standard.integer(forKey: keyExtrasTotal) {
                   self.extraTrialsTotal = totalExtras
               }
        
        
        KeychainWrapper.standard.set(self.extraTrialsBought + 10, forKey: keyExtrasBought)
        KeychainWrapper.standard.set(self.extraTrialsTotal + 10, forKey: keyExtrasTotal)
        //UserDefaults.standard.synchronize()
        
        self.extraTrialsTotal = (KeychainWrapper.standard.integer(forKey: keyExtrasTotal))!
    }//func
    
    
    
    
    
    
    
    
    
    
    
}//ext

/*


extension ViewController: ExtraTrialsDelegate {
    
    //this function is called from the boss(myKiosk) who has the protocol together with the parameters
    //I will tell you how many units to put. Ok ypallhle, legate?
    //The ypallhlos was hired with the [myKiosk.extrasDelegate = self] line in showKiosk Function
    
    func didSelectExtraTrials(units: Int) {
        if ProductDelivery.isProductAvailable(identifier: myProductList.extraTrials){
            
            
          
             if let adExtras = UserDefaults.standard.value(forKey: keyExtrasFromAds) as? Int{
                       self.extraTrialsFromAds = adExtras
                   }
                   
                   if let boughtExtras = UserDefaults.standard.value(forKey: keyExtrasBought) as? Int{
                       self.extraTrialsBought = boughtExtras
                   }
                   
                   if let totalExtras = UserDefaults.standard.value(forKey: keyExtrasTotal) as? Int{
                       self.extraTrialsTotal = totalExtras
                   }
            
            
            UserDefaults.standard.set(self.extraTrialsBought + units, forKey: keyExtrasBought)
            UserDefaults.standard.set(self.extraTrialsTotal + units, forKey: keyExtrasTotal)
            UserDefaults.standard.synchronize()
            
            self.extraTrialsTotal = (UserDefaults.standard.value(forKey: keyExtrasTotal) as? Int)!
            
            
            
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
        } else {
            self.lblExtrasLeft.text = "extra not loaded yet"
        }

    }
}//ext


extension ViewController: UnlimitedTrialsDelegate {
    func didSelectUnlimited(isUnlocked: Bool) {
         if ProductDelivery.isProductAvailable(identifier: myProductList.unlimited) {
            self.isPaidVersionOn = isUnlocked
            setLabelsAndButtonsForUnlimited()
         } else {
            self.lblExtrasLeft.text = "Unlimited locked"
        }
    }
   
}





 */
   
    
    
    /*
      //  for item in AppContent.main {
            
        if AppContent.main == boughtProduct!.productIdentifier {
                switch item.PurchaseType {
                    
                case .nonConsumable:
                    if ProductDelivery.isProductAvailable(identifier: myProductList.unlimited) {
                      
                        self.lblExtrasLeft.text = "yahdhfhfhf"
                    } else {
                         self.lblExtrasLeft.text = "Locked"
                    }
                    break
                    
                case .consumable:
                    self.lblExtrasLeft.text = "\(item.content) \(ProductDelivery.remainingUnits(identifier: <#T##String#>))"
                    break
               
                }//switch
            }//if
       // }//For
    }//Func
    
}//ext
*/



extension ViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("received add")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
       print(error)
    }
    
}




extension ViewController: GADRewardedAdDelegate{
    
    
    
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
      print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        self.adRewardingCoin += 1
        
        self.extraTrialsFromAds += 2
        KeychainWrapper.standard.set(self.extraTrialsFromAds, forKey: keyExtrasFromAds)
        
        self.extraTrialsTotal += 2
        KeychainWrapper.standard.set(self.extraTrialsTotal, forKey: keyExtrasTotal)
              
        if self.extraTrialsTotal == 1  {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
              } else {
            self.lblExtrasLeft.text = "\(self.extraTrialsTotal) extra"
              }
        
        
    }//Func
    
    
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad presented.")
    }

    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
      print("Rewarded ad failed to present.")
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad dismissed.")
    }
    
    
    
    
}//ext



/*


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
    
    
    
    
   func selectButtonOnePunk(){
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
        
    }
    
    
    
}//extention
*/
