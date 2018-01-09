//
//  ViewController.swift
//  ReplicatorLayers
//
//  Created by Bomi on 2018/1/9.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = view.frame.size
        replicatorLayer.masksToBounds = true
        view.layer.addSublayer(replicatorLayer)
        
        
        //sublayer
        let image = #imageLiteral(resourceName: "testImage")
        let imageLayer = CALayer()
        imageLayer.contents = image.cgImage
        imageLayer.frame.size = image.size
        replicatorLayer.addSublayer(imageLayer)
        
        let instanceCount = view.frame.width / image.size.width
        replicatorLayer.instanceCount = Int(ceil(instanceCount))
        
        //transform
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            image.size.width, 0, 0
        )
        
        // Reduce the red & green color component of each instance,
        // effectively making each copy more and more blue
        let redColorOffset = -0.2 / Float(replicatorLayer.instanceCount)
        let greenColorOffset = -0.2 / Float(replicatorLayer.instanceCount)
        let blueColorOffset = -0.8 / Float(replicatorLayer.instanceCount)
        
        replicatorLayer.instanceRedOffset = redColorOffset
        replicatorLayer.instanceGreenOffset = greenColorOffset
        
        let verticalReplicatorLayer = CAReplicatorLayer()
        verticalReplicatorLayer.frame.size = view.frame.size
        verticalReplicatorLayer.masksToBounds = true
        verticalReplicatorLayer.instanceBlueOffset = blueColorOffset
        view.layer.addSublayer(verticalReplicatorLayer)
        
        let verticalInstanceCount = view.frame.height / image.size.height
        verticalReplicatorLayer.instanceCount = Int(ceil(verticalInstanceCount))
        
        verticalReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            0, image.size.height/1.05, 0
        )
        
        verticalReplicatorLayer.addSublayer(replicatorLayer)
        
        let delay = TimeInterval(0.1)
        replicatorLayer.instanceDelay = delay
        verticalReplicatorLayer.instanceDelay = delay
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 2
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.autoreverses = true
        animation.repeatCount = .infinity
        imageLayer.add(animation, forKey: "hypnoscale")
    }

}

