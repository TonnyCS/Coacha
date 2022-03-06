//
//  MapHelper.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import MapKit
import SwiftUI

class MapHelper: ObservableObject {
    func searchForLocation(text: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        
        MKLocalSearch(request: request).start { response, _ in
            guard let response = response else {
                completion(.failure(ErrorWithCustomMessage(msg: "Failed to parse response")))
                return
            }
            
            let places = response.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
            
            completion(.success(places))
        }
    }
}
