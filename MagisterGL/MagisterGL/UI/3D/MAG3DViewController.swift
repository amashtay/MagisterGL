//
//  MAG3DViewController.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 26.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SceneKit


class MAG3DViewController: UIViewController, UIPopoverPresentationControllerDelegate

{
  
    @IBOutlet weak var customGeometryView: MAGCustomGeometryView!
    
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
  }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        super.prepare(for: segue,
                      sender: sender)
        if segue.destination.isKind(of: MAGChooseFileViewController.self)
        {
            segue.destination.popoverPresentationController?.delegate = self;
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController)
    {
        self.customGeometryView.redraw()
    }
}
