//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Andrew Elliott on 4/1/22.
//

import UIKit

protocol EventTableViewCellDelegate: AnyObject {
    func attendingButtonTapped(sender: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    var delegate: EventTableViewCellDelegate?

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attendingButton: UIButton!
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let event = event else { return }
        
        titleLabel.text = event.title
        attendingButton.setImage(UIImage(systemName: event.attending ? "person.fill.checkmark" : "person.fill.xmark"), for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func attendingButtonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        
        delegate.attendingButtonTapped(sender: self)
    }
}
