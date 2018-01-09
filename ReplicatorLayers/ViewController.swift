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
        
        //init replicatorLayer
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = view.frame.size
        replicatorLayer.masksToBounds = true
//        view.layer.addSublayer(replicatorLayer)
        
        //add image to replicatorLayer
        let image = #imageLiteral(resourceName: "testImage")
        let imageLayer = CALayer()
        imageLayer.contents = image.cgImage
        imageLayer.frame.size = image.size
        imageLayer.transform = CATransform3DMakeScale(1, 0, 0)
        replicatorLayer.addSublayer(imageLayer)
        
        //replicatorLayer horizontal count
        let instanceHorizontalCount = view.frame.width / image.size.width * 2.5
        replicatorLayer.instanceCount = Int(ceil(instanceHorizontalCount))
        
        //replicatorLayer transform for width
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            imageLayer.frame.width/3, 0, 0
        )
        
        // Reduce the r,g,b color component of each instance,
        let redColorOffset = -0.2 / Float(replicatorLayer.instanceCount)
        let greenColorOffset = -0.2 / Float(replicatorLayer.instanceCount)
        let blueColorOffset = -0.8 / Float(replicatorLayer.instanceCount)
        
        replicatorLayer.instanceRedOffset = redColorOffset
        replicatorLayer.instanceGreenOffset = greenColorOffset
        
        //init vertical replicatorLayer
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
        
        // delay
        let delay = 0.05
        replicatorLayer.instanceDelay = TimeInterval(delay)
        verticalReplicatorLayer.instanceDelay = TimeInterval(delay * Double(replicatorLayer.instanceCount))
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = delay * Double(replicatorLayer.instanceCount) * Double(verticalReplicatorLayer.instanceCount)
        animation.fromValue = 1
        animation.toValue = 0.7
        animation.autoreverses = false
        animation.repeatCount = .infinity
        imageLayer.add(animation, forKey: "hypnoscale")
    }

}

