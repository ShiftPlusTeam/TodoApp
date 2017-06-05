//
//  Todo+CoreDataProperties.swift
//  TodoApp
//
//  Created by Sasakura Hirofumi on 2017/06/05.
//  Copyright © 2017 Sasakura Hirofumi. All rights reserved.
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var todo: String?

}
