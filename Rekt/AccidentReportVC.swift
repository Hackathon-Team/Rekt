//
//  ViewController.swift
//  Rekt
//
//  Created by Abinesh Sarvepalli on 1/16/16.
//  Copyright © 2016 ARRA. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

class AccidentReportVC: UIViewController, MFMessageComposeViewControllerDelegate {
    
    let imgSelected:UIImage! = UIImage(named: "button-selected")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarController?.tabBar.hidden = false
        
//        var bckgdImg = UIImageView(
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "home-bkgd")
        imageView.center = self.view.center
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bttnPressed(sender: UIButton) {
        sender.setImage(imgSelected, forState: UIControlState.Highlighted)
    }
    
    @IBAction func emergencyCall(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://4085054471")!)
    }

    @IBAction func bttnSelected(sender: UIButton) {
        // send message
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "I have recently gotten into an accident. Do not worry, I am fine! My current location is http://maps.google.com/maps?q=37.3127111,-121.7757159"
            controller.recipients = ["4085054471", "4084393155"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }                
    }
    
    // Message Screen
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
    }
}

