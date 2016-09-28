//
//  Line.swift
//  Lab3
//
//  Created by Shitianyu Pan on 9/26/16.
//  Copyright © 2016 Doublefinger. All rights reserved.
//

import UIKit

class Line: UIView {
    var currentColor: UIColor = UIColor.whiteColor()
    var currentWidth: CGFloat = 1
    var points: [CGPoint] = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let path = createQuadPath()
        currentColor.setStroke()
        path.stroke()
        path.fill()
    }
    
    private func findMidpoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        // implement this function here
        return CGPoint(x: (firstPoint.x + secondPoint.x) / 2, y: (firstPoint.y + secondPoint.y) / 2)
    }
    
    func createQuadPath() -> UIBezierPath {
        let newPath = UIBezierPath()
        newPath.lineWidth = currentWidth
        let firstLocation = points[0]
        newPath.moveToPoint(firstLocation)
        if points.count == 1 {
            return newPath
        }
        if points.count == 2 {
            newPath.addArcWithCenter(firstLocation, radius: newPath.lineWidth/2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
            currentColor.setFill()
            return newPath
        }
        let secondLocation = points[1]
        let firstMidpoint = findMidpoint(firstLocation, secondPoint: secondLocation)
        newPath.addLineToPoint(firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentLocation = points[index]
            let nextLocation = points[index + 1]
            let midpoint = findMidpoint(currentLocation, secondPoint: nextLocation)
            newPath.addQuadCurveToPoint(midpoint, controlPoint: currentLocation)
        }
        let lastLocation = points.last
        newPath.addLineToPoint(lastLocation!)
        UIColor.clearColor().setFill()
        return newPath
    }
}
