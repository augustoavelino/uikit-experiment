//
//  FlipTransitioning.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class FlipTransitioning: CustomTransitioning {
    override class func transitionOptions(reverse: Bool) -> UIView.AnimationOptions {
        let flipOption: UIView.AnimationOptions = reverse ? .transitionFlipFromLeft : .transitionFlipFromRight
        return [flipOption, .showHideTransitionViews, .curveEaseInOut]
    }
}
