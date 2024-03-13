//
//  Modal.swift
//  DOT
//
//  Created by Martin Nava on 12/03/24.
//

import Foundation

class Modal: ObservableObject {
    @Published public var show: Bool = false
    @Published public var title: String = ""
    @Published public var text: String = ""
    @Published public var btnLabel: String = ""
    
    public func setModal(_title: String, _text: String, _btnLabel: String) {
        self.show = true
        self.title = _title
        self.text = _text
        self.btnLabel = _btnLabel
    }
}
