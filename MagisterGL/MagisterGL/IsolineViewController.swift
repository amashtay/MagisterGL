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
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
    let element = RectangleElement(startPoint: CGPoint.zero,
                                   size: CGSize(width: 100,
                                                height: 100))
    let element2 = RectangleElement(startPoint: CGPoint(x: 100,
                                                        y: 100),
                                    size: CGSize(width: 100,
                                                 height: 100))
    let elementsArray = [element,
                         element2]
    isolineView.elementsArray = elementsArray
    
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    
  }
  
}
