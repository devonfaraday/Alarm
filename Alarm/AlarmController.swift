//
//  AlarmController.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    var alarms = [Alarm]()
    
    init() {
        self.alarms = mockData
    }
    
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(name: name, fireTimeFromMidnight: fireTimeFromMidnight)
        alarms.append(newAlarm)
        return newAlarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
    
    // MARK: - Properties
    
    var mockData: [Alarm] {
        let alarm1 = Alarm(name: "Get Up Faggot", fireTimeFromMidnight: 153.0)
        let alarm2 = Alarm(name: "Second Fake Alarm", fireTimeFromMidnight: 1341.0)
        
        return [alarm1, alarm2]
    }
    
}
