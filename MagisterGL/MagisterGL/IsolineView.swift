//
//  IsolineView.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//

import UIKit

class IsolineView: UIView
{
  
  var elementsArray: [RectangleElement] = []
		
  
  override func draw(_ rect: CGRect)
  {
    super.draw(rect)
    
    for rectangleElement in elementsArray
    {
      let color: UIColor = UIColor.red
      
      let drect = CGRect(origin: rectangleElement.startPoint,
                         size: rectangleElement.size)
      let bpath:UIBezierPath = UIBezierPath(rect: drect)
      
      color.set()
      bpath.stroke()
    }
  }
  
}
