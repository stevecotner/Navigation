//
//  Run.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import Foundation

struct Run: Identifiable, Equatable {
    let id: UUID = UUID()
    let distance: Double
    let start: Date
    let end: Date
}
