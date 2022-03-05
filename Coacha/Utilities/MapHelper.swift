//
//  MapHelper.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import MapKit

final class MapHelper: ObservableObject {
    @Published var places: [Place] = []
    
    func searchForLocation(text: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        
        MKLocalSearch(request: request).start { response, _ in
            guard let response = response else { return }
            
            self.places = response.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
}
