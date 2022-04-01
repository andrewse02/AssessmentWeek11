//
//  EventDetailViewController.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import UIKit

class EventDetailViewController: UIViewController {

    // MARK: - Properties
    
    var event: Event?
    var date: Date?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let titleText = titleTextField.text,
              !titleText.isEmpty else { return }
        
        if let event = event {
            EventController.shared.updateEvent(event, title: event.title ?? "", date: date ?? datePicker.date, attending: event.attending)
        } else {
            EventController.shared.createEvent(title: titleText, date: date ?? datePicker.date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let event = event else { return }
        
        titleTextField.text = event.title
        datePicker.date = event.date!
        date = event.date!
    }
}
