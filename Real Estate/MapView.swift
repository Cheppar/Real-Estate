//
//  MapView.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapController: MapController
    
    var body: some View {
        Map(coordinateRegion: $mapController.region, annotationItems: mapController.business){
            business in
            MapAnnotation(coordinate: business.coordinate) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.title)
                    .foregroundColor(.pink)
                    .onTapGesture {
                    mapController.setSelectedBusiness(for: business)
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $mapController.isBusinessViewShowing) {
            BusinessView(mapController: mapController)
                .presentationDetents([.fraction(0.27), .large])
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapController: MapController())
    }
}
