//
//  Status.swift
//  GainzTrack
//
//  Created by Luis Quintero on 20/08/25.
//

import Foundation

enum Status: Equatable {
    case none, loading, loaded, error(error: String)
}
