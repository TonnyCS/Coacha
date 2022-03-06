//
//  SportActivityCD+CoreDataProperties.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//
//

import Foundation
import CoreData


extension SportActivityCD {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SportActivityCD> {
        return NSFetchRequest<SportActivityCD>(entityName: "SportActivityCD")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var place: String
    @NSManaged public var durationHours: Int16
    @NSManaged public var durationMinutes: Int16
    @NSManaged public var date: Date
    
    var sportActivity: SportActivity {
        set {
            id = newValue.id
            name = newValue.name
            place = newValue.place
            durationHours = Int16(newValue.duration.hours)
            durationMinutes = Int16(newValue.duration.minutes)
            date = newValue.date
        }
        get {
            LocalSportActivity(
                id: self.id,
                name: self.name,
                place: self.place,
                duration: DateDuration(hours: Int(self.durationHours), minutes: Int(self.durationMinutes)),
                date: self.date
            )
        }
    }

}

extension SportActivityCD : Identifiable {

}
