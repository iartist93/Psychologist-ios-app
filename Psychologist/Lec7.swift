//
//  Lec7.swift
//  Psychologist
//
//  Created by Ahmad Ayman on 2/26/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation

// Questions + Answer => Diagnostics

//========= For the question
// Stretch the size to fill the whole width and then reset the constrains
// Delete the buttom one
// This text is larg and won't b resize as it is fixed font size
// so in inspector AutoShrink -> minmun font size you want to resize to


//========= For the button
// Reset constrints
// But i don't need vertical constrainsts so remove them
// Align -> Horizontal center in the container


//========= Multiple MCVs
// Now we have out main MVC
// Copy the anther MCV Files into here
// Also copy the UIViewController itslef to out new storyboard
// Drag a new SVC and set the master and detail views


//========== Fix the problem of iphones with that

// Go to the master view
// Editor -> Embed in -> NC
// Segue from each button to the detail "Show detail" and give them names

//========= Prepare for segue
// From the master


//=========
// hvc.happiness = 100 [ Error ]
// Okay lets see what we're doing 
    // 1- Change the value of happiness
    // 2- happniess is computed variable
    // 3- it call updateUI() when didSet()
    // 4- faceView.setNeedDisplay()
    // 5- but faceView haven't set yet .. remember perpareForSegue() doesn't set the outlet yet

// Okay what is the soluation?
    // faceView.setNeedDisplay()
    // We don't want to execute this line
    // as we just want to change the value of happinesss
    // and when the view is the outlet is setup
    // then it will find that the happiness inital value is the one that we've set
    // then we just need to updateUI() while we're in

    // faceView?.setNeedDisplay()
    // nil?
    // Then the whole line will be nil


//===============
// The detail view doesn't have a title?
    // Embed in NC
    // in updateUI()
        // title = "\(happiness)"

    // but nothing can will update
    // as the current distination is NC not the detail view


//============= Fire up segue from code
// Add the button action to the code
// Add the segue from the [ VC not from the button itself ] to the NC not the detail view
// give it an identifier


//============ PPC
// History is an array of ints
// Bar button in the navigation item
// Popover is a new MCV
    // Create a new VC
    // HistoyViewController: UIViewController

// Reset constraint from the "PIN"
// not editable

// As history tab button is in the HappinessViewController so we can mange it's segue preparing from HappinessViewController
// But as Happiness view controller is generic one and come from anther MVC .. it's not Diagnositic Happiness VC !!!!
// So we have to create inherited one and add our additional code to it and leave the orginal class clean

// Change the scene class from HappinessVC to DHVC
// As we inherite all the capability of happniess view controller
// all outlets and properties and methods will be aviable for us
// the outlets will still connectd to the super one

// REMEMBER: All segues ALAWYS create a new MVC
// So DianosticHappinessView controller [ detail vc ] will be inilaized again when we come
// from the [ master ] so it wont' rember the diagnosticHistory values

// So we use presistance
    // Presisance need computed properties to be stored not stored properties




































