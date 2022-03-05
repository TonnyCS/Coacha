//
//  SearchLocationViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import SwiftUI
import Combine

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
                self.mapHelper.searchForLocation(text: text)
            }
    }
    
    func selectPlace(_ place: Place) {
        self.selectedPlace = place
        self.dismissView()
    }
    
    func dismissView() {
        self.viewDismissalModePublished.send(true)
    }
}
