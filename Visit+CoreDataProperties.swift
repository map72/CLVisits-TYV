//
//  Visit+CoreDataProperties.swift
//  CLVisit POC
//
//  Created by Misty Periard on 12/16/15.
//  Copyright © 2015 Martyn Loughran. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Visit {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var arrival: NSDate?
    @NSManaged var departure: NSDate?

}
