//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews()
            } else {
                loadView()
                updateViews()
            }
            
        }
    }
    
    @IBOutlet weak var timePickerView: UIDatePicker!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var disableButton: UIButton!

    @IBAction func enabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            if !alarm.enable {
            alarm.enable = true
            disableButton.setTitle("Enabled", for: .normal)
            disableButton.backgroundColor = .green
                scheduleUserNotifications(for: alarm)
        } else  {
            alarm.enable = false
            disableButton.setTitle("Disabled", for: .normal)
            disableButton.backgroundColor = .red
                cancelUserNotifications(for: alarm)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = nameLabel.text,
           let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = timePickerView.date.timeIntervalSince(thisMorningAtMidnight as Date)

        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelUserNotifications(for: alarm)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleUserNotifications(for: alarm)
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

