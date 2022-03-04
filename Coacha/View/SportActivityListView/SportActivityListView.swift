//
//  SportActivityListView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SportActivityListView: View {
    @EnvironmentObject var dataStore: DataStore
    
    @StateObject var viewModel: SportActivityListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("StorageSelection", selection: self.$viewModel.storageType) {
                    Text("All").tag(StorageType.all)
                    Text("Local").tag(StorageType.local)
                    Text("Remote").tag(StorageType.remote)
                }
                .pickerStyle(.segmented)
                .padding(.all, 16)
                
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(self.dataStore.allSportActivity) { sportActivity in
                            SportActivityItemView(viewModel: SportActivityItemViewModel(name: sportActivity.name, place: sportActivity.place, date: sportActivity.date, isLocal: false))
                        }
                    }
                    .padding(.all, 16)
                }
            }
            .zStackBackground(R.color.white)
            
            .navigationBarTitle("MainView")
            .toolbar {
                self.toolbarButtons
            }
            
            .sheet(isPresented: self.$viewModel.showingNewSportActivityView) {
                CreateSportActivityView(viewModel: CreateSportActivityViewModel())
            }
        }
    }
    
    private var toolbarButtons: some View {
        Button(action: {
            self.viewModel.showingNewSportActivityView = true
        }) {
            R.image.apple.plus
                .foregroundColor(R.color.cinnabar)
        }
        .scaleableLinkStyle()
    }
}

fileprivate struct SportActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityListView(viewModel: SportActivityListViewModel())
    }
}
