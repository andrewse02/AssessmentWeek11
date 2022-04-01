//
//  EventListTableViewController.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        cell.event = EventController.shared.events[indexPath.row]
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(eventToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let destination = segue.destination as? EventDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destination.event = EventController.shared.events[indexPath.row]
    }
}

extension EventListTableViewController: EventTableViewCellDelegate {
    func attendingButtonTapped(sender: EventTableViewCell) {
        guard let event = sender.event else { return }
        
        EventController.shared.toggleAttendingEvent(event)
        sender.updateViews()
    }
}
