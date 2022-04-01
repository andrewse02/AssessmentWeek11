//
//  EventScheduler.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import UserNotifications

protocol EventScheduler {
    func scheduleUserNotifications(for event: Event)
    func cancelUserNotifications(for event: Event)
}

extension EventScheduler {
    func scheduleUserNotifications(for event: Event) {
        let content = UNMutableNotificationContent()
        content.title = "Event"
        content.body = event.title ?? ""
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: event.date ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: event.uuidString ?? UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationRequest)
    }
    
    func cancelUserNotifications(for event: Event) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.uuidString!])
    }
}
