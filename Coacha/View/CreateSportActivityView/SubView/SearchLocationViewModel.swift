//
//  SearchLocationViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import SwiftUI
import Combine
import MapKit
import Intents

final class SearchLocationViewModel: ObservableObject {
    var viewDismissalModePublished = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    
    @ObservedObject var mapHelper: MapHelper = MapHelper()
    
    @Binding var selectedPlace: Place?
    @Published var searchText: String = ""
    
    init(selectedPlace: Binding<Place?>) {
        self._selectedPlace = selectedPlace
        
        cancellable = self.$searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink { text in
                if !text.isEmpty {
                    self.mapHelper.searchForLocation(text: text)
                }
            }
    }
    
    func selectPlace(_ place: Place?) {
        if let place = place {
            self.selectedPlace = place
        } else { //Mainly for offline
            let placemark = CLPlacemark(location: CLLocation(latitude: .zero, longitude: .zero), name: self.searchText, postalAddress: nil) //get location
            self.selectedPlace = Place(place: placemark)
        }
        
        self.dismissView()
    }
    
    func getAdressString(from place: Place) -> String? {
        return place.place.formattedAddress
    }
    
    func dismissView() {
        self.viewDismissalModePublished.send(true)
    }
}
