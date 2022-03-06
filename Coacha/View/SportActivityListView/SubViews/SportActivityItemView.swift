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
                R.color.cinnabar.cornerRadius(10)
                
                HStack {
                    Spacer()
                    
                    Button(action: self.viewModel.showRemoveSportActivityAlert) {
                        R.image.apple.trash
                            .toFitFrame(side: 24)
                            .foregroundColor(R.color.perm.white)
                    }
                    //n = padding | Minimum: n + imageSize for which padding = n / 2 and after x - imageSize / 2
                    .padding(.trailing, -self.viewModel.swipeOffset <= 84 ? 30 : (-self.viewModel.swipeOffset - 24) / 2)
                }
            }
            
            cell
                .offset(x: self.viewModel.swipeOffset)
                .gesture(
                    DragGesture()
                        .updating(self.$isDragging, body: { value, state, _ in
                            state = true
                            self.onChanged(value: value)
                        })
                        .onEnded({ value in
                            self.onEnd(value: value)
                        })
                )
        }
        .alert("alert.reservation.remove.title".localized, isPresented: self.$viewModel.showingRemoveAlert, actions: {
            Button("general.yes".localized, role: .destructive, action: self.viewModel.removeAction)
            Button("general.no".localized, role: .cancel, action: {})
        }, message: {
            Text("alert.reservation.remove.subtitle".localized)
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
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .commonBackground()
    }
    
    private func onChanged(value: DragGesture.Value) {
        if isDragging {
            self.viewModel.swipeOffset = value.translation.width + self.viewModel.lastSwipeOffset
        }
    }
    
    private func onEnd(value: DragGesture.Value) {
        withAnimation {
            if -(value.translation.width + self.viewModel.lastSwipeOffset) >= 60 && -(value.translation.width + self.viewModel.lastSwipeOffset) <= UIScreen.main.bounds.width / 2 {
                self.viewModel.swipeOffset = -84 // Button width
                self.viewModel.lastSwipeOffset = -84
            } else if -(value.translation.width + self.viewModel.lastSwipeOffset) > UIScreen.main.bounds.width / 2 {
                self.viewModel.swipeOffset = -UIScreen.main.bounds.width
                self.viewModel.lastSwipeOffset = -UIScreen.main.bounds.width
                self.viewModel.showRemoveSportActivityAlert()
            } else {
                self.viewModel.swipeOffset = 0
                self.viewModel.lastSwipeOffset = 0
            }
        }
    }
}

fileprivate struct SportActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityItemView(viewModel: SportActivityItemViewModel(name: "TEST", place: "PLACE", date: Date(), duration: DateDuration(value: 1, unit: .minutes), isLocal: false, removeAction: {}))
    }
}
