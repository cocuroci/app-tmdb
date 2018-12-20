//
//  Service+Utils.swift
//  TMDB
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

func jsonSerializedUTF8(json: [String: Any]) -> Data {
    do {
        return try JSONSerialization.data(
            withJSONObject: json,
            options: [.prettyPrinted]
        )
    } catch {
        return Data()
    }
}
