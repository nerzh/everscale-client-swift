//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 04.12.2020.
//

import Foundation

public extension Dictionary {

    func toAnyValue() -> AnyValue {
        EverscaleClientSwift.toAnyValue(self)
    }
}
