//
//  CustomTransitioning.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class CustomTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let reverse: Bool
    
    init(duration: TimeInterval = 0.5, reverse: Bool = false) {
        self.duration = duration
        self.reverse = reverse
    }
    
    class func transitionOptions(reverse: Bool) -> UIView.AnimationOptions {
        [.curveEaseInOut]
    }
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toView)
        
        UIView.transition(from: fromView, to: toView, duration: duration, options: Self.transitionOptions(reverse: reverse)) { complete in
            if complete {
                transitionContext.completeTransition(complete)
            }
        }
    }
}
