//
//  ViewController.swift
//  Psychologist
//
//  Created by Ahmad Ayman on 2/26/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // This will work as if the destination is either wrapped in NC or just HappinessVC
        var destination = segue.destinationViewController as? UIViewController

        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        // Else the destination is just UIVC we can still check if it's HappinessVC
        if let hvc = destination as? HappinessViewController {
            let identifer = segue.identifier
            switch identifer {
                case "sad": hvc.happinees = 0
                case "happy": hvc.happinees = 100
                case "nothing": hvc.happinees = 25
                default: hvc.happinees = 50
             }
        }
    }
    
    
    // Even if we call te segue from code we can still perpare
    // Note that the sender will be passed to the prepare method
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: self)
        
    }
    
    
}



















