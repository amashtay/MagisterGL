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
                                     ofType: "txt")
      {
        let data = try String(contentsOfFile: path,
                              encoding: String.Encoding.ascii)
        var arrayOfVectors: [SCNVector3]? = []
        for string in data.components(separatedBy: "\n")
        {
          if string != ""
          {
            let array = string.components(separatedBy: " ").map { Float($0)!}
            if array.count == 3
            {
              let vector = SCNVector3Make(array[0], array[1], array[2])
              arrayOfVectors?.append(vector)
            }
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
                                     ofType: "txt")
      {
        let data = try String(contentsOfFile: path,
                              encoding: String.Encoding.utf8)
        var arrayOfVectors: [[Int]]? = []
        for string in data.components(separatedBy: "\n")
        {
          if string != ""
          {
            let array = string.components(separatedBy: " ").map { Int($0)!}
            arrayOfVectors?.append(array)
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
