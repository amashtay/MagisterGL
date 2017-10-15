//
//  MAGFileManager.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 08.10.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


class MAGFileManager: NSObject
{
  static let sharedInstance = MAGFileManager()
  
  func getXYZArray() -> Array<SCNVector3>
  {
    do
    {
      if let path = Bundle.main.path(forResource: "xyz",
                                     ofType: "dat")
      {
        let scaner = try MAGBinaryDataScanner.init(data: NSData.init(contentsOfFile: path),
                                  littleEndian: true,
                                  encoding: String.Encoding.ascii)
        var arrayOfVectors: [SCNVector3]? = []
        var array: [Float64]? = []
        while let value = scaner.readDouble()
        {
          array?.append(value)
          if array?.count == 3
          {
            let vector = SCNVector3Make(Float(array![0]), Float(array![1]), Float(array![2]))
            arrayOfVectors?.append(vector)
            array = []
          }
        }
        return arrayOfVectors!
      }
    }
    catch let err as NSError
    {
      // do something with Error
      print(err)
    }
    return []
  }
  
  
  func getNVERArray() -> [[Int]]
  {
    do
    {
      if let path = Bundle.main.path(forResource: "nver",
                                     ofType: "dat")
      {
        let scaner = try MAGBinaryDataScanner.init(data: NSData.init(contentsOfFile: path),
                                                   littleEndian: true,
                                                   encoding: String.Encoding.ascii)
        var arrayOfVectors: [[Int]]? = []
        var array: [Int]? = []
        while let value = scaner.read32()
        {
          array?.append(Int(value))
          if array?.count == 14
          {
            arrayOfVectors?.append(array!)
            array = []
          }
        }
        return arrayOfVectors!
      }
    }
    catch let err as NSError
    {
      // do something with Error
      print(err)
    }
    return []
  }

}
