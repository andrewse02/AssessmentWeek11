//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import Foundation
import CoreData

extension Event {
    convenience init(title: String, date: Date, attending: Bool = true, uuidString: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.title = title
        self.date = date
        self.attending = attending
        self.uuidString = uuidString
    }
}
