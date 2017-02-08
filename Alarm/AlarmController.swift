//
//  AlarmController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController {
    
    init() {
        loadFromPersistentStorage()
    }
    
    static let shared = AlarmController()
    var alarms = [Alarm]()
    
    static private var persistencesAlarmFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appending("Alarms.plist")
    }
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(name: name, fireTimeFromMidnight: fireTimeFromMidnight)
        alarms.append(newAlarm)
        saveToPersistentStorage()
        return newAlarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        guard let persistencePath = AlarmController.persistencesAlarmFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: persistencePath)
        
    }
    
    func loadFromPersistentStorage() {
        guard let persistencePath = AlarmController.persistencesAlarmFilePath else { return }
        if let alarm = NSKeyedUnarchiver.unarchiveObject(withFile: persistencePath) {
            self.alarms = alarm as! [Alarm]
        }
    }
    
    func toggleEnabled(alarm: Alarm) {
        if alarm.enable {
            alarm.enable = false
        } else {
            alarm.enable = true
        }
    }
    
}

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        let sound = UNNotificationSound.default()
        notificationContent.title = "Wake up"
        notificationContent.body = "You freaking awesome rad stud muffin"
        notificationContent.sound = sound
        
        guard let fireDate = alarm.fireDate else { return }
        let dateComponets = Calendar.current.dateComponents([.hour, .minute], from: fireDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print("it didn't work you scumbag")
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}



















