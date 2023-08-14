//
//  Action.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import Foundation

struct Action: Identifiable {
    let id =  UUID()
    let title: String
    let image: String
    // this is a handler. it's a closure or anonymous function that gets executed when the action is performed.
    let handler: () -> Void
}
