//
//  SportActivityItemView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SportActivityItemView: View {
    @StateObject var viewModel: SportActivityItemViewModel
    @GestureState var isDragging = false
    
    var body: some View {
        ZStack {
            if viewModel.swipeOffset < 0 {
                swipeButton
            }
            
            cell
                .offset(x: self.viewModel.swipeOffset)
                .gesture(
                    DragGesture()
                        .updating(self.$isDragging, body: { value, state, _ in
                            state = true
                            self.viewModel.onChanged(value: value)
                        })
                        .onEnded({ value in
                            self.viewModel.onEnd(value: value)
                        })
                )
        }
        .alert("alert.sportActivity.remove.title".localized, isPresented: self.$viewModel.showingRemoveAlert, actions: {
            Button("general.yes".localized, role: .destructive, action: self.viewModel.removeAction)
            Button("general.no".localized, role: .cancel, action: {})
        }, message: {
            Text("alert.sportActivity.remove.subtitle".localized)
        })
    }
    
    private var cell: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(self.viewModel.name)
                    .medium17()
                
                Text(self.viewModel.place)
                    .regular14(R.color.martini)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(self.viewModel.date)
                    .regular12(R.color.martini)
                
                Text(self.viewModel.durationString)
                    .regular12(R.color.martini)
                
                Text(self.viewModel.storageType)
                    .regular12(R.color.martini)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .commonBackground()
    }
    
    private var swipeButton: some View {
        Group {
            R.color.cinnabar.cornerRadius(10)
            
            HStack {
                Spacer()
                
                Button(action: self.viewModel.showRemoveSportActivityAlert) {
                    R.image.apple.trash
                        .toFitFrame(side: 24)
                        .foregroundColor(R.color.perm.white)
                }
                .padding(.trailing, -self.viewModel.swipeOffset <= 84 ? 30 : (-self.viewModel.swipeOffset - 24) / 2)
            }
        }
    }
}

fileprivate struct SportActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityItemView(viewModel: SportActivityItemViewModel(name: "TEST", place: "PLACE", date: Date(), duration: DateDuration(hours: 1, minutes: 30), isLocal: false, removeAction: {}))
    }
}
