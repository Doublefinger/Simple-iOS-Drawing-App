//
//  ViewController.swift
//  Lab3
//
//  Created by Shitianyu Pan on 9/26/16.
//  Copyright © 2016 Doublefinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var drawColor: UIColor = UIColor.clearColor()
    var lineWidth: CGFloat = 1
    var currentLine: Line? = nil
    var prevCP: ColorPallet? = nil
    var topY: CGFloat = 95
    var bottomY: CGFloat = 100
    var lines: [Line] = [Line]()
    var titleExists: Bool = false
    var drawTitle: UITextField? = nil
    
    @IBAction func changeLineWidth(sender: UISlider) {
        lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func clear(sender: AnyObject) {
        for v in view.subviews {
            if (v is Line || v is UITextField){
                v.removeFromSuperview()
            }
        }
        lines.removeAll()
        titleExists = false
    }

    @IBAction func undo(sender: AnyObject) {
        if lines.count > 0 {
            lines[lines.endIndex-1].removeFromSuperview()
            lines.removeLast()
        }
    }
    
    @IBAction func backgroundChange(sender: UISegmentedControl) {
        var background: UIColor
        switch sender.selectedSegmentIndex{
        case 0:
            background = UIColor.whiteColor()
        case 1:
            background = UIColor.grayColor()
        default:
            background = UIColor.blackColor()
        }
        self.view.backgroundColor = background
        //switch title color
        if titleExists {
            if background == UIColor.blackColor() {
                drawTitle!.textColor = UIColor.whiteColor()
            } else {
                drawTitle!.textColor = UIColor.blackColor()
            }
        }
    }
    
    @IBAction func addTitle(sender: AnyObject) {
        if !titleExists {
            let titleRect = CGRect(x: view.frame.width/2, y: 60, width: 100, height: 30)
            drawTitle = UITextField(frame: titleRect)
            drawTitle!.text = "Title"
            if self.view.backgroundColor == UIColor.blackColor() {
                drawTitle!.textColor = UIColor.whiteColor()
            } else {
                drawTitle!.textColor = UIColor.blackColor()
            }
            view.addSubview(drawTitle!)
            titleExists = true
        }
    }
    
    func selectColor(sender: ColorPallet) {
        //set color
        self.drawColor = sender.backgroundColor!
        //add border to indicate current selection
        if prevCP != nil {
            prevCP?.layer.borderWidth = 0
        }
        prevCP = sender
        sender.layer.borderWidth = 2
        //make button looks smaller
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myRect = CGRect(x:0, y: topY, width:self.view.frame.width, height: self.view.frame.height-bottomY-topY)
        currentLine = Line(frame: myRect)
        currentLine?.backgroundColor = UIColor.clearColor()
        currentLine?.currentColor = drawColor
        currentLine?.currentWidth = lineWidth
        var point = (touches.first)!.locationInView(self.view) as CGPoint
        point.y = point.y - topY
        currentLine?.points.append(point)
        lines.append(currentLine!)
        self.view.addSubview(currentLine!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var point = (touches.first)!.locationInView(self.view) as CGPoint
        point.y = point.y - topY
        currentLine?.points.append(point)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var point = (touches.first)!.locationInView(self.view) as CGPoint
        point.y = point.y - topY
        currentLine?.points.append(point)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var colors : [UIColor] = [UIColor.redColor(), UIColor.orangeColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.magentaColor()]
        for index in 0...6 {
            let cp = ColorPallet(color: colors[index], index: index, y: view.frame.height-bottomY)
            cp.addTarget(self, action: #selector(self.selectColor), forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(cp)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

