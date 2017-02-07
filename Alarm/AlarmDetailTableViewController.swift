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
            disableButton.setTitle("Disable", for: UIControlState())
            disableButton.backgroundColor = .red
            
        } else {
            disableButton.setTitle("Enable", for: UIControlState())
            disableButton.backgroundColor = .green
            
        }
        self.title = alarm.name
    }

}

/*
 Fill in the `saveButtonTapped` function on the detail view so that you can add new alarms and edit existing alarms.
 
 1. Use `DateHelper.thisMorningAtMidnight` to find the time interval between this morning at midnight and the `datePicker.date`.
 2. Unwrap `self.alarm` and if there is an alarm, call your `AlarmController.sharedInstance.updateAlarm` function and pass it the time interval you just created and the title from the title text field.
 3. If there is no alarm, call your `AlarmController.sharedInstance.addAlarm` function to create and add a new alarm.
 * note: You should be able to run the project and have what appears to be a fully functional app. You should be able to add, edit, and delete alarms, and enable/disable alarms. We have not yet covered how to alert the user when time is up, so that part will not work yet, but we'll get there.
 */
