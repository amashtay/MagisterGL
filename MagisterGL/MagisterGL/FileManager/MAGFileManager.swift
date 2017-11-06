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
    public var testType: Int = 0
    static let sharedInstance = MAGFileManager()
    
    
    func getXYZArray(path: String) -> Array<SCNVector3>
    {
        do
        {
            let data = try String(contentsOfFile: path,
                                  encoding: String.Encoding.ascii)
            var arrayOfVectors: [SCNVector3]? = []
            for string in data.components(separatedBy: "\n")
            {
                if string != ""
                {
                    let array = string.components(separatedBy: " ").map { Float($0)! }
                    if array.count == 3
                    {
                        let vector = SCNVector3Make(array[0], array[1], array[2])
                        arrayOfVectors?.append(vector)
                    }
                }
            }
            return arrayOfVectors!
        }
        catch let err as NSError
        {
            // do something with Error
            print(err)
        }
        return []
    }
    
    
    func getXYZArray() -> Array<SCNVector3>
    {
        var path: String
        switch testType
        {
        case 0:
            path = Bundle.main.path(forResource: "xyz",
                                    ofType: "txt")!
            break;
        case 1:
            path = Bundle.main.path(forResource: "xyz2",
                                    ofType: "txt")!
            break;
        default:
            path = Bundle.main.path(forResource: "xyz",
                                    ofType: "txt")!
            break;
        }
        return self.getXYZArray(path: path)
    }
    
    
    func getNVERArray() -> [[Int]]
    {
        var path: String
        switch testType
        {
        case 0:
            path = Bundle.main.path(forResource: "nver",
                                    ofType: "txt")!
            break;
        case 1:
            path = Bundle.main.path(forResource: "nver2",
                                    ofType: "txt")!
            break;
        default:
            path = Bundle.main.path(forResource: "nver",
                                    ofType: "txt")!
            break;
        }
        return self.getNVERArray(path: path)
    }
    
    func getNVERArray(path: String) -> [[Int]]
    {
        do
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
        catch let err as NSError
        {
            // do something with Error
            print(err)
        }
        return []
    }
    
}
