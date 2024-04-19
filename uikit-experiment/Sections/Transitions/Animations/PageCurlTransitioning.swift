//
//  PageCurlTransitioning.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class PageCurlTransitioning: CustomTransitioning {
    override class func transitionOptions(reverse: Bool) -> UIView.AnimationOptions {
        let flipOption: UIView.AnimationOptions = reverse ? .transitionCurlDown : .transitionCurlUp
        return [flipOption, .showHideTransitionViews, .curveEaseInOut]
    }
}
