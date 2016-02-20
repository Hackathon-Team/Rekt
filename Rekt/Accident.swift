//
//  Accident.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/19/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Accident {
    var drivers: [Driver]?
    var witnesses: [Witness]?
    var dateOfAccident: NSDate?
    var images: [UIImage]?
    
    init() {
        
    }
}
