//
//  Engine+CoreDataProperties.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Sergey Nevzorov on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Engine {

    @NSManaged var gas: String?
    @NSManaged var ship: Ship?

}
