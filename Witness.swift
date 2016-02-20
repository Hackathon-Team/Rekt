//
//  Witness.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/19/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import Foundation
import CoreData


class Witness {
    var name: String?
    var phoneNum: Int?
    var email: String?
    var notes: String?
    
    init(name: String, phoneNum: Int, email: String, notes: String) {
        self.name = name
        self.phoneNum = phoneNum
        self.email = email
        self.notes = notes
    }
}
