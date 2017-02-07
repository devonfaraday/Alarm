//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(_ cell: SwitchTableViewCell, selected: Bool)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
   
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBAction func switchValueChange(_ sender: UISwitch) {
        delegate?.switchCellSwitchValueChanged(self, selected: sender.isOn)
    }
    
    
    // MARK: - Properties
    
    // Possible errors
    var alarm: Alarm? {
        didSet {
            timeLabel.text = alarm?.fireTimeAsString
            nameLabel.text = alarm?.name
            guard let enable = alarm?.enable else { return }
            alarmSwitch.isOn = enable
        }
    }
}




