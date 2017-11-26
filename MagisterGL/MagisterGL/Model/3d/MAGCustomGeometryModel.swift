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
    var minVector: SCNVector3 = SCNVector3Zero
    var maxVector: SCNVector3 = SCNVector3Zero
    var xyzArray: Array<SCNVector3> = []
    var nverArray:  [[Int]] = []
    
    override init()
    {
        super.init()
        
        createElementsArray()
    }
    
    func createElementsArray ()
    {
        xyzArray = MAGFileManager.sharedInstance.getXYZArray()
        nverArray = MAGFileManager.sharedInstance.getNVERArray()
        
        minVector = xyzArray.first!
        maxVector = xyzArray.last!
        
        let xyzCalc: Float = abs((maxVector.y - minVector.y) / 4.0)
        
        var arrayOfVectors: [SCNVector3]? = []
        for xyz in xyzArray
        {
            let vector = SCNVector3Make(Float(xyz.x / xyzCalc),
                                        Float(xyz.y / xyzCalc),
                                        Float(xyz.z / xyzCalc))
            arrayOfVectors?.append(vector)
        }
        xyzArray = arrayOfVectors!
        minVector = xyzArray.first!
        maxVector = xyzArray.last!
        
        for nverElementArray in nverArray
        {
            var positionArray : [SCNVector3]? = []
            var i : Int = 0
            for gridNum in nverElementArray
            {
                if i < 8
                {
                    let vector = xyzArray[gridNum - 1]
                    positionArray?.append(vector)
                }
                i = i + 1
            }
            elementsArray.append(MAGHexahedron.init(positions: positionArray!))
        }
        centerPoint = SCNVector3Make((maxVector.x - minVector.x) / 2.0 + minVector.x,
                                     (maxVector.y - minVector.y) / 2.0 + minVector.y,
                                     (maxVector.z - minVector.z) / 2.0 + minVector.z)
    }
}
