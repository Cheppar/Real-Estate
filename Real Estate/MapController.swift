//
//  MapController.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import MapKit

class MapController: ObservableObject {
    var searchTerm = String()
    @Published var isBusinessViewShowing = false
    //create an empty array of businesses displayed dto the user.
    //private means the property can only be read from outside. and we will only read businesses  but we won't be able to assign or set any properties on that business.
    @Published private(set) var business = [Business]()
    @Published private (set) var selectedBusiness: Business?
    @Published private (set) var actions = [Action]()
    
    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321),
        latitudinalMeters: 1600,
        longitudinalMeters: 1600)
    
    var selectBusinessName: String {
        //checks if business is seleccted else return null
        guard let selecctBusiness = selectedBusiness else {return ""}
        return selectedBusiness.name
    }
    
    var selectBusinessPlacemark: String {
        //checks if business placemark is seleccted else return null
        guard let selecctBusiness = selectedBusiness else {return ""}
        return selectedBusiness.placemark.title ?? "??"
    }
}
