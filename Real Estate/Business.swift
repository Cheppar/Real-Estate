//
//  Business.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import Foundation
import MapKit

struct Business: Identifiable {
    let id = UUID()
    let name: String
    let placemark: MKPlacemark
    let coordinate: CLLocationCoordinate2D
    let phoneNumber: String
    let website: URL?
}
