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
                                         self.model.centerPoint.z + (self.model.maxVector.z - self.model.minVector.z) / 2.0 + 20)
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
    
    private func createCube()
    {
        var j = 0 as Int32
        var globalPositions : [SCNVector3] = []
        var globalNormals : [SCNVector3] = []
        var globalIndicies : [CInt] = []
        for hexahedron in self.model.elementsArray
        {
            let positions = hexahedron.positions + hexahedron.positions + hexahedron.positions
            globalPositions = globalPositions + positions
            let normals = [
                SCNVector3Make( 0, -1, 0),
                SCNVector3Make( 0, -1, 0),
                SCNVector3Make( 0, -1, 0),
                SCNVector3Make( 0, -1, 0),
                
                SCNVector3Make( 0, 1, 0),
                SCNVector3Make( 0, 1, 0),
                SCNVector3Make( 0, 1, 0),
                SCNVector3Make( 0, 1, 0),
                
                
                SCNVector3Make( 0, 0,  1),
                SCNVector3Make( 0, 0,  1),
                SCNVector3Make( 0, 0, -1),
                SCNVector3Make( 0, 0, -1),
                
                SCNVector3Make( 0, 0, 1),
                SCNVector3Make( 0, 0, 1),
                SCNVector3Make( 0, 0, -1),
                SCNVector3Make( 0, 0, -1),
                
                
                SCNVector3Make(-1, 0, 0),
                SCNVector3Make( 1, 0, 0),
                SCNVector3Make(-1, 0, 0),
                SCNVector3Make( 1, 0, 0),
                
                SCNVector3Make(-1, 0, 0),
                SCNVector3Make( 1, 0, 0),
                SCNVector3Make(-1, 0, 0),
                SCNVector3Make( 1, 0, 0),]
            globalNormals = globalNormals + normals
            let addValue = j * 24
            let indices = [
                // bottom
                0 + addValue, 2 + addValue, 1 + addValue,
                1 + addValue, 2 + addValue, 3 + addValue,
                // back
                10 + addValue, 14 + addValue, 11 + addValue,  // 2, 6, 3,   + 8
                11 + addValue, 14 + addValue, 15 + addValue,  // 3, 6, 7,   + 8
                // left
                16 + addValue, 20 + addValue, 18 + addValue,  // 0, 4, 2,   + 16
                18 + addValue, 20 + addValue, 22 + addValue,  // 2, 4, 6,   + 16
                // right
                17 + addValue, 19 + addValue, 21 + addValue,  // 1, 3, 5,   + 16
                19 + addValue, 23 + addValue, 21 + addValue,  // 3, 7, 5,   + 16
                // front
                8 + addValue,  9 + addValue, 12 + addValue,  // 0, 1, 4,   + 8
                9 + addValue, 13 + addValue, 12 + addValue,  // 1, 5, 4,   + 8
                // top
                4 + addValue, 5 + addValue, 6 + addValue,
                5 + addValue, 7 + addValue, 6 + addValue] as [CInt]
            globalIndicies = globalIndicies + indices
          j = j + 1
        }
      
      let vertexSource = SCNGeometrySource(vertices: globalPositions)
      let normalSource = SCNGeometrySource(normals: globalNormals)
      let indexData = Data(bytes: globalIndicies,
                           count: MemoryLayout<CInt>.size * globalIndicies.count)
      let element = SCNGeometryElement(data: indexData,
                                       primitiveType: .triangles,
                                       primitiveCount: Int(12 * j),
                                       bytesPerIndex: MemoryLayout<CInt>.size)
      let geometry = SCNGeometry(sources: [vertexSource, normalSource],
                                 elements: [element])
      geometry.firstMaterial?.diffuse.contents = UIColor(red: 0.149,
                                                         green: 0.604,
                                                         blue: 0.859,
                                                         alpha: 1.0)
      let cubeNode = SCNNode(geometry: geometry)
      self.scene?.rootNode.addChildNode(cubeNode)
      
      let elementBorder = SCNGeometryElement(data: indexData,
                                             primitiveType: .line,
                                             primitiveCount: Int(12 * j),
                                             bytesPerIndex: MemoryLayout<CInt>.size)
      let geometryBorder = SCNGeometry(sources: [vertexSource, normalSource],
                                       elements: [elementBorder])
      geometryBorder.firstMaterial?.diffuse.contents = UIColor.red
      let borderCubeNode = SCNNode(geometry: geometryBorder)
      self.scene?.rootNode.addChildNode(borderCubeNode)
    }
    
}
