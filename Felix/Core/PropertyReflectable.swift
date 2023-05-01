//
//  PropertyReflectable.swift
//  Felix
//
//  Created by Alexey Sigay on 27.04.2023.
//

import Foundation

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        for child in m.children {
            if child.label == key { return child.value }
        }
        return nil
    }
}
