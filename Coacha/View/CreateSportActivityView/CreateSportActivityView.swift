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
                            TextField("name_tf", text: self.$viewModel.name, prompt: Text("createSportActivity.name.placeholder".localized))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .commonBackground()
                            
                            InteractableItemRow(title: "createSportActivity.place.title".localized, trailingCaption: self.viewModel.place?.place.name) {
                                self.viewModel.showLocationSheet()
                            }
                            
                            NonExpandableItemRow(title: "createSportActivity.duration.title".localized) {
                                durationPicker
                            }
                        }
                        .padding(.all, 16)
                    }
                }
            }
            
            .navigationBarTitle("createSportActivity.title".localized)
            .toolbar { self.toolbarButtons }
            
            .confirmationDialog(
                "createSportActivity.storage.dialog.title".localized,
                isPresented: self.$viewModel.showingConfirmationSheet,
                titleVisibility: .visible
            ) {
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
    
    private var durationPicker: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack(spacing: 4) {
                Picker("hour_picker", selection: self.$viewModel.duration.hours) {
                    ForEach(1 ..< 24, id:\.self) { value in
                        Text(String(value))
                    }
                }
                .pickerStyle(.menu)
                .commonBackground(R.color.alto, shadowColor: nil)
                
                Text("h.")
            }
            
            HStack(spacing: 4) {
                Picker("minute_picker", selection: self.$viewModel.duration.minutes) {
                    ForEach(1 ..< 60, id:\.self) { value in
                        Text(String(value))
                    }
                }
                .pickerStyle(.menu)
                .commonBackground(R.color.alto, shadowColor: nil)
                
                Text("min.".localized)
            }
        }
    }
    
    private var toolbarButtons: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.viewModel.dismissView()
                }) {
                    Text("general.cancel".localized)
                        .medium14(R.color.cinnabar)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.viewModel.showConfirmationSheet()
                }) {
                    Text("general.save".localized)
                        .medium14(self.viewModel.saveButtonDisabled ? R.color.martini : R.color.cinnabar)
                }
                .scaleableLinkStyle()
                .disabled(self.viewModel.saveButtonDisabled)
            }
        }
    }
    
    private var confirmationButtons: some View {
        Group {
            Button("general.local".localized) {
                self.viewModel.createLocalSportActivity()
            }
            
            Button("general.remote".localized) {
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
