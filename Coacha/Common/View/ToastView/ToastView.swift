//
//  ToastView.swift
//  Coacha
//
//  Created by Anthony Šimek on 07.03.2022.
//

import SwiftUI

struct ToastView<Presenting: View>: View {
    @Binding var isPresented: Bool
    let presenting: () -> Presenting
    let toast: Toast
    
    var body: some View {
        ZStack {
            self.presenting()
                .blur(radius: self.isPresented ? 2 : 0)
                .edgesIgnoringSafeArea(.all)
            
            R.color.perm.black
                .edgesIgnoringSafeArea(.all)
                .opacity(self.isPresented ? 0.05 : 0)
                .onTapGesture {
                    withAnimation {
                        self.isPresented = false
                    }
                }
            
            VStack(alignment: .leading) {
                HStack {
                    R.image.apple.fill.flag2Crossed
                        .toFitFrame(side: 16)
                        .foregroundColor(self.toast.iconColor)
                    
                    Text(self.toast.title.localized)
                        .medium17()
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .commonBackground(R.color.whiteDMGray)
                .padding(.horizontal, 16)
                .transition(.slide)
                .offset(x: 0, y: self.isPresented ? 0 : -100)
                
                Spacer()
            }
        }
        .onChange(of: self.isPresented) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isPresented = false
                    }
                }
            }
        }
    }
}
