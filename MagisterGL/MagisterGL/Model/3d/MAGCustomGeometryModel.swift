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
    
  override init()
  {
    super.init()
    
    createElementsArray()
  }
  
  func createElementsArray ()
  {
    let xyxArray = MAGFileManager.sharedInstance.getXYZArray()
    let nverArray = MAGFileManager.sharedInstance.getNVERArray()
    for nverElementArray in nverArray
    {
      var positionArray : [SCNVector3]? = []
      for gridNum in nverElementArray
      {
        if gridNum != 0
        {
          let vector = xyxArray[gridNum - 1]
          positionArray?.append(vector)
        }
      }
      elementsArray.append(MAGHexahedron.init(positions: positionArray!))
    }
  }
}
