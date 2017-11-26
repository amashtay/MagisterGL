//
//  MAGCustomGeometryView.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 26.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


extension SCNNode
{
    func cleanup()
    {
        for child in childNodes
        {
            child.cleanup()
        }
        geometry = nil
    }
}

extension SCNGeometry
{
    class func triangleFrom(vector1: SCNVector3,
                            vector2: SCNVector3,
                            vector3: SCNVector3) -> SCNGeometry
    {
        let indices: [Int32] = [0, 1, 2]
        
        let source = SCNGeometrySource(vertices: [vector1, vector2, vector3])
        
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        
        return SCNGeometry(sources: [source], elements: [element])
    }
}


class MAGCustomGeometryView: SCNView
{
    private var model: MAGCustomGeometryModel = MAGCustomGeometryModel.init()
    
    deinit
    {
        scene?.rootNode.cleanup()
    }
    
    
    public func redraw()
    {
        scene?.rootNode.cleanup()
        setupScene()
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        setupScene()
    }
    
    private func setupScene()
    {
        self.model = MAGCustomGeometryModel.init()
        // Configure the Scene View
        self.backgroundColor = .darkGray
        
        // Create the scene
        let scene = SCNScene()
        
        // Create a camera and attach it to a node
        let camera = SCNCamera()
        //camera.xFov = 10
        //camera.yFov = 45
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(self.model.centerPoint.x,
                                         self.model.centerPoint.y,
                                         self.model.centerPoint.z + (self.model.maxVector.z - self.model.minVector.z) / 2.0 + 10)
        scene.rootNode.addChildNode(cameraNode)
        
        self.allowsCameraControl = true
        self.showsStatistics = true
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        scene.rootNode.pivot = SCNMatrix4MakeTranslation(self.model.centerPoint.x,
                                                         self.model.centerPoint.y,
                                                         self.model.centerPoint.z)
        
        self.scene = scene
        createCube()
    }
    
    private func drawRectangle(vector1: SCNVector3,
                               vector2: SCNVector3,
                               vector3: SCNVector3,
                               vector4: SCNVector3)
    {
        let triangle = SCNGeometry.triangleFrom(vector1: vector1,
                                                vector2: vector2,
                                                vector3: vector4)
        let triangleNode = SCNNode(geometry: triangle)
        triangleNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.149,
                                                                         green: 0.604,
                                                                         blue: 0.859,
                                                                         alpha: 1.0)
        triangleNode.geometry?.firstMaterial?.isDoubleSided = true
        self.scene?.rootNode.addChildNode(triangleNode)
        
