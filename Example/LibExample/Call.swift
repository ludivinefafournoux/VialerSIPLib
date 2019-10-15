//
//  File.swift
//  LibExample
//
//  Created by Manuel on 14/10/2019.
//  Copyright © 2019 Harold. All rights reserved.
//

import Foundation

struct Call {
    let uuid = UUID()
}

extension Call: Equatable {
    static func == (
        lhs: Call,
        rhs: Call
    ) -> Bool
    {
        return lhs.uuid == rhs.uuid
    }
}
