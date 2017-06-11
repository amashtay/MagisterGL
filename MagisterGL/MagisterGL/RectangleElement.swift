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
  
  init(startPoint: CGPoint,
       size: CGSize)
  {
    self.startPoint = startPoint
    self.size = size
  }
}
