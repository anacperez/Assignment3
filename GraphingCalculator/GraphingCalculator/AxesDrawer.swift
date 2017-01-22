

//
//  AxesDrawer.swift
//  Calculator
//
//  Created by Ana Perez on 1/21/17.
//  Copyright © 2017 Ana Perez. All rights reserved.
//  This class contructs the main Axes necessary to draw the graph

import Foundation

import UIKit
import UIKit

class AxesDrawer
{
    private struct Constants {
        static let HashmarkSize: CGFloat = 6
    }
    
    var color = UIColor.blue
    var minimumPointsPerHashmark: CGFloat = 40
    var contentScaleFactor: CGFloat = 1 // set this from UIView's contentScaleFactor to position axes with maximum accuracy
    
    convenience init(color: UIColor, contentScaleFactor: CGFloat) {
        self.init()
        self.color = color
        self.contentScaleFactor = contentScaleFactor
    }
    
    convenience init(color: UIColor) {
        self.init()
        self.color = color
    }
    
    convenience init(contentScaleFactor: CGFloat) {
        self.init()
        self.contentScaleFactor = contentScaleFactor
    }
    func drawAxesInRect(bounds: CGRect, origin: CGPoint, pointsPerUnit: CGFloat)
    {
        UIGraphicsGetCurrentContext()!.saveGState()
        color.set()
        let path = UIBezierPath()
    }
}




