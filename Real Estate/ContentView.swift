//
//  ContentView.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var mapController = MapController()
    
    var body: some View {
        NavigationStack {
            MapView (mapController: mapController)
        }
        .searchable(text: $mapController.searchTerm)
        .onSubmit (of: .search) {
            mapController.search()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
