//
//  GameScene.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 23.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import SpriteKit


class MAGIsolineScene: SKScene
{
  
  private let model: MAGSource = MAGSource.init()
  
  override func didMove(to view: SKView)
  {
    let effect = SKEffectNode()
    addChild(effect)
    
    for rectangleElement in model.elementsArray
    {
      let squareFrame = CGRect(origin: rectangleElement.startPoint,
                               size: rectangleElement.size)
      let topColorLeft = CIColor.init(color: rectangleElement.topColorLeft)
      let topColorRight = CIColor.init(color: rectangleElement.topColorRight)
      let bottomColorLeft = CIColor.init(color: rectangleElement.bottomColorLeft)
      let bottomColorRight = CIColor.init(color: rectangleElement.bottomColorRight)
      
      let textureSize = rectangleElement.size
      let shapeTexture = SKTexture(size: textureSize,
                                   topColorLeft: topColorLeft,
                                   topColorRight: topColorRight,
                                   bottomColorLeft: bottomColorLeft,
                                   bottomColorRight: bottomColorRight)
      let shapeNode = SKShapeNode(rect: squareFrame)
      shapeNode.fillColor = .white
      shapeNode.strokeColor = .white
      shapeNode.fillTexture = shapeTexture
      effect.addChild(shapeNode)
    }
  }
}