        let triangle2 = SCNGeometry.triangleFrom(vector1: vector1,
                                                 vector2: vector3,
                                                 vector3: vector4)
        let triangle2Node = SCNNode(geometry: triangle2)
        triangle2Node.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.149,
                                                                          green: 0.604,
                                                                          blue: 0.859,
                                                                          alpha: 1.0)
        triangle2Node.geometry?.firstMaterial?.isDoubleSided = true
        self.scene?.rootNode.addChildNode(triangle2Node)
        
    }
    
    private func createCube()
    {
        for hexahedron in self.model.elementsArray
        {
            if hexahedron.minCount() > 3
            {
                continue
            }
            
            let positions = hexahedron.positions
            let countArray = hexahedron.countArray
            if (countArray[0] < 3 ||
                countArray[1] < 3 ||
                countArray[2] < 3 ||
                countArray[3] < 3)
            {
                self.drawRectangle(vector1: positions[0],
                                   vector2: positions[1],
                                   vector3: positions[2],
                                   vector4: positions[3])
            }
            if (countArray[0] < 3 ||
                countArray[1] < 3 ||
                countArray[2] < 3 ||
                countArray[3] < 3)
            {
                self.drawRectangle(vector1: positions[2],
                                   vector2: positions[3],
                                   vector3: positions[6],
                                   vector4: positions[7])
            }
            if (countArray[0] < 3 ||
                countArray[2] < 3 ||
                countArray[4] < 3 ||
                countArray[6] < 3)
            {
                self.drawRectangle(vector1: positions[0],
                                   vector2: positions[2],
                                   vector3: positions[4],
                                   vector4: positions[6])
            }
            if (countArray[1] < 3 ||
                countArray[3] < 3 ||
                countArray[5] < 3 ||
                countArray[7] < 3)
            {
                self.drawRectangle(vector1: positions[1],
                                   vector2: positions[3],
                                   vector3: positions[5],
                                   vector4: positions[7])
            }
            if (countArray[0] < 3 ||
                countArray[1] < 3 ||
                countArray[4] < 3 ||
                countArray[5] < 3)
            {
                self.drawRectangle(vector1: positions[0],
                                   vector2: positions[1],
                                   vector3: positions[4],
                                   vector4: positions[5])
            }
            if (countArray[4] < 3 ||
                countArray[5] < 3 ||
                countArray[6] < 3 ||
                countArray[7] < 3)
            {
                self.drawRectangle(vector1: positions[4],
                                   vector2: positions[5],
                                   vector3: positions[6],
                                   vector4: positions[7])
            }
//            let positions = hexahedron.positions + hexahedron.positions + hexahedron.positions
//            let normals = [
//                SCNVector3Make( 0, -1, 0),
//                SCNVector3Make( 0, -1, 0),
//                SCNVector3Make( 0, -1, 0),
//                SCNVector3Make( 0, -1, 0),
//
//                SCNVector3Make( 0, 1, 0),
//                SCNVector3Make( 0, 1, 0),
//                SCNVector3Make( 0, 1, 0),
//                SCNVector3Make( 0, 1, 0),
//
//
//                SCNVector3Make( 0, 0,  1),
//                SCNVector3Make( 0, 0,  1),
//                SCNVector3Make( 0, 0, -1),
//                SCNVector3Make( 0, 0, -1),
//
//                SCNVector3Make( 0, 0, 1),
//                SCNVector3Make( 0, 0, 1),
//                SCNVector3Make( 0, 0, -1),
//                SCNVector3Make( 0, 0, -1),
//
//
//                SCNVector3Make(-1, 0, 0),
//                SCNVector3Make( 1, 0, 0),
//                SCNVector3Make(-1, 0, 0),
//                SCNVector3Make( 1, 0, 0),
//
//                SCNVector3Make(-1, 0, 0),
//                SCNVector3Make( 1, 0, 0),
//                SCNVector3Make(-1, 0, 0),
//                SCNVector3Make( 1, 0, 0),]
//            let indices = [
//                // bottom
//                0, 2, 1,
//                1, 2, 3,
//                // back
//                10, 14, 11,  // 2, 6, 3,   + 8
//                11, 14, 15,  // 3, 6, 7,   + 8
//                // left
//                16, 20, 18,  // 0, 4, 2,   + 16
//                18, 20, 22,  // 2, 4, 6,   + 16
//                // right
//                17, 19, 21,  // 1, 3, 5,   + 16
//                19, 23, 21,  // 3, 7, 5,   + 16
//                // front
//                8,  9, 12,  // 0, 1, 4,   + 8
//                9, 13, 12,  // 1, 5, 4,   + 8
//                // top
//                4, 5, 6,
//                5, 7, 6] as [CInt]
//
//            let vertexSource = SCNGeometrySource(vertices: positions)
//            let normalSource = SCNGeometrySource(normals: normals)
//            let indexData = Data(bytes: indices,
//                                 count: MemoryLayout<CInt>.size * indices.count)
//            let element = SCNGeometryElement(data: indexData,
//                                             primitiveType: .triangles,
//                                             primitiveCount: 12,
//                                             bytesPerIndex: MemoryLayout<CInt>.size)
//            let geometry = SCNGeometry(sources: [vertexSource, normalSource],
//                                       elements: [element])
//            geometry.firstMaterial?.diffuse.contents = UIColor(red: 0.149,
//                                                               green: 0.604,
//                                                               blue: 0.859,
//                                                               alpha: 1.0)
//            let cubeNode = SCNNode(geometry: geometry)
//            self.scene?.rootNode.addChildNode(cubeNode)
//
//            let elementBorder = SCNGeometryElement(data: indexData,
//                                                   primitiveType: .line,
//                                                   primitiveCount: 12,
//                                                   bytesPerIndex: MemoryLayout<CInt>.size)
//            let geometryBorder = SCNGeometry(sources: [vertexSource, normalSource],
//                                             elements: [elementBorder])
//            geometryBorder.firstMaterial?.diffuse.contents = UIColor.red
//            let borderCubeNode = SCNNode(geometry: geometryBorder)
//            self.scene?.rootNode.addChildNode(borderCubeNode)
        }
    }
    
}
