//
//  SearchBar.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    let searchAction: Action
    
    var body: some View {
        HStack(spacing: 10) {
            R.image.apple.magnifyingglass
                .foregroundColor(R.color.alto)
            
            TextField("general.search".localized, text: self.$searchText)
                .textInputAutocapitalization(.words)
                .submitLabel(.search)
                .onSubmit {
                    self.searchAction()
                }
                .medium17()
            
            if !self.searchText.isEmpty {
                Button(action: {
                    withAnimation {
                        self.searchText = ""
                    }
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    R.image.apple.fill.multiplyCircle
                        .foregroundColor(R.color.alto)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .commonBackground(R.color.whiteDMGray)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("")) { }
    }
}
