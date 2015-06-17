//
//  HistoyViewController.swift
//  Psychologist
//
//  Created by Ahmad Ayman on 2/28/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class HistoyViewController: UIViewController {

    
    /* text: String -> Can be either "" at the first time or "Something" if we set the text property while segue preparing */
    @IBOutlet weak var historyTextView: UITextView!  { didSet { historyTextView.text = text } }
    
    var text: String = "" { didSet { historyTextView?.text = text } }    // historyTextView? not aviable while prepering so avoid error just change the text value and when the outlet connection will set then it'll use it's own didSet method .. the one here for the updates while connection is set 
    
    
    override var preferredContentSize: CGSize {
        get {
            if historyTextView != nil && presentingViewController != nil {       // if set and currently presenting
                return historyTextView.sizeThatFits (presentingViewController!.view.bounds.size)
            }   else{
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
    
    
    
    
    
    
    
    
}
