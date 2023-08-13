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
        guard let selectedBusiness = selectedBusiness else {return ""}
        return selectedBusiness.name
    }
    
    var selectBusinessPlacemark: String {
        //checks if business placemark is seleccted else return null
        guard let selectedBusiness = selectedBusiness else {return ""}
        return selectedBusiness.placemark.title ?? "??"
    }
    
    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                self.business = response.mapItems.map { item in
                    Business(name: item.name ?? "",
                             placemark: item.placemark,
                             coordinate: item.placemark.coordinate,
                             phoneNumber: item.phoneNumber ?? "",
                             website: item.url)
                    
                }
            }
        }
        createActions()
    }
    
    func openMap(coordinate: CLLocationCoordinate2D){
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps()
    }
    
    func setSelectedBusiness (for business: Business) {
        selectedBusiness = business
        isBusinessViewShowing.toggle()
    }
    
    func createActions() {
       actions = [
        Action(title: "Directions", image: "car.fill") {[weak self] in
            guard let self = self else { return }
            self.openMap(coordinate: self.selectedBusiness!.coordinate)
        },
        Action(title: "Call", image: "phone.fill") {[weak self] in
            guard let self = self else { return }
            guard let phoneNumber = self.selectedBusiness?.phoneNumber else {return}
            guard let url = URL(string: self.convertPhoneNumberFormat(phoneNumber: phoneNumber)) else {return}
            UIApplication.shared.open(url)
        },
        Action(title: "Website", image: "safari.fill") {[weak self] in
            guard let self = self else { return }
            guard let website = self.selectedBusiness?.website else {return}
            UIApplication.shared.open(website)
        }
       ]
    }
    
    func convertPhoneNumberFormat (phoneNumber: String) -> String {
        let strippedPhoneNumber = phoneNumber
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        
        return "tel//\(strippedPhoneNumber)"
    }
}
