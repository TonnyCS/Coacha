//
//  SportActivityItemView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

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
        .commonBackground(self.viewModel.backgroundColor)
    }
}

fileprivate struct SportActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        SportActivityItemView(viewModel: SportActivityItemViewModel(name: "TEST", place: "PLACE", date: Date(), isLocal: false))
    }
}
