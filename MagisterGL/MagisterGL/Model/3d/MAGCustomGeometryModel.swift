//
//  MAGCustomGeometryModel.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 08.10.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


class MAGCustomGeometryModel: NSObject
{
  var elementsArray: [MAGHexahedron] = []
  var centerPoint: SCNVector3 = SCNVector3Zero
    
  override init()
  {
    super.init()
    
    createElementsArray()
  }
  
  func createElementsArray ()
  {
    let xyzArray = MAGFileManager.sharedInstance.getXYZArray()
    let nverArray = MAGFileManager.sharedInstance.getNVERArray()
    for nverElementArray in nverArray
    {
      var positionArray : [SCNVector3]? = []
      for gridNum in nverElementArray
      {
        if gridNum != 0
        {
          let vector = xyzArray[gridNum - 1]
          positionArray?.append(vector)
        }
      }
      elementsArray.append(MAGHexahedron.init(positions: positionArray!))
    }
    let minVector = xyzArray.first
    let maxVector = xyzArray.last
    centerPoint = SCNVector3Make(((maxVector?.x)! - (minVector?.x)!) / 2.0, ((maxVector?.y)! - (minVector?.y)!) / 2.0, ((maxVector?.z)! - (minVector?.z)!) / 2.0)
  }
}
