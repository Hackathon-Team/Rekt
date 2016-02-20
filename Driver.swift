//
//  Driver.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/19/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import Foundation

class Driver {
    // Insert code here to add functionality to your managed object subclass
    var name: String?
    var phoneNum: Int?
    var license: String?
    var insurance: String?
    
    init(name: String, phoneNum: Int, license: String, insurance: String) {
        self.name = name
        self.phoneNum = phoneNum
        self.license = license
        self.insurance = insurance
    }
}
