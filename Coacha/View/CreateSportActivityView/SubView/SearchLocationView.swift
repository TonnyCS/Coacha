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
            VStack {
                TextField("placeSearch_tf", text: self.$viewModel.searchText, prompt: Text("Misto"))
                    .padding(.all, 16)
                    .commonBackground()
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 32) {
                        InteractableItemRow(title: "Use current location - TODO", subtitle: "Ve Střešovičkách 1090") {
                            
                        }
                        
                        VStack(spacing: 12) {
                            ForEach(self.viewModel.mapHelper.places) { place in
                                InteractableItemRow(
                                    title: place.place.name ?? "N/A",
                                    subtitle: place.place.locality,
                                    trailingCaption: place.place.isoCountryCode) {
                                        self.viewModel.selectPlace(place)
                                    }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 16)
                }
            }
            .navigationTitle(Text("Misto"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { self.toolbarButtons }
        }
        .onAppear {
            self.viewModel.mapHelper = mapHelper
        }
        .onReceive(self.viewModel.viewDismissalModePublished, perform: { (shouldDismiss) in
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    private var toolbarButtons: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                self.viewModel.dismissView()
            }) {
                Text("zrušit")
                    .medium14(R.color.cinnabar)
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
