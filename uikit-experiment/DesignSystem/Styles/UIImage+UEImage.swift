//
//  UIImage+UEImage.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 22/04/24.
//

import UIKit

extension UIImage {
    static func image(_ ueImage: UEImage) -> UIImage? {
        resource(ueImage)
    }
    
    static func resource(_ resource: UEImageResource) -> UIImage? {
        UIImage(named: resource.imageName)
    }
}
