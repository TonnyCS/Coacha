//
//  SportActivityListView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SportActivityListView: View {
    @EnvironmentObject var remoteDataStore: RemoteDataStore
    @EnvironmentObject var localDataStore: LocalDataStore
    
    @StateObject var viewModel: SportActivityListViewModel
    
    var body: some View {
        NavigationView {
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
                    
                    if self.viewModel.sportActivities.isEmpty {
                        Text("sportActivityList.empty.title".localized)
                            .medium17()
                    } else {
                        ForEach(self.viewModel.sportActivities, id: \.id) { sportActivity in
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
                }
                .padding(.all, 16)
            }
            .zStackBackground(R.color.white)
            
            .navigationBarTitle("sportActivityList.title".localized)
            .toolbar { self.toolbarButtons }
            
            .sheet(isPresented: self.$viewModel.showingNewSportActivityView) {
                CreateSportActivityView(viewModel: CreateSportActivityViewModel())
            }
        }
        .navigationViewStyle(.stack)
        
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("general.cancel".localized)))
        }
        
        .onAppear {
            self.viewModel.remoteDataStore = self.remoteDataStore
            self.viewModel.localDataStore = self.localDataStore
            
            self.viewModel.refreshArray()
        }
        .onChange(of: self.viewModel.storageType) { _ in
            self.viewModel.refreshArray()
        }
        .onReceive(self.viewModel.remoteDataStore.remoteSportActivity) { _ in
            self.viewModel.refreshArray()
        }
        .onReceive(self.viewModel.localDataStore.localSportActivity) { _ in
            self.viewModel.refreshArray()
        }
    }
    
    private var toolbarButtons: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: self.viewModel.onPlusButtonClicked) {
                R.image.apple.plus
                    .foregroundColor(R.color.perm.cinnabar)
            }
        }
    }
}

fileprivate struct SportActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityListView(viewModel: SportActivityListViewModel())
    }
}
