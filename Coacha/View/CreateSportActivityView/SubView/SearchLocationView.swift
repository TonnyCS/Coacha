//
//  SearchLocationView.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import SwiftUI

struct SearchLocationView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var mapHelper: MapHelper
    
    @StateObject var viewModel: SearchLocationViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                SearchBar(searchText: self.$viewModel.searchText) {
                    self.viewModel.searchForLocation(text: self.viewModel.searchText)
                }
                .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 16) {
                        if !self.viewModel.searchText.isEmpty {
                            InteractableItemRow(
                                title: "searchLocation.useSearchedAddress.button.title".localized,
                                subtitle: self.viewModel.searchText
                            ) {
                                self.viewModel.selectPlace(nil)
                            }
                        }
                        
                        if self.viewModel.showingLoading {
                            LoadingView()
                        } else {
                            ForEach(self.viewModel.searchedPlaces) { place in
                                InteractableItemRow(
                                    title: place.place.name ?? "N/A",
                                    subtitle: self.viewModel.getAdressString(from: place),
                                    trailingCaption: place.place.isoCountryCode) {
                                        self.viewModel.selectPlace(place)
                                    }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 16)
                    .animation(.easeInOut, value: self.viewModel.searchText)
                }
            }
            .padding(.top, 16)
            .zStackBackground(R.color.white)
            
            .navigationTitle(Text("searchLocation.title".localized))
            .toolbar { self.toolbarButtons }
        }
        .navigationViewStyle(.stack)
        
        .onAppear {
            self.viewModel.mapHelper = mapHelper
        }
        .onReceive(self.viewModel.viewDismissalModePublished, perform: { _ in 
            self.presentationMode.wrappedValue.dismiss()
        })
    }
    
    private var toolbarButtons: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                self.viewModel.dismissView()
            }) {
                Text("general.cancel".localized)
                    .medium17(R.color.cinnabar)
            }
        }
    }
}

fileprivate struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(viewModel: SearchLocationViewModel(selectedPlace: .constant(nil)))
            .environmentObject(MapHelper())
    }
}
