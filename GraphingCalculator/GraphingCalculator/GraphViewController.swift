//
//  GraphViewController.swift
//  Calculator
//
//  Created by Ana Perez on 1/21/17.
//  Copyright © 2017 Ana Perez. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class GraphViewController: UIViewController {
    //Calculator Brain is an optional because what if there is no equation to graph ?
    var brain:CalculatorBrain?
    var graphTitle: String? {
        didSet{
            self.title = graphTitle
        }
    }
    
    /*   @IBOutlet var graphView: GraphView!{
     didSet {
     graphView.dataSource = self
     graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView,action: "scale:"))
     
     graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView,action: "pan:"))
     
     var doubleTap = UITapGestureRecognizer(target: graphView, action: "moveOrigin:")
     doubleTap.numberOfTapsRequired = 2
     graphView.addGestureRecognizer(doubleTap)
     }
     } */
    
}
