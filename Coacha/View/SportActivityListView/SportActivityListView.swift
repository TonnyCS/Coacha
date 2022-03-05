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
//                ScrollView {
                    VStack(spacing: 16) {
                        
                        
                        List {
                            Picker("StorageSelection", selection: self.$viewModel.storageType) {
                                Text("All").tag(StorageType.all)
                                Text("Local").tag(StorageType.local)
                                Text("Remote").tag(StorageType.remote)
                            }
                            .pickerStyle(.segmented)
                            
                            ForEach(self.viewModel.getArray()) { sportActivity in
                                SportActivityItemView(viewModel: SportActivityItemViewModel(name: sportActivity.name, place: sportActivity.place, date: sportActivity.date, isLocal: sportActivity.isLocal))
                                    .swipeActions(edge: .trailing) {
                                        Button(action: {
                                            self.viewModel.deleteSportActivity(id: sportActivity.id, isLocal: sportActivity.isLocal)
                                        }) {
                                            Text("delete")
                                        }
                                        .tint(R.color.cinnabar)
                                    }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .padding(.all, 16)
//                }
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
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("general.cancel".localized)))
        }
        
        .onAppear {
            self.viewModel.dataStore = self.dataStore
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
