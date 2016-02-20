//
//  DocumentAccidentVC.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/18/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import UIKit
import CoreData

protocol AccidentSaveDelegate {
    func saveAccident()
}

//MARK: Document Accident View Controller
class DocumentAccidentVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var imagePicker:UIImagePickerController!
    @IBOutlet weak var tableView: UITableView!

//    // MARK: Variables Initialized by Delegate
    var delegate: AccidentSaveDelegate?
    var images: [UIImage]! //Chosen by delegate
    
    
    //MARK: View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
    
    
    //MARK: TableView Setup
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (images != nil) {
            return self.images!.count
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell")!
        if images?.count > 0 {
            cell.imageView?.image = images![indexPath.row]
            cell.textLabel?.text = "Picture \(indexPath.row + 1)"
        }
        return cell
    }
    
    //Delete a cell...
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            images!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //MARK: Camera
    @IBAction func addPicture(sender: UIBarButtonItem) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
//        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .FullScreen
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        images!.append(newImage)
        self.tableView.reloadData()
    }
    
    
    @IBAction func saveAccident(sender: UIButton) {
        let alert = UIAlertController(title: "Are You Sure", message: "It is important to review all information, before selecting save.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Review Information", style: .Default, handler: nil))
        let seed = UIAlertAction(title: "Save", style: .Default) {
            UIAlertAction in
            // save accident
            self.delegate?.saveAccident()
        }
        alert.addAction(seed)
        presentViewController(alert, animated: true, completion: nil)
    }
}
