//
//  Match+CoreDataProperties.swift
//  TicTacToe
//
//  Created by Matteo Marchesini on 19/09/17.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import Foundation
import CoreData


extension Match {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Match> {
        return NSFetchRequest<Match>(entityName: "Match")
    }

    @NSManaged public var date: String?
    @NSManaged public var playerO: String?
    @NSManaged public var playerX: String?
    @NSManaged public var scoreO: Int16
    @NSManaged public var scoreX: Int16

}
