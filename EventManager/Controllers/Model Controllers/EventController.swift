//
//  EventController.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import Foundation
import CoreData
import UserNotifications

class EventController {
    
    // MARK: - Properties
    
    static let shared = EventController()
    var events: [Event] {
        lazy var fetchRequest: NSFetchRequest<Event> = {
            let request = NSFetchRequest<Event>(entityName: "Event")
            request.predicate = NSPredicate(value: true)
            return request
        }()
        
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // MARK: - CRUD Functions
    
    func createEvent(title: String, date: Date, attending: Bool = true) {
        let newEvent = Event(title: title, date: date, attending: attending)
        if attending { scheduleUserNotifications(for: newEvent) }
        
        CoreDataStack.saveContext()
    }
    
    func updateEvent(_ event: Event, title: String, date: Date, attending: Bool) {
        event.title = title
        event.date = date
        event.attending = attending
        
        cancelUserNotifications(for: event)
        if attending { scheduleUserNotifications(for: event) }
        
        CoreDataStack.saveContext()
    }
    
    func toggleAttendingEvent(_ event: Event) {
        event.attending.toggle()
        
        if event.attending {
            scheduleUserNotifications(for: event)
        } else {
            cancelUserNotifications(for: event)
        }
        
        CoreDataStack.saveContext()
    }
    
    func deleteEvent(_ event: Event) {
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
        
        cancelUserNotifications(for: event)
    }
}

extension EventController: EventScheduler {}
