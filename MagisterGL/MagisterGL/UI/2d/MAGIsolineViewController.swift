//
//  MAGIsolineViewController.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 23.09.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import UIKit
import SpriteKit


typealias KVOContext = UInt8
var ViewTransformChangedObservationContext = KVOContext()


class MAGIsolineViewController: UIViewController, UIScrollViewDelegate
{
  weak var scene: MAGScene?
  weak var clearContentView: UIView?
  weak var scrollView: UIScrollView?

  //MARK: Ovverrides
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    // Configure the view.
    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    
    // Create and configure the scene.
    let scene = MAGScene(size: skView.bounds.size)
    scene.scaleMode = .resizeFill
    
    // Present the scene.
    skView.presentScene(scene)
    self.scene = scene
    
    let contentSize = scene.contentSize
    
    let scrollView = UIScrollView(frame: CGRect.zero)
    scrollView.contentSize = contentSize
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1
    scrollView.maximumZoomScale = 30
    scrollView.indicatorStyle = .white
    self.scrollView = scrollView
    
    let clearContentView = UIView(frame: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
    clearContentView.backgroundColor = UIColor.clear
    scrollView.addSubview(clearContentView)
    self.clearContentView = clearContentView
    
    clearContentView.addObserver(self,
                                 forKeyPath: "transform",
                                 options: .new,
                                 context: &ViewTransformChangedObservationContext)
    skView.addSubview(scrollView)
  }
  
  
  override func viewWillLayoutSubviews()
  {
    super.viewWillLayoutSubviews()
    scrollView?.frame = view.bounds
    scene?.size = view.bounds.size
    if let scrollView = scrollView
    {
      adjustContent(scrollView: scrollView)
    }
  }
  
  //MARK: Internal methods
  
  private func adjustContent(scrollView: UIScrollView)
  {
    let zoomScale = scrollView.zoomScale
    scene?.setContentScale(scale: zoomScale)
    let contentOffset = scrollView.contentOffset
    let contentSize = scrollView.contentSize
    let scrollAreaHeight: CGFloat = contentSize.height - scrollView.bounds.height
    let yUIKit: CGFloat = contentOffset.y
    
    // Convert from UIKit coordinates to SpriteKit coordinates
    // UIKit has 0,0 in the top-left corner
    // SpriteKit has 0,0 in the bottom-left corner
    let ySpriteKit = scrollAreaHeight - yUIKit
    let contentOffsetSpriteKit = CGPoint(x: contentOffset.x, y: ySpriteKit)
    scene?.contentOffset = contentOffsetSpriteKit
  }
  
  //MARK: Scroll view delegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView)
  {
    adjustContent(scrollView: scrollView)
  }
  
  func scrollViewDidTransform(scrollView: UIScrollView)
  {
    adjustContent(scrollView: scrollView)
  }
  
  // scale between minimum and maximum. called after any 'bounce' animations
  func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                               with view: UIView?,
                               atScale scale: CGFloat)
  {
    adjustContent(scrollView: scrollView)
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView)
  {
    adjustContent(scrollView: scrollView)
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView?
  {
    return clearContentView
  }
  
  // MARK: KVO
  override open func observeValue(forKeyPath keyPath: String?,
                                  of object: Any?,
                                  change: [NSKeyValueChangeKey : Any]?,
                                  context: UnsafeMutableRawPointer?)
  {
    if context == &ViewTransformChangedObservationContext
    {
      if let view = object as? UIView, let scrollView = view.superview as? UIScrollView
      {
        scrollViewDidTransform(scrollView: scrollView)
        return
      }
    }
    super.observeValue(forKeyPath: keyPath,
                       of: object,
                       change: change,
                       context: context)
  }
  
  deinit
  {
    clearContentView?.removeObserver(self,
                                     forKeyPath: "transform",
                                     context: &ViewTransformChangedObservationContext)
  }
}
