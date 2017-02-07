//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    var alarm: Alarm?
    
    @IBOutlet weak var timePickerView: UIDatePicker!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var disableButton: UIButton!

    @IBAction func enabledButtonTapped(_ sender: Any) {
        if disableButton.backgroundColor == .red {
            disableButton.setTitle("Enabled", for: .normal)
            disableButton.backgroundColor = .green
            
            
        } else  {
            disableButton.setTitle("Disabled", for: .normal)
            disableButton.backgroundColor = .red
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = nameLabel.text,
           let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = timePickerView.date.timeIntervalSince(thisMorningAtMidnight as Date)

        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
        }
        
        let _ = navigationController?.popViewController(animated: true)
    
    }
    
    private func updateViews() {
        guard let alarm = alarm,
        let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        timePickerView.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        nameLabel.text = alarm.name
        
        if alarm.enable {
            disableButton.setTitle("Enabled", for: UIControlState())
            disableButton.backgroundColor = .green
            
            
        } else {
            disableButton.setTitle("Disable", for: UIControlState())
            disableButton.backgroundColor = .red
            
        }
        self.title = alarm.name
    }

}

