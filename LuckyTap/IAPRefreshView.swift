//
//  IAPRefreshView.swift
//  LuckyPunk
//
//  Created by Ioannis on 12/6/20.
//  Copyright © 2020 iappetos. All rights reserved.
//

import Foundation
import StoreKit

enum ProductType {
    case nonconsumable
    case consumable
}


struct ContentItem {
    var identifier: String
    var purchaseType: ProductType
    var content: String
}


struct AppContent {
    static let main = {
        ContentItem(identifier: "com.iappetos.LuckyPunk.Unlimited", purchaseType: .nonconsumable, content: "youBought Unlimited")
        ContentItem(identifier: "com.iappetos.LuckyPunk.ExtraTrials", purchaseType: .consumable, content: "10 extras bought")
        
    }
}
