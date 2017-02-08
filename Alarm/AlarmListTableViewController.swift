//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return SwitchTableViewCell() }
       
    

        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        
        
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
            let cellIndexPath = tableView.indexPath(for: cell) else {  return  }
        if alarm.enable {
        tableView.beginUpdates()
        scheduleUserNotifications(for: alarm)
        alarm.enable = selected
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)
        } else {
            tableView.beginUpdates()
            cancelUserNotifications(for: alarm)
            alarm.enable = selected
            tableView.reloadRows(at: [cellIndexPath], with: .automatic)
        }
        
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
        guard let indexRow = tableView.indexPathForSelectedRow,
            let destinationController = segue.destination as? AlarmDetailTableViewController else { return }
        
        
            destinationController.alarm = AlarmController.shared.alarms[indexRow.row]
            
        }
        
    }
    
    
}


/*
 .
 
 

 Go to your AlarmListTableViewController. In your switchCellSwitchValueChanged function, you will need to schedule a notification if the switch is being turned on, and cancel the notification if the switch is being turned off. You will also need to cancel the notification when you delete an alarm.
 Go to your AlarmDetailTableViewController. Your enableButtonTapped action will need to either schedule or cancel a notification depending on its state, and will also need to call your AlarmController.shared.toggleEnabled(for alarm: Alarm) function if it isn't being called already. Your saveButtonTapped action will need to schedule a notification when saving a brand new alarm, and will need to cancel and re-save a notification when saving existing alarms (this is because the user may have changed the time for the alarm).
 
 */


