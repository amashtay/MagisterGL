//
//  RectangleElement.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//

import UIKit

class RectangleElement
{
  var startPoint: CGPoint = CGPoint.zero
  var size: CGSize = CGSize.zero
  var topColor1: UIColor = UIColor.red
  var topColor2: UIColor = UIColor.green
  var bottomColor1: UIColor = UIColor.blue
  var bottomColor2: UIColor = UIColor.cyan
  
  init(startPoint: CGPoint,
       size: CGSize)
  {
    self.startPoint = startPoint
    self.size = size
  }
}
