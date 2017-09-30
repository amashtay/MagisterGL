//
//  CustomGeometryView.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 26.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


class CustomGeometryView: SCNView
{

  override func awakeFromNib()
  {
    super.awakeFromNib()
    
    setupScene()
  }
  
  private var cubeNode: SCNNode?
  
  private func setupScene()
  {
    // Configure the Scene View
    self.backgroundColor = .darkGray
    
    // Create the scene
    let scene = SCNScene()
    
    // Create a camera and attach it to a node
    let camera = SCNCamera()
    camera.xFov = 10
    camera.yFov = 45
    
    let cameraNode = SCNNode()
    cameraNode.camera = camera
    cameraNode.position = SCNVector3(0, 0, 50)
    scene.rootNode.addChildNode(cameraNode)
    
    self.allowsCameraControl = true
    self.showsStatistics = true
    
    // create and add an ambient light to the scene
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light?.type = .ambient
    ambientLightNode.light?.color = UIColor.darkGray
    scene.rootNode.addChildNode(ambientLightNode)
    
    createCube()
    scene.rootNode.addChildNode(self.cubeNode!)
    self.scene = scene
  }
  
  private func createCube()
  {
    let cubeSide: Float = 15.0
    let halfSide: Float = cubeSide / 2.0
    let positions = [
      SCNVector3Make(-halfSide, -halfSide,  halfSide),
      SCNVector3Make( halfSide, -halfSide,  halfSide),
      SCNVector3Make(-halfSide, -halfSide, -halfSide),
      SCNVector3Make( halfSide, -halfSide, -halfSide),
      SCNVector3Make(-halfSide,  halfSide,  halfSide),
      SCNVector3Make( halfSide,  halfSide,  halfSide),
      SCNVector3Make(-halfSide,  halfSide, -halfSide),
      SCNVector3Make( halfSide,  halfSide, -halfSide),
      
      // repeat exactly the same
      SCNVector3Make(-halfSide, -halfSide,  halfSide),
      SCNVector3Make( halfSide, -halfSide,  halfSide),
      SCNVector3Make(-halfSide, -halfSide, -halfSide),
      SCNVector3Make( halfSide, -halfSide, -halfSide),
      SCNVector3Make(-halfSide,  halfSide,  halfSide),
      SCNVector3Make( halfSide,  halfSide,  halfSide),
      SCNVector3Make(-halfSide,  halfSide, -halfSide),
      SCNVector3Make( halfSide,  halfSide, -halfSide),
      
      // repeat exactly the same
      SCNVector3Make(-halfSide, -halfSide,  halfSide),
      SCNVector3Make( halfSide, -halfSide,  halfSide),
      SCNVector3Make(-halfSide, -halfSide, -halfSide),
      SCNVector3Make( halfSide, -halfSide, -halfSide),
      SCNVector3Make(-halfSide,  halfSide,  halfSide),
      SCNVector3Make( halfSide,  halfSide,  halfSide),
      SCNVector3Make(-halfSide,  halfSide, -halfSide),
      SCNVector3Make( halfSide,  halfSide, -halfSide)]     // repeat exactly the same
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
    let indices = [
      // bottom
      0, 2, 1,
      1, 2, 3,
      // back
      10, 14, 11,  // 2, 6, 3,   + 8
      11, 14, 15,  // 3, 6, 7,   + 8
      // left
      16, 20, 18,  // 0, 4, 2,   + 16
      18, 20, 22,  // 2, 4, 6,   + 16
      // right
      17, 19, 21,  // 1, 3, 5,   + 16
      19, 23, 21,  // 3, 7, 5,   + 16
      // front
      8,  9, 12,  // 0, 1, 4,   + 8
      9, 13, 12,  // 1, 5, 4,   + 8
      // top
      4, 5, 6,
      5, 7, 6] as [CInt]
    
    let vertexSource = SCNGeometrySource(vertices: positions,
                                         count: 24)
    let normalSource = SCNGeometrySource(normals: normals,
                                         count: 24)
    let indexData = Data(bytes: indices,
                         count: MemoryLayout<CInt>.size * indices.count)
    let element = SCNGeometryElement(data: indexData,
                                     primitiveType: .triangles,
                                     primitiveCount: 12,
                                     bytesPerIndex: MemoryLayout<CInt>.size)
    let geometry = SCNGeometry(sources: [vertexSource, normalSource],
                               elements: [element])
    geometry.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
    let cubeNode = SCNNode(geometry: geometry)
    self.cubeNode = cubeNode
  }

}
