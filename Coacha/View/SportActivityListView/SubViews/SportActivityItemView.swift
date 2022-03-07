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
                        .updating(self.$isDragging, body: { value, _, _ in
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
        VStack(spacing: 16) {
            HStack {
                Text(self.viewModel.name)
                    .semibold32(R.color.perm.white)
                
                Spacer()
                
                self.viewModel.storageIcon
                    .toFitFrame(side: 24)
                    .foregroundColor(R.color.perm.white)
            }
            .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(self.viewModel.dateString)
                        .regular16(R.color.perm.white)
                    
                    Spacer()
                    
                    Text(self.viewModel.durationString)
                        .regular16(R.color.perm.white)
                }
                
                Text(self.viewModel.place)
                    .medium17(R.color.perm.white)
            }
        }
        .padding(.all, 16)
        .commonBackground(self.viewModel.backgroundColor, shadowColor: nil)
    }
    
    private var swipeButton: some View {
        Group {
            R.color.perm.tamarillo.cornerRadius(20)
            
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
