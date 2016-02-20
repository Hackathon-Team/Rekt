//
//  PersonInfoVC.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/18/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import UIKit

protocol PersonInformationDelegate {
    func saveDriver(driver: Driver)
    func saveWitness(witness: Witness)
    func deletePerson(indexPath: NSIndexPath)
}

class PersonInfoVC: UIViewController {
    
    @IBOutlet weak var segmentPersonType: UISegmentedControl!
    @IBOutlet weak var lblLicense: UILabel!
    @IBOutlet weak var lblInsurance: UILabel!
    
    var delegate:PersonInformationDelegate? = nil
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtLicense: UITextField!
    @IBOutlet weak var txtInsurance: UITextField!
    
    var currDriver:Driver? = nil
    var currWitness:Witness? = nil
    var indexPath:NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        self.navigationItem.hidesBackButton = true;
        
        //Set textbox values...
        if currDriver != nil {
            self.txtName.text? = "\(currDriver!.name)"
            self.txtPhoneNum.text? = "\(currDriver!.phoneNum)"
            self.txtLicense.text? = "\(currDriver!.license)"
            self.txtInsurance.text? = "\(currDriver!.insurance)"
        }
        if currWitness != nil {
            self.txtName.text? = "\(currWitness!.name)"
            self.txtPhoneNum.text? = "\(currWitness!.phoneNum)"
            self.txtLicense.text? = "\(currWitness!.email)"
            self.txtInsurance.text? = "\(currWitness!.notes)"
        }
    }
    
    
    @IBAction func changeType(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==1 {
            lblLicense.text? = "Email Address"
            lblInsurance.text? = "Notes"
        } else {
            lblLicense.text? = "Driver's License"
            lblInsurance.text? = "Insurance Number"
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func deletePerson(sender: UIButton) {
        delegate?.deletePerson(indexPath!)
        
        currWitness = nil
        currDriver = nil
        indexPath = nil
    }
    
    @IBAction func savePerson(sender: UIButton) {
        if segmentPersonType.selectedSegmentIndex == 0 {
            let driver = Driver(name: txtName.text!, phoneNum: Int(txtPhoneNum.text!)!, license: lblLicense.text!, insurance: lblInsurance.text!)
            if (delegate != nil) {
                delegate!.saveDriver(driver)
            }
        } else {
            let witness = Witness(name: txtName.text!, phoneNum: Int(txtPhoneNum.text!)!, email: lblLicense.text!, notes: lblInsurance.text!)
            if (delegate != nil) {
                delegate!.saveWitness(witness)
            }
        }
        
        //Reset parameters
        currWitness = nil
        currDriver = nil
        indexPath = nil
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}