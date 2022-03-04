//
//  LoadingView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct LoadingView: View {
    let color: Color?
    
    init(color: Color? = nil) {
        self.color = color
    }
    
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(color)
    }
}

fileprivate struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
