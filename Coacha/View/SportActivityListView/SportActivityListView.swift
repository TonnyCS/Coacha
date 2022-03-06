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
                ScrollView {
                    VStack(spacing: 16) {
                        Picker("Storage_pick", selection: self.$viewModel.storageType) {
                            Text("general.all".localized)
                                .tag(StorageType.all)
                            Text("general.local".localized)
                                .tag(StorageType.local)
                            Text("general.remote".localized)
                                .tag(StorageType.remote)
                        }
                        .pickerStyle(.segmented)
                        
                        ForEach(self.viewModel.getArray()) { sportActivity in
                            SportActivityItemView(
                                viewModel: SportActivityItemViewModel(
                                    name: sportActivity.name,
                                    place: sportActivity.place,
                                    date: sportActivity.date,
                                    duration: sportActivity.duration,
                                    isLocal: sportActivity.isLocal
                                ){
                                    self.viewModel.deleteSportActivity(id: sportActivity.id, isLocal: sportActivity.isLocal)
                                }
                            )
                        }
                    }
                    .padding(.all, 16)
                }
            }
            .zStackBackground(R.color.white)
            
            .navigationBarTitle("sportActivityList.title".localized)
            .toolbar { self.toolbarButtons }
            
            .sheet(isPresented: self.$viewModel.showingNewSportActivityView) {
                CreateSportActivityView(viewModel: CreateSportActivityViewModel())
            }
        }
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("general.cancel".localized)))
        }
        
        .onAppear {
            self.viewModel.dataStore = self.dataStore
        }
    }
    
    private var toolbarButtons: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                self.viewModel.showingNewSportActivityView = true
            }) {
                R.image.apple.plus
                    .foregroundColor(R.color.cinnabar)
            }
        }
    }
}

fileprivate struct SportActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityListView(viewModel: SportActivityListViewModel())
    }
}
