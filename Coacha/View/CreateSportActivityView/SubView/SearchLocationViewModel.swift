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
    var viewDismissalModePublished = PassthroughSubject<(), Never>()
    private var cancellable: AnyCancellable?
    
    @ObservedObject var mapHelper: MapHelper = MapHelper()
    
    @Published var searchedPlaces: [Place] = []
    @Published var searchText: String = ""
    
    @Binding var selectedPlace: Place?
    
    @Published var showingLoading: Bool = false
    
    init(selectedPlace: Binding<Place?>) {
        self._selectedPlace = selectedPlace
        
        cancellable = self.$searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink { text in
                if !text.isEmpty {
                    self.searchForLocation(text: text)
                }
            }
    }
    
    func selectPlace(_ place: Place?) {
        if let place = place {
            self.selectedPlace = place
        } else { //Mainly for when user is offline or cannot find the location
            let placemark = CLPlacemark(location: CLLocation(latitude: .zero, longitude: .zero), name: self.searchText, postalAddress: nil)
            self.selectedPlace = Place(place: placemark)
        }
        
        self.dismissView()
    }
    
    func searchForLocation(text: String) {
        self.mapHelper.searchForLocation(text: self.searchText) { result in
            switch result {
                case .success(let places):
                    withAnimation {
                        self.searchedPlaces = places
                    }
                case .failure(_):
                    return
            }
        }
    }
    
    func getAdressString(from place: Place) -> String? {
        return place.place.formattedAddress
    }
    
    func dismissView() {
        self.viewDismissalModePublished.send(())
    }
}
