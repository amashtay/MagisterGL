//
//  SKTexture+Gradient.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 23.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import SpriteKit


enum GradientDirection
{
  case up
  case left
  case upLeft
  case upRight
}

extension SKTexture
{
  convenience init(size: CGSize,
                   topColorLeft: CIColor,
                   topColorRight: CIColor,
                   bottomColorLeft: CIColor,
                   bottomColorRight: CIColor)
  {
    UIGraphicsBeginImageContext(size)
    let currentContext = UIGraphicsGetCurrentContext()
    
    currentContext!.saveGState();
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let col1: [CGFloat] = [topColorLeft.components[0], topColorLeft.components[1], topColorLeft.components[2], topColorLeft.components[3],
                           bottomColorRight.components[0], bottomColorRight.components[1], bottomColorRight.components[2], bottomColorRight.components[3]]
    let grad1 = CGGradient(colorSpace: colorSpace, colorComponents: col1, locations: nil, count: 2)
    currentContext?.drawLinearGradient(grad1!,
                                       start: CGPoint(x: 0, y: 0),
                                       end: CGPoint(x: size.width, y: size.height),
                                       options: [])
    let col2: [CGFloat] = [bottomColorLeft.components[0], bottomColorLeft.components[1], bottomColorLeft.components[2], bottomColorLeft.components[3],
                           topColorRight.components[0], topColorRight.components[1], topColorRight.components[2], topColorRight.components[3]]
    let grad2 = CGGradient(colorSpace: colorSpace, colorComponents: col2, locations: nil, count: 2)
    currentContext?.drawLinearGradient(grad2!,
                                       start: CGPoint(x: 0, y: size.height),
                                       end: CGPoint(x: size.width, y: 0),
                                       options: [])
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    let cgImage = image?.cgImage
    
    self.init(cgImage: cgImage!)
  }
  
  //Пока оставлю - не используется
  convenience init(size: CGSize,
                   color1: CIColor,
                   color2: CIColor,
                   direction:GradientDirection = .up)
  {
    let coreImageContext = CIContext(options: nil)
    let gradientFilter = CIFilter(name: "CILinearGradient")
    gradientFilter!.setDefaults()
    var startVector: CIVector
    var endVector: CIVector
    switch direction
    {
    case .up:
      startVector = CIVector(x: size.width/2, y: 0)
      endVector = CIVector(x: size.width/2, y: size.height)
    case .left:
      startVector = CIVector(x: size.width, y: size.height/2)
      endVector = CIVector(x: 0, y: size.height/2)
    case .upLeft:
      startVector = CIVector(x: size.width, y: 0)
      endVector = CIVector(x: 0, y: size.height)
    case .upRight:
      startVector = CIVector(x: 0, y: 0)
      endVector = CIVector(x: size.width, y: size.height)
    }
    gradientFilter!.setValue(startVector, forKey: "inputPoint0")
    gradientFilter!.setValue(endVector, forKey: "inputPoint1")
    gradientFilter!.setValue(color1, forKey: "inputColor0")
    gradientFilter!.setValue(color2, forKey: "inputColor1")
    let cgimg = coreImageContext.createCGImage(gradientFilter!.outputImage!, from: CGRect(x: 0,
                                                                                          y: 0,
                                                                                          width: size.width,
                                                                                          height: size.height))
    self.init(cgImage: cgimg!)
  }
}
