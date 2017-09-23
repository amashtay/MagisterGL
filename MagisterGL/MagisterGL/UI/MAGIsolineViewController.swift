//
//  MAGIsolineViewController.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 23.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SpriteKit


class MAGIsolineViewController: UIViewController
{
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    let scene = MAGIsolineScene(size: self.view.bounds.size)
    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    skView.presentScene(scene)    
  }
  
}
