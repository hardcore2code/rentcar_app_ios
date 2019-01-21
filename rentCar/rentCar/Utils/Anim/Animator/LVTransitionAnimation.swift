//
//  STransitionAnimation.swift
//  rentCar
//
//  Created by Static on 2019/1/15.
//  Copyright © 2019 Static1014. All rights reserved.
//

import UIKit

protocol LVTransitionAnimationDelegate {
    func animateAction(transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval)
}

class LVTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval = 1
    var delegate: LVTransitionAnimationDelegate?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        delegate?.animateAction(transitionContext: transitionContext, duration: duration)
    }
}

