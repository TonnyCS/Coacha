//
//  CreateSportActivityView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct CreateSportActivityView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var dataStore: DataStore
    
    @StateObject var viewModel: CreateSportActivityViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if self.viewModel.showingLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            TextField("name_tf", text: self.$viewModel.name, prompt: Text("nazev"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .commonBackground()
                            
                            InteractableItemRow(title: "Place", trailingCaption: self.viewModel.place?.place.name) {
                                self.viewModel.showLocationSheet()
                            }
                            
                            NonExpandableItemRow(title: "Duration") {
                                HStack(spacing: 4) {
                                    Picker("value_picker", selection: self.$viewModel.duration.value) {
                                        ForEach(1 ..< 60, id:\.self) { value in
                                            Text(String(value))
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .commonBackground(R.color.alto, shadowColor: nil)
                                    
                                    Picker("unit_picker", selection: self.$viewModel.duration.unit) {
                                        ForEach(DateDuration.Unit.allCases, id:\.self) { unit in
                                            Text(unit.rawValue)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .padding(.horizontal, 8)
                                    .commonBackground(R.color.alto, shadowColor: nil)
                                }
                            }
                        }
                        .padding(.all, 16)
                    }
                }
            }
            
            .navigationBarTitle("CreateView")
            .toolbar { self.toolbarButtons }
            
            .confirmationDialog("Kam uložit", isPresented: self.$viewModel.showingConfirmationSheet) {
                self.confirmationButtons
            }
            .sheet(isPresented: self.$viewModel.showingLocationSheet) {
                SearchLocationView(viewModel: SearchLocationViewModel(selectedPlace: self.$viewModel.place))
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
    
    private var toolbarButtons: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.viewModel.dismissView()
                }) {
                    Text("Zrušit")
                        .medium14(R.color.cinnabar)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.viewModel.showConfirmationSheet()
                }) {
                    Text("Smazat ne")
                        .medium14(self.viewModel.saveButtonDisabled ? R.color.martini : R.color.cinnabar)
                }
                .scaleableLinkStyle()
                .disabled(self.viewModel.saveButtonDisabled)
            }
        }
    }
    
    private var confirmationButtons: some View {
        Group {
            Button("Local") {
                self.viewModel.createLocalSportActivity()
            }
            
            Button("Remote") {
                self.viewModel.createRemoteSportActivity()
            }
        }
    }
}

fileprivate struct CreateSportActivityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSportActivityView(viewModel: CreateSportActivityViewModel())
            .environmentObject(MapHelper())
    }
}
