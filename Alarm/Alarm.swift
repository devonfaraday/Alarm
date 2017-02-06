//
//  Alarm.swift
//  Alarm
//
//  Created by Christian McMullin on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
    private let fireTimeFromMidnightKey = "fireTime"
    private let uuidKey = "UUID"
    private let nameKey = "name"
    private let enabledKey = "enabled"
    
    var name: String
    var fireTimeFromMidnight: TimeInterval
    var enable: Bool
    let uuid: String
    
    init(name: String, fireTimeFromMidnight: TimeInterval, enable: Bool = true, uuid: String = UUID().uuidString) {
        self.name = name
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.enable = enable
        self.uuid = uuid
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
            let uuid = aDecoder.decodeObject(forKey: uuidKey) as? String else { return nil }
        
        self.name = name
        self.uuid = uuid
        self.fireTimeFromMidnight = aDecoder.decodeDouble(forKey: fireTimeFromMidnightKey)
        self.enable = aDecoder.decodeBool(forKey: enabledKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(uuid, forKey: uuidKey)
        aCoder.encode(fireTimeFromMidnight, forKey: fireTimeFromMidnightKey)
        aCoder.encode(enable, forKey: enabledKey)
        }
    
    
    
    var fireDate: Date? {
        //setting midnight
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return nil}
        //
        let fireDateFromThisMorning = Date(timeInterval: fireTimeFromMidnight, since: thisMorningAtMidnight as Date)
        return fireDateFromThisMorning
        
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
}

// MARK: - Equatable
func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}


