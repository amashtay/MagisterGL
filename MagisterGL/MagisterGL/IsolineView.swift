//
//  IsolineView.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit


class IsolineView: UIView
{
  var elementsArray: [RectangleElement] = []
  
  
  override func draw(_ rect: CGRect)
  {
    super.draw(rect)
    
    for rectangleElement in elementsArray
    {
      let squareFrame = CGRect(origin: rectangleElement.startPoint,
                               size: rectangleElement.size)
      let topColor1 = rectangleElement.topColor1
      let topColor2 = rectangleElement.topColor2
      let bottomColor1 = rectangleElement.bottomColor1
      let bottomColor2 = rectangleElement.bottomColor2
      
      let gradientColors: Array <AnyObject> = [topColor1.cgColor, UIColor.clear.cgColor]
      let gradientLocations: Array <AnyObject> = [0.0 as AnyObject, 1.0 as AnyObject]
      let gradientLayer: CAGradientLayer = CAGradientLayer()
      gradientLayer.colors = gradientColors
      gradientLayer.locations = gradientLocations as? [NSNumber]
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    
      let gradientColors2: Array <AnyObject> = [bottomColor1.cgColor, UIColor.clear.cgColor]
      let gradientLayer2: CAGradientLayer = CAGradientLayer()
      gradientLayer2.colors = gradientColors2
      gradientLayer2.locations = gradientLocations as? [NSNumber]
      gradientLayer2.startPoint = CGPoint(x: 0.0, y: 1.0)
      gradientLayer2.endPoint = CGPoint(x: 1.0, y: 0.0)
      
      
      let gradientColors3: Array <AnyObject> = [UIColor.clear.cgColor, topColor2.cgColor]
      let gradientLayer3: CAGradientLayer = CAGradientLayer()
      gradientLayer3.colors = gradientColors3
      gradientLayer3.locations = gradientLocations as? [NSNumber]
      gradientLayer3.startPoint = CGPoint(x: 0.0, y: 1.0)
      gradientLayer3.endPoint = CGPoint(x: 1.0, y: 0.0)
      
      let gradientColors4: Array <AnyObject> = [UIColor.clear.cgColor, bottomColor2.cgColor]
      let gradientLayer4: CAGradientLayer = CAGradientLayer()
      gradientLayer4.colors = gradientColors4
      gradientLayer4.locations = gradientLocations as? [NSNumber]
      gradientLayer4.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer4.endPoint = CGPoint(x: 1.0, y: 1.0)
      
      gradientLayer.frame = squareFrame
      gradientLayer2.frame = squareFrame
      gradientLayer3.frame = squareFrame
      gradientLayer4.frame = squareFrame
      layer.addSublayer(gradientLayer)
      layer.addSublayer(gradientLayer2)
      layer.addSublayer(gradientLayer3)
      layer.addSublayer(gradientLayer4)
    }
    
    for rectangleElement in elementsArray
    {      
      let color: UIColor = UIColor.black
      
      let drect = CGRect(origin: rectangleElement.startPoint,
                         size: rectangleElement.size)
      let bpath: UIBezierPath = UIBezierPath(rect: drect)
      
      color.set()
      bpath.stroke()
    }
  }
  
}
