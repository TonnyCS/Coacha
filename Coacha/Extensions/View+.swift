//
//  View+.swift
//  Coacha
//
//  Created by Anthony Šimek on 07.03.2022.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, toast: Toast) -> some View {
        ToastView(isPresented: isPresented, presenting: { self }, toast: toast)
    }
}
