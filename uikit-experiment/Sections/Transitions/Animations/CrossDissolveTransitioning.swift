//
//  CrossDissolveTransitioning.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class CrossDissolveTransitioning: CustomTransitioning {
    override class func transitionOptions(reverse: Bool) -> UIView.AnimationOptions {
        return [.transitionCrossDissolve, .showHideTransitionViews, .curveEaseInOut]
    }
}
