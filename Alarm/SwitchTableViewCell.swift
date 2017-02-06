//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
   
    
    @IBAction func switchValueChange(_ sender: Any) {
    }
    
    
    // MARK: - Properties
    
    // Possible errors
    var alarm: Alarm? {
        didSet {
            timeLabel.text = String(describing: alarm?.fireTimeFromMidnight)
            nameLabel.text = alarm?.name
            guard let enable = alarm?.enable else { return }
            alarmSwitch.isOn = enable
        }
    }
}
