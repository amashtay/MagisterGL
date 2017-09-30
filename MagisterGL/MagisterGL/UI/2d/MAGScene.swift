//
//  GameScene.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 23.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import SpriteKit


enum IIMySceneZPosition: Int
{
  case Scrolling = 0
  case VerticalAndHorizontalScrolling
  case Static
}


class MAGScene: SKScene
{
  private let model: MAGSource = MAGSource.init()
  
  var innerContentSize: CGSize = CGSize.zero
  public var contentSize: CGSize
  {
    get
    {
      return innerContentSize
    }
    set
    {
      if !newValue.equalTo(innerContentSize)
      {
        innerContentSize = newValue
        self.spriteToScroll?.size = newValue
        self.spriteForScrollingGeometry?.size = newValue
        self.spriteForScrollingGeometry?.position = CGPoint.zero
        updateConstrainedScrollerSize()
      }
    }
  }
  
  var innerContentOffset: CGPoint = CGPoint.zero
  public var contentOffset: CGPoint
  {
    get
    {
      return innerContentOffset
    }
    set
    {
      if !newValue.equalTo(innerContentOffset)
      {
        innerContentOffset = newValue
        contentOffsetReload()
      }
    }
  }
  
  func contentOffsetReload()
  {
    self.spriteToScroll?.position = CGPoint(x: -innerContentOffset.x, y: -innerContentOffset.y)
    
    if let spriteForScrollingGeometry = self.spriteForScrollingGeometry,
      let spriteToHostHorizontalAndVerticalScrolling = self.spriteToHostHorizontalAndVerticalScrolling,
      let spriteForHorizontalScrolling = self.spriteForHorizontalScrolling,
      let spriteForVerticalScrolling = self.spriteForVerticalScrolling
    {
      let scrollingLowerLeft = spriteForScrollingGeometry.convert(CGPoint.zero, to: spriteToHostHorizontalAndVerticalScrolling)
      
      var horizontalScrollingPosition = spriteForHorizontalScrolling.position
      horizontalScrollingPosition.y = scrollingLowerLeft.y
      spriteForHorizontalScrolling.position = horizontalScrollingPosition
      
      var verticalScrollingPosition = spriteForVerticalScrolling.position
      verticalScrollingPosition.x = scrollingLowerLeft.x
      spriteForVerticalScrolling.position = verticalScrollingPosition
    }
  }
  
  //kIIMySceneZPositionScrolling
  weak var spriteToScroll: SKSpriteNode?
  weak var spriteForScrollingGeometry: SKSpriteNode?
  
  //kIIMySceneZPositionStatic
  weak var spriteForStaticGeometry: SKSpriteNode?
  
