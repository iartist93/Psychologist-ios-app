//
//  DignosedHappinessViewController.swift
//  Psychologist
//
//  Created by Ahmad Ayman on 2/28/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation
import UIKit    // <-- Swift class .. UI class

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    // If someone set the happniess value then add it the the arrray
    override var happinees: Int {
        didSet {
            diagnosticHistory += [happinees]
            println("\(happinees)")
            println("\(diagnosticHistory)")
        }
    }

    private let defaults = NSUserDefaults.standardUserDefaults()
   
    // Have to be computed property to be stored
    var diagnosticHistory: [Int] {
        get { return defaults.objectForKey(History.DefaultKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: History.DefaultKey) }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultKey = "DiagnostedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        switch identifier {
        case History.SegueIdentifier:
            if let dvc = segue.destinationViewController as? HistoyViewController {
                if let ppc = dvc.popoverPresentationController {
                    ppc.delegate = self
                }
                dvc.text = "\(diagnosticHistory)"   // String represention of the array
            }
        default: break
        }
    }
    
    func adaptivePresentationStyleForPresentationController (controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None   // Don't addapt to to the current device
    }
    
    
    
    
    
    
}

