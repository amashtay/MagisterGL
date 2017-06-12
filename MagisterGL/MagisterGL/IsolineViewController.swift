//
//  IsolineViewController.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//

import UIKit

class IsolineViewController: UIViewController
{
  @IBOutlet weak var isolineView: IsolineView!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    let xMin = 0.0
    let yMin = 0.0
    
    let xMax = 500.0
    let yMax = 800.0
    
    let hX = 100.0
    let hY = 100.0
    
    var elementsArray : [RectangleElement] = [RectangleElement]()
    
    var xArray : [NSNumber] = [NSNumber]()
    var x = xMin
    while x <= xMax
    {
      xArray.append(NSNumber(value: x))
      x += hX
    }
    
    var yArray : [NSNumber] = [NSNumber]()
    var y = yMin
    while y <= yMax
    {
      yArray.append(NSNumber(value: y))
      y += hY
    }
    
    for x in xArray
    {
      for y in yArray
      {
        let element = RectangleElement(startPoint: CGPoint(x: x.doubleValue,
                                                           y: y.doubleValue),
                                       size: CGSize(width: hX,
                                                    height: hY))
        elementsArray.append(element)
        
      }
    }
    isolineView.elementsArray = elementsArray
    
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    
  }
  
}
