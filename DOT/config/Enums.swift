//
//  Enums.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import Foundation
import SwiftUI

enum BtnType {
    case primary
    case secondary
    
    var color: Color {
        switch self {
        case .primary:
            return Color.AppColors.main
        case .secondary:
            return Color.AppColors.contrast
        }
    }
}

enum ModalAlign {
    case top
    case center
    case bottom
}
