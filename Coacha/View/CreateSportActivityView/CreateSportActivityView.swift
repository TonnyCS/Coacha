//
//  CreateSportActivityView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct CreateSportActivityView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var remoteDataStore: RemoteDataStore
    @EnvironmentObject var localDataStore: LocalDataStore
    
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
                                .medium17()
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .commonBackground(R.color.whiteDMGray)
                            
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
            .zStackBackground(R.color.white)
            
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
        .navigationViewStyle(.stack)
        
        .onAppear {
            self.viewModel.remoteDataStore = self.remoteDataStore
            self.viewModel.localDataStore = self.localDataStore
        }
        .onReceive(self.viewModel.viewDismissalModePublished, perform: { _ in
            self.presentationMode.wrappedValue.dismiss()
        })
    }
    
    private var durationPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Menu {
                Picker("hour_picker", selection: self.$viewModel.duration.hours) {
                    ForEach(0 ..< 24, id:\.self) { value in
                        Text(String(value)).tag(value)
                    }
                }
            } label: {
                Text("\(self.viewModel.duration.hours) h")
                    .medium17()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .commonBackground(R.color.alto, 6, shadowColor: nil)

            Menu {
                Picker("minute_picker", selection: self.$viewModel.duration.minutes) {
                    ForEach(0 ..< 60, id:\.self) { value in
                        Text(String(value)).tag(value)
                    }
                }
            } label: {
                Text("\(self.viewModel.duration.minutes) min")
                    .medium17()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .commonBackground(R.color.alto, 6, shadowColor: nil)
        }
    }
    
    private var toolbarButtons: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.viewModel.dismissView()
                }) {
                    Text("general.cancel".localized)
                        .medium17(R.color.cinnabar)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.viewModel.showConfirmationSheet()
                }) {
                    Text("general.save".localized)
                        .medium17(self.viewModel.saveButtonDisabled ? R.color.alto : R.color.cinnabar)
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
