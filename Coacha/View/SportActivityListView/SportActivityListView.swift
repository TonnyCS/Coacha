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
                            SportActivityItemView(viewModel: SportActivityItemViewModel(name: sportActivity.name, place: sportActivity.place, date: sportActivity.date))
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

struct SportActivityItemView: View {
    @StateObject var viewModel: SportActivityItemViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(self.viewModel.name)
                    .semibold16()
                
                Text(self.viewModel.place)
                    .regular10(R.color.martini)
            }
                
            Spacer()
            
            Text(self.viewModel.date)
                .regular12(R.color.martini)
        }
        .padding(.all, 8)
        .commonBackground()
    }
}

final class SportActivityItemViewModel: ObservableObject {
    let name: String
    let place: String
    let date: String
    
    init(name: String, place: String, date: Date) {
        self.name = name
        self.place = place
        self.date = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
    }
}

fileprivate struct SportActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityListView(viewModel: SportActivityListViewModel())
    }
}
