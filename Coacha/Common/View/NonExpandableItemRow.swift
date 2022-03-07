//
//  NonExpandableItemRow.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import SwiftUI

struct NonExpandableItemRow<Content: View>: View {
    let title: String
    let content: Content
    
    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Text(title)
                .medium17()
            
            Spacer()
            
            content
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .commonBackground(R.color.whiteDMGray)
    }
}

struct NonExpandableItemRow_Previews: PreviewProvider {
    static var previews: some View {
        NonExpandableItemRow(title: "") {
            Text("")
        }
    }
}
