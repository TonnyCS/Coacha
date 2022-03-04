//
//  CreateSportActivityView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct CreateSportActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataStore: DataStore
    
    @StateObject var viewModel: CreateSportActivityViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if self.viewModel.showingLoading {
                    LoadingView()
                } else {
                    Form {
                        Section(header: Text("TEST")) {
                            TextField("name_tf", text: self.$viewModel.name, prompt: Text("TEST"))
                            TextField("place_tf", text: self.$viewModel.place, prompt: Text("TEST"))
                        }
                        
                        Section(header: Text("Number")) {
                            Picker("duration_pick", selection: self.$viewModel.duration) {
                                ForEach(2 ..< 100) { id in
                                    Text("\(id)")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("CreateView")
            .toolbar {
                self.toolbarButtons
            }
        }
        .onAppear {
            self.viewModel.dataStore = self.dataStore
        }
        .onReceive(self.viewModel.viewDismissalModePublished, perform: { (shouldDismiss) in
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    private var toolbarButtons: some View {
        Button(action: {
            self.viewModel.createNewSportActivity()
        }) {
            Text("Smazat ne")
                .medium14(self.viewModel.saveButtonDisabled ? R.color.martini : R.color.cinnabar)
        }
        .scaleableLinkStyle()
        .disabled(self.viewModel.saveButtonDisabled)
    }
}

fileprivate struct CreateSportActivityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSportActivityView(viewModel: CreateSportActivityViewModel())
    }
}
