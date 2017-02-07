//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return SwitchTableViewCell() }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        
        cell.nameLabel.text = alarm.name
        cell.timeLabel.text = String(alarm.fireTimeAsString)
        cell.alarmSwitch.isOn = alarm.enable
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func switchCellSwitchValueChanged(_ cell: SwitchTableViewCell, selected: Bool) {
        guard let alarm = cell.alarm,
            let cellIndexPath = tableView.indexPath(for: cell) else { return }
        tableView.beginUpdates()
        alarm.enable = selected
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexRow = tableView.indexPathForSelectedRow,
            let destinationController = segue.destination as? AlarmDetailTableViewController else { return }
            let alarm = AlarmController.shared.alarms[indexRow.row] 
        
        if segue.identifier == "showDetail" {
            destinationController.alarm = alarm
        }
        
    }
    
    
}
