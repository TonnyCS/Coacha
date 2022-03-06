//
//  MapHelper.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import MapKit
import SwiftUI

final class MapHelper: ObservableObject {
    @Published var showingLoadingForLocationSearch: Bool = false
    @Published var places: [Place] = []
    
    func searchForLocation(text: String) {
        withAnimation {
            self.showingLoadingForLocationSearch = true
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        
        MKLocalSearch(request: request).start { response, _ in
            withAnimation {
                self.showingLoadingForLocationSearch = false
            }
            
            guard let response = response else { return }
            
            withAnimation {
                self.places = response.mapItems.compactMap({ item -> Place? in
                    return Place(place: item.placemark)
                })
            }
        }
    }
}
