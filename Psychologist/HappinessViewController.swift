//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Ahmad Ayman on 2/23/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: FaceView! {
        // perfect time when the connection set (this property set) to set the datasource pointer to seld [ just after] 
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            //faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))  // As we gonna modify the model
        }
        
    }

    // Out model
    var happinees: Int = 75 { // 0 = very sad, 100 = ecstatic
        didSet {
            // didSet? -> Change the value of happiness then
            happinees = min(max(happinees, 0), 100)  // Validate the range of happiness
            println("Happiness = \(happinees)")
            // happiness changed? model updates? -> Then update the UI
            updateUI()
        }
    }

    func updateUI () {
        // Each tim the model change then ask the faceView to redraw itself
        faceView?.setNeedsDisplay()
        title = "\(happinees)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return  Double(happinees-50)/50
    }
    
    private struct Constances {
        static let HappinessGestureScale: CGFloat = 4   // as translation in CGFloat also
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)   // Tell me the trslation in te face view corrdinate system .. how much it moved
            let happinessChange = -Int(translation.y / Constances.HappinessGestureScale)
            if happinessChange != 0 {
                happinees += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)       // Reseting
            }
        default:    // .Cancled or .Faild or .Began -> Do nothing
            break
        }
    }
    
    
    

}
