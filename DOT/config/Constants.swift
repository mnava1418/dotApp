//
//  Constants.swift
//  DOT
//
//  Created by Martin Nava on 21/03/24.
//

import Foundation

struct Constants {
    struct View {
        static let cornerRadius = 20.0
    }    
    
    struct Endpoints {
        struct AutService {
            static let DOMAIN = "http://localhost:4041"
            static let REQUEST_CODE = "/auth/users/requestCode"
            static let REGISTER_USER = "/auth/users/register"
        }
    }
}
