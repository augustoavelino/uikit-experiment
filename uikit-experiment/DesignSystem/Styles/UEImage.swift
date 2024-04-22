//
//  UEImage.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 22/04/24.
//

import Foundation

protocol UEImageResource {
    var imageName: String { get }
}

enum UEImage: UEImageResource {
    case background(Background)
    
    var imageName: String {
        switch self {
        case .background(let background): background.imageName
        }
    }
}

extension UEImage {
    enum Background: String, CaseIterable, UEImageResource {
        case random1 = "random-01"
        case random2 = "random-02"
        case random3 = "random-03"
        case random4 = "random-04"
        case random5 = "random-05"
        case random6 = "random-06"
        
        var imageName: String { "background/\(rawValue)" }
    }
}