  // ZPosition VerticalAndHorizontalScrolling
  weak var spriteToHostHorizontalAndVerticalScrolling: SKSpriteNode?
  weak var spriteForHorizontalScrolling: SKSpriteNode?
  weak var spriteForVerticalScrolling: SKSpriteNode?
  
  
  override init(size: CGSize)
  {
    super.init(size: size)
    
    self.anchorPoint = CGPoint.zero
    
    let spriteToScroll = SKSpriteNode(color: SKColor.clear, size: size)
    spriteToScroll.anchorPoint = CGPoint.zero
    spriteToScroll.zPosition = CGFloat(IIMySceneZPosition.Scrolling.rawValue)
    self.addChild(spriteToScroll)
    
    //Overlay sprite to make anchor point 0,0 (lower left, default for SK)
    let spriteForScrollingGeometry = SKSpriteNode(color: SKColor.clear, size: size)
    spriteForScrollingGeometry.anchorPoint = CGPoint.zero
    spriteForScrollingGeometry.position = CGPoint.zero
    spriteForScrollingGeometry.zPosition = CGFloat(IIMySceneZPosition.Scrolling.rawValue)
    spriteToScroll.addChild(spriteForScrollingGeometry)
    
    let spriteForStaticGeometry = SKSpriteNode(color: SKColor.clear, size: size)
    spriteForStaticGeometry.anchorPoint = CGPoint.zero
    spriteForStaticGeometry.position = CGPoint.zero
    spriteForStaticGeometry.zPosition = CGFloat(IIMySceneZPosition.Static.rawValue)
    self.addChild(spriteForStaticGeometry)
    
    let spriteToHostHorizontalAndVerticalScrolling = SKSpriteNode(color: SKColor.clear, size: size)
    spriteToHostHorizontalAndVerticalScrolling.anchorPoint = CGPoint.zero
    spriteToHostHorizontalAndVerticalScrolling.position = CGPoint.zero
    spriteToHostHorizontalAndVerticalScrolling.zPosition = CGFloat(IIMySceneZPosition.VerticalAndHorizontalScrolling.rawValue)
    self.addChild(spriteToHostHorizontalAndVerticalScrolling)
    
    var upAndDownSize = size
    upAndDownSize.width = 30
    let spriteForVerticalScrolling = SKSpriteNode(color: SKColor.clear, size: upAndDownSize)
    spriteForVerticalScrolling.anchorPoint = CGPoint.zero
    spriteForVerticalScrolling.position = CGPoint(x: 0, y: 10)
    spriteToHostHorizontalAndVerticalScrolling.addChild(spriteForVerticalScrolling)
    
    var leftToRightSize = size
    leftToRightSize.height = 30
    let spriteForHorizontalScrolling = SKSpriteNode(color: SKColor.clear, size: leftToRightSize)
    spriteForHorizontalScrolling.anchorPoint = CGPoint.zero
    spriteForHorizontalScrolling.position = CGPoint(x: 10, y: 0)
    spriteToHostHorizontalAndVerticalScrolling.addChild(spriteForHorizontalScrolling)
    
    //Test sprites for constrained Scrolling
    var labelPosition = CGFloat(model.xMin)
    var stepSize = CGFloat(model.hX)
    while labelPosition <= CGFloat(model.xMax)
    {
      let labelText = String(format: "%5.0f", labelPosition)
      
      let scrollingLabel = SKLabelNode(fontNamed: "HelveticaNeue")
      scrollingLabel.text = labelText
      scrollingLabel.fontSize = 14
      scrollingLabel.fontColor = SKColor.white
      scrollingLabel.position = CGPoint(x: labelPosition, y: 0)
      scrollingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
      spriteForVerticalScrolling.addChild(scrollingLabel)
      
      labelPosition += stepSize
    }
    
    labelPosition = CGFloat(model.yMin)
    stepSize = CGFloat(model.hY)
    while labelPosition <= CGFloat(model.yMax)
    {
      let labelText = String(format: "%5.0f", labelPosition)
      
      let hscrollingLabel = SKLabelNode(fontNamed: "HelveticaNeue")
      hscrollingLabel.text = labelText
      hscrollingLabel.fontSize = 14
      hscrollingLabel.fontColor = SKColor.white
      hscrollingLabel.position = CGPoint(x: 0, y: labelPosition)
      hscrollingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
      spriteForHorizontalScrolling.addChild(hscrollingLabel)
      
      labelPosition += stepSize
    }
    
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
      shapeNode.fillTexture = shapeTexture
      spriteForScrollingGeometry.addChild(shapeNode)
    }
    
    //Set properties
    self.contentSize = size
    self.spriteToScroll = spriteToScroll
    self.spriteForScrollingGeometry = spriteForScrollingGeometry
    self.spriteForStaticGeometry = spriteForStaticGeometry
    self.spriteToHostHorizontalAndVerticalScrolling = spriteToHostHorizontalAndVerticalScrolling
    self.spriteForVerticalScrolling = spriteForVerticalScrolling
    self.spriteForHorizontalScrolling = spriteForHorizontalScrolling
    self.contentOffset = CGPoint.zero
  }
  
  required public init?(coder aDecoder: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func didChangeSize(_ oldSize: CGSize)
  {
    let size = self.size
    
    self.spriteForStaticGeometry?.size = size
    self.spriteForStaticGeometry?.position = CGPoint.zero
    
    self.spriteToHostHorizontalAndVerticalScrolling?.size = size
    self.spriteToHostHorizontalAndVerticalScrolling?.position = CGPoint.zero
  }
  
  func setContentScale(scale: CGFloat)
  {
    spriteToScroll?.setScale(scale)
    updateConstrainedScrollerSize()
  }
  
  func updateConstrainedScrollerSize()
  {
    let contentSize: CGSize = self.contentSize
    
    var verticalSpriteSize: CGSize = self.spriteForVerticalScrolling?.size ?? CGSize.zero
    verticalSpriteSize.height = contentSize.height
    spriteForVerticalScrolling?.size = verticalSpriteSize
    
    var horizontalSpriteSize = self.spriteForHorizontalScrolling?.size ?? CGSize.zero
    horizontalSpriteSize.width = contentSize.width
    spriteForHorizontalScrolling?.size = horizontalSpriteSize
    
    let xScale = spriteToScroll?.xScale ?? 1.0
    let yScale = spriteToScroll?.yScale ?? 1.0
    
    spriteForVerticalScrolling?.xScale = xScale
    spriteForVerticalScrolling?.yScale = yScale
    
    spriteForHorizontalScrolling?.xScale = xScale
    spriteForHorizontalScrolling?.yScale = yScale
    
    let xScaleReciprocal = 1.0 / xScale
    let yScaleReciprocal = 1.0 / yScale
    for node in spriteForVerticalScrolling?.children ?? []
    {
      node.xScale = xScaleReciprocal
      node.yScale = yScaleReciprocal
    }
    
    for node in spriteForHorizontalScrolling?.children ?? []
    {
      node.xScale = xScaleReciprocal
      node.yScale = yScaleReciprocal
    }
    
    contentOffsetReload()
  }
  
  override func didMove(to view: SKView)
  {
    
  }
}

