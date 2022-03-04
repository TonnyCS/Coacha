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
    @NSManaged public var duration: Int16
    @NSManaged public var date: Date
    
    var sportActivity: SportActivity {
        set {
            id = newValue.id
            name = newValue.name
            place = newValue.place
            duration = Int16(newValue.duration)
            date = newValue.date
        }
        get {
            SportActivity(id: self.id, name: self.name, place: self.place, duration: Int(self.duration), date: self.date, isLocal: true)
        }
    }

}

extension SportActivityCD : Identifiable {

}
