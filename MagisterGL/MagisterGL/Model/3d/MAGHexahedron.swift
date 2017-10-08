//
//  MAGHexahedron.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 08.10.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


class MAGHexahedron: NSObject
{
  var positions: [SCNVector3];
  
  override init()
  {
    let halfSide: Float = 10.0
    self.positions =
      [
        SCNVector3Make(-halfSide, -halfSide,  halfSide + 5),
        SCNVector3Make( halfSide, -halfSide + 5,  halfSide),
        SCNVector3Make(-halfSide + 5, -halfSide, -halfSide),
        SCNVector3Make( halfSide, -halfSide, -halfSide),
        SCNVector3Make(-halfSide,  halfSide,  halfSide),
        SCNVector3Make( halfSide,  halfSide,  halfSide),
        SCNVector3Make(-halfSide,  halfSide, -halfSide),
        SCNVector3Make( halfSide,  halfSide, -halfSide)]
  }
  
  init(positions: [SCNVector3])
  {
    self.positions = positions;
  }
  
}
