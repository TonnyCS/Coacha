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
                
                List {
                    Button(action: { }) {
                        Text("Current location todo")
                    }
                    .scaleableLinkStyle()
                    
                    ForEach(self.viewModel.mapHelper.places) { place in
                        Button(action: { self.viewModel.selectPlace(place) }) {
                            Text(place.place.name ?? "N/A")
                        }
                    }
                }
            }
            .padding(.all, 16)
            
            .navigationTitle(Text("Misto"))
            .navigationBarTitleDisplayMode(.inline)
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
}

fileprivate struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(viewModel: SearchLocationViewModel(selectedPlace: .constant(nil)))
            .environmentObject(MapHelper())
    }
}
