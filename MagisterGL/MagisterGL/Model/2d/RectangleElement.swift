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
  var topColorLeft: UIColor = UIColor.red
  var topColorRight: UIColor = UIColor.green
  var bottomColorLeft: UIColor = UIColor.blue
  var bottomColorRight: UIColor = UIColor.cyan
  
  init(startPoint: CGPoint,
       size: CGSize)
  {
    self.startPoint = startPoint
    self.size = size
  }
}
