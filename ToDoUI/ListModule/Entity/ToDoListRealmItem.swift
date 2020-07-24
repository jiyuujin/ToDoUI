//
//  ToDoListRealmItem.swift
//  ToDoUI
//
//  Created by jiyuujin on 2020/07/22.
//  Copyright © 2020 io.kyoto.nekohack. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoListRealmItem: Object {

    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var createdAt : Date = NSDate() as Date
    @objc dynamic var updatedAt : Date = NSDate() as Date

}
