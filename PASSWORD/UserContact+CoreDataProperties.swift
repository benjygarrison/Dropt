//
//  UserContact+CoreDataProperties.swift
//  
//
//  Created by Benjamin Garrison on 9/9/19.
//
//

import Foundation
import CoreData


extension UserContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContact> {
        return NSFetchRequest<UserContact>(entityName: "UserContact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?

}
