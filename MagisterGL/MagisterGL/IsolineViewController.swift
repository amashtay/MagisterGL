//
//  IsolineViewController.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//

import UIKit

class IsolineViewController: UIViewController
{
  @IBOutlet weak var isolineView: IsolineView!
  
  
  private let kCountOfColorAreas: Int = 7
  var rainbow = [Color]()
  
  func generateColors(minValue: Double, maxValue: Double)
  {
    rainbow = [Color]()
    let hValues: Double = (maxValue - minValue) / Double(kCountOfColorAreas - 1)
    for i in 0..<kCountOfColorAreas
    {
      let color = Color()
      color.value = minValue + Double(i) * hValues
      rainbow.append(color)
    }
    
    let colorRedMin: Double = 0
    let colorGreenMin: Double = 5
    let colorBlueMin: Double = 255
    
    let colorRedMax: Double = 0
    let colorGreenMax: Double = 255
    let colorBlueMax: Double = 25
    
    rainbow[kCountOfColorAreas - 1].red = colorRedMax
    rainbow[kCountOfColorAreas - 1].green = colorGreenMax
    rainbow[kCountOfColorAreas - 1].blue = colorBlueMax
    
    let colorRedH: Double = (colorRedMax - colorRedMin) / Double(kCountOfColorAreas - 1)
    let colorGreenH: Double = (colorGreenMax - colorGreenMin) / Double(kCountOfColorAreas - 1)
    let colorBlueH: Double = (colorBlueMax - colorBlueMin) / Double(kCountOfColorAreas - 1)
    for i in 0..<kCountOfColorAreas
    {
      rainbow[i].red = colorRedMin + Double(i) * colorRedH
      rainbow[i].green = colorGreenMin + Double(i) * colorGreenH
      rainbow[i].blue = colorBlueMin + Double(i) * colorBlueH
    }
  }
  
  func uFunc(x: Double,
             y: Double) -> Double
  {
    return x / (y + 100)
  }
  
  func getColorForU(u: Double) -> UIColor
  {
    var i = 0
    while i < kCountOfColorAreas - 1 && u >= rainbow[i + 1].value
    {
      i += 1
    }
    return rainbow[i].color;
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    let xMin = 0.0
    let yMin = 0.0
    
    let xMax = 500.0
    let yMax = 800.0
    
    let hX = 100.0
    let hY = 100.0
    
    generateColors(minValue: uFunc(x: xMin, y: yMin),
                   maxValue: uFunc(x: xMax, y: yMax))
    
    var elementsArray : [RectangleElement] = [RectangleElement]()
    
    var xArray : [NSNumber] = [NSNumber]()
    var x = xMin
    while x <= xMax
    {
      xArray.append(NSNumber(value: x))
      x += hX
    }
    
    var yArray : [NSNumber] = [NSNumber]()
    var y = yMin
    while y <= yMax
    {
      yArray.append(NSNumber(value: y))
      y += hY
    }
    
    for x in xArray
    {
      for y in yArray
      {
        let element = RectangleElement(startPoint: CGPoint(x: x.doubleValue,
                                                           y: y.doubleValue),
                                       size: CGSize(width: hX,
                                                    height: hY))
        element.topColorLeft = getColorForU(u: uFunc(x: Double(truncating: x), y: Double(truncating: y)))
        element.topColorRight = getColorForU(u: uFunc(x: Double(truncating: x) + hX, y: Double(truncating: y)))
        element.bottomColorLeft = getColorForU(u: uFunc(x: Double(truncating: x), y: Double(truncating: y) + hY))
        element.bottomColorRight = getColorForU(u: uFunc(x: Double(truncating: x) + hX, y: Double(truncating: y) + hY))
        elementsArray.append(element)
        
      }
    }
    isolineView.elementsArray = elementsArray
    
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    
  }
  
}
