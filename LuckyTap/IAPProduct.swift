//
//  IAPProduct.swift
//  LuckyPunk
//
//  Created by Ioannis on 29/4/20.
//  Copyright © 2020 iappetos. All rights reserved.
//

//com.iappetos.LuckyPunk.ExtraTrials
//com.iappetos.LuckyPunk.Unlimited  1513340838

import Foundation
import StoreKit
import SwiftKeychainWrapper



struct myProductList {
    static let unlimited : String = "com.iappetos.LuckyPunk.Unlimited"
    static let extraTrials : String = "com.iappetos.LuckyPunk.ExtraTrials"
    static let arrayOfProducts = [unlimited, extraTrials]
    
}


struct ProductDelivery {

static func deliverProduct(product: String) {
    
switch product {
case myProductList.unlimited: deliverNonconsumable(identifier: myProductList.unlimited)
case myProductList.extraTrials: deliverConsumable(identifier: myProductList.extraTrials, units: 10)
      break
default: break
}
}//Func

  
    
    //This is where we configure for the paid version
static func deliverNonconsumable(identifier: String) {
       KeychainWrapper.standard.set(true, forKey: identifier)
       //UserDefaults.standard.synchronize()
    NSUbiquitousKeyValueStore.default.set(true, forKey: identifier)
    NSUbiquitousKeyValueStore.default.synchronize()
    
    
    }//func
    
    
        
static func isProductAvailable(identifier: String) -> Bool {
          if KeychainWrapper.standard.bool(forKey: identifier) == true {
            return true
          } else {
            return false
          }
        }//func
        
    
  
    static func deliverConsumable(identifier: String, units: Int) {
      //  let currentUnits: Int = UserDefaults.standard.integer(forKey: identifier)
       
        KeychainWrapper.standard.set(/*currentUnits + */units, forKey: identifier)
        //KeychainWrapper.standard.synchronize()
        NSUbiquitousKeyValueStore.default.set(units, forKey: identifier)
        NSUbiquitousKeyValueStore.default.synchronize()

}//func
    
    
    
    static func remainingUnits(identifier: String) -> Int {
        return KeychainWrapper.standard.integer(forKey: identifier)!
    }//Func
    
 
    static func updateFromiCloud() {
        let latestExtraTrials = NSUbiquitousKeyValueStore.default.double(forKey: myProductList.extraTrials)
        let latestUnlimited = NSUbiquitousKeyValueStore.default.bool(forKey: myProductList.unlimited)
        
         KeychainWrapper.standard.set(latestExtraTrials, forKey: myProductList.extraTrials)
         KeychainWrapper.standard.set(latestUnlimited, forKey: myProductList.unlimited)
    }
    
    
}//Struct
    
    

