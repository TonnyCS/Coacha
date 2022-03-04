//
//  Image+.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

extension Image {
    // MARK: - FIT
    func toFitFrame() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func toFitFrame(side: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .toSquare(side: side)
    }
    
    func toFitFrame(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
    }
    
    // MARK: - FILL
    func toFillFrame() -> some View {
        self
            .resizable()
            .scaledToFill()
    }
    
    func toFillFrame(side: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .toSquare(side: side)
    }
    
    func toFillFrame(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}
