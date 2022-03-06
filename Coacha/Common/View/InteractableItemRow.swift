//
//  InteractableItemRow.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import SwiftUI

struct InteractableItemRow: View {
    let title: String
    let trailingCaption: String?
    let subtitle: String?

    let action: Action

    init(
        title: String,
        subtitle: String? = nil,
        trailingCaption: String? = nil,
        action: @escaping Action
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailingCaption = trailingCaption
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .medium17(R.color.martini)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .regular14()
                    }
                }

                Spacer()

                if let trailingCaption = trailingCaption {
                    Text(trailingCaption)
                        .medium17()
                }

                R.image.apple.chevronRight
                    .toFitFrame(side: 11)
                    .foregroundColor(R.color.martini)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .commonBackground()
        }
        .scaleableLinkStyle()
    }
}

struct InteractableItemRow_Previews: PreviewProvider {
    static var previews: some View {
        InteractableItemRow(title: "", action: {})
    }
}
