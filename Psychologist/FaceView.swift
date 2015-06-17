//
//  FaceView.swift
//  Happiness
//
//  Created by Ahmad Ayman on 2/23/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: FaceView) -> Double? // I myself who reuest those data -> so the controller can know who asking for those data
}

//@IBDesignable
class FaceView: UIView {
    
    
    // Changed? redraw yourself
    @IBInspectable
    var lineWidth: CGFloat = 3  { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var fillColor: UIColor = UIColor.blueColor()    { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var strockColor: UIColor = UIColor.blueColor()  { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var scale: CGFloat = 0.90   { didSet { setNeedsDisplay() } }
    
    weak var dataSource: FaceViewDataSource?
    
    // Computed protperties
    var faceCenter: CGPoint {
        // get{} only? return directly
        return convertPoint(center, fromView: superview)    // center -> superView property not mine
    }
    
    var faceReduis: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale    // 90% of the selected reduis
    }
    
    // Some constants]
    
    struct Scaling {
        static let FaceReduisToEyeReduisRatio: CGFloat = 10
        static let FaceReduisToEyeOffsetRatio: CGFloat = 3
        static let FaceReduisToEyeSeperationRatio: CGFloat = 1.5
        
        static let FaceReduisToMouthWidthRatio: CGFloat = 1
        static let FaceReduisToMouthHeightRatio: CGFloat = 3
        static let FaceReduisToMouthOffsetRatio: CGFloat = 3
        
        static let FaceReduisToGlassesWidthRatio: CGFloat = 2.5
        static let FaceReduisToGlassesHeightRatio: CGFloat = 4
        static let FaceReduisToGlassesOffsetRatio: CGFloat = 3
        static let FaceReduisToGlassesSeperationRatio: CGFloat = 1.5
    }
    
    
    private enum Eye { case Left, Right }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeReduis = faceReduis / Scaling.FaceReduisToEyeReduisRatio
        let eyeVerticalOffset = faceReduis / Scaling.FaceReduisToEyeOffsetRatio
        let eyeHorizontalSperation = faceReduis / Scaling.FaceReduisToEyeSeperationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
 
        
        switch whichEye {
            case .Left: eyeCenter.x -= eyeHorizontalSperation / 2
            case .Right: eyeCenter.x += eyeHorizontalSperation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeReduis, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func bezierPathForSmile(frictionOfMaxSmile: Double) -> UIBezierPath {
        
        let mouthWidth = faceReduis / Scaling.FaceReduisToMouthWidthRatio
        let mouthHeight = faceReduis / Scaling.FaceReduisToMouthHeightRatio
        let mouthVerticalOffset = faceReduis / Scaling.FaceReduisToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(frictionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth/2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: faceCenter.x + mouthWidth/2, y: faceCenter.y + mouthVerticalOffset)
        
        let cp1 = CGPoint(x: start.x + mouthWidth/3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth/3, y: end.y + smileHeight)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    enum Glass { case Left, Right }
    
    private func bezierPathForGlasses(whichGlass: Glass) -> UIBezierPath {
        let glassWidth = faceReduis / Scaling.FaceReduisToGlassesWidthRatio
        let glassHeight = faceReduis / Scaling.FaceReduisToGlassesHeightRatio
        let glassVerticalOffset = faceReduis / Scaling.FaceReduisToGlassesOffsetRatio
        let glassHorizontalSperation = faceReduis / Scaling.FaceReduisToGlassesSeperationRatio
        
        var glassCenter = faceCenter
        glassCenter.y -= glassVerticalOffset + glassHeight / 2
        
        
        switch whichGlass {
            case .Left: glassCenter.x -= glassHorizontalSperation / 2 + glassWidth / 2
            case .Right: glassCenter.x += glassHorizontalSperation / 2 - glassWidth / 2
        }
        
        let glass = CGRect(origin: glassCenter, size: CGSize(width: glassWidth, height: glassHeight))
        
        let path = UIBezierPath(roundedRect: glass, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 4, height: 4))
        
        path.lineWidth = lineWidth/3

        return path
    }
    
    private func bezierPathForMiddleGlassLine() -> UIBezierPath {
        let glassWidth = faceReduis / Scaling.FaceReduisToGlassesWidthRatio
        let glassHeight = faceReduis / Scaling.FaceReduisToGlassesHeightRatio
        let glassVerticalOffset = faceReduis / Scaling.FaceReduisToGlassesOffsetRatio
        let glassHorizontalSperation = faceReduis / Scaling.FaceReduisToGlassesSeperationRatio
        
        var glassCenter = faceCenter
        glassCenter.y -= glassVerticalOffset
        
        let start = CGPoint(x: glassCenter.x - glassHorizontalSperation / 2 + glassWidth / 2, y: glassCenter.y)
        let end = CGPoint(x: glassCenter.x + glassHorizontalSperation / 2 - glassWidth / 2, y: glassCenter.y)
        
        let path = UIBezierPath()
    
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        path.lineWidth = lineWidth * 0.8
        return path
    }
    
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1   // Reset the scale back to 1 each time
        }
    }
    
    
    override func drawRect(rect: CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceReduis, startAngle: 0,
            endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        fillColor.setFill()
        strockColor.setStroke()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        var smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0  // If nill use 0.0
        bezierPathForSmile(smiliness).stroke()
        
        UIColor.blackColor().setStroke()
        UIColor.blackColor().colorWithAlphaComponent(0.94).setFill()
        opaque = false

        bezierPathForMiddleGlassLine().stroke()
        
        bezierPathForGlasses(.Left).stroke()
        bezierPathForGlasses(.Right).stroke()
        bezierPathForGlasses(.Left).fill()
        bezierPathForGlasses(.Right).fill()
    }
}