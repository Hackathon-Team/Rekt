//
//  AddPeopleTVC.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/17/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import UIKit
import Foundation

class NewAccidentVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PersonInformationDelegate, AccidentSaveDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var drivers = [Driver]()
    var witnesses = [Witness]()
    var images = [UIImage]()
    var acc = Accident()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = false
        self.tableView.tableFooterView = UIView()
        
        acc.dateOfAccident = NSDate()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    // MARK: tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        switch(section) {
        case 0:
            return drivers.count
        case 1:
            return witnesses.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Driver"
        case 1:
            return "Witnesses"
        default:
            return ""
        }
    }
    
    // cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        // Configure the cell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        switch(indexPath.section) {
        case 0:
            if (drivers.count > 0) {
                cell.textLabel!.text = "\((drivers[indexPath.row].name)!)"
            }
        case 1:
            if witnesses.count > 0 {
                cell.textLabel!.text = "\((witnesses[indexPath.row].name)!)"
            }
        default: break
        }
        
        return cell
    }
    
    //Delete a cell...
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if indexPath.section == 1 {
                witnesses.removeAtIndex(indexPath.row)
            } else {
                drivers.removeAtIndex(indexPath.row)
                print("\(drivers.count)")
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPersonInfo" {
            let dest:PersonInfoVC = segue.destinationViewController as! PersonInfoVC
            dest.delegate = self
        }
        if segue.identifier == "editPersonInfo" {
            let dest:PersonInfoVC = segue.destinationViewController as! PersonInfoVC
            dest.delegate = self
            
            if let _ = self.tableView.indexPathForSelectedRow {
                dest.indexPath = self.tableView.indexPathForSelectedRow
                switch(self.tableView.indexPathForSelectedRow!.section) {
                case 0: //driver
                    dest.currDriver = drivers[self.tableView.indexPathForSelectedRow!.row]
                case 1: //witness
                    dest.currWitness = witnesses[self.tableView.indexPathForSelectedRow!.row]
                default: break
                }
            }
        }
        if segue.identifier == "showDocumentAccidentVC" {
            let dest:DocumentAccidentVC = segue.destinationViewController as! DocumentAccidentVC
            
            dest.images = self.images
            dest.delegate = self
        }
    }
    
    
    // MARK: PersonInformationDelegate
    func saveDriver(driver: Driver) {
        self.drivers.append(driver)
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }
    func saveWitness(witness: Witness) {
        witnesses.append(witness)
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }
    func deletePerson(indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            drivers.removeAtIndex(indexPath.row)
        case 1:
            witnesses.removeAtIndex(indexPath.row)
        default: break
        }
        self.tableView.reloadData()
    }
    
    // MARK: SaveAccidentDelegate
    func saveAccident() {
        print("method called")
        acc.drivers = drivers
        acc.witnesses = witnesses
        acc.images = images
        
        let defaults = NSUserDefaults.standardUserDefaults()
        for var i = 0.0; i < Double.infinity; i++ {
            if defaults.objectForKey("acc\(i)") == nil {
                defaults.setValue(acc, forKeyPath: "acc\(i)")
            }
        }
        
        let alert = UIAlertController(title: "Accident Saved", message: "You may view all accidents in the history tab.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
