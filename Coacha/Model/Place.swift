//
//  Place.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import MapKit

struct Place: Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark
}
