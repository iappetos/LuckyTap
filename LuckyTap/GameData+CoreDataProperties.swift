//
//  GameData+CoreDataProperties.swift
//  
//
//  Created by Ioannis on 30/4/20.
//
//

import Foundation
import CoreData


extension GameData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameData> {
        return NSFetchRequest<GameData>(entityName: "GameData")
    }

    @NSManaged public var lastLDatePlayed: Date?
    @NSManaged public var extraTrials: Int16
    @NSManaged public var isUnlimitedOn: Bool
    @NSManaged public var daysTrialsLeft: Int16

}
