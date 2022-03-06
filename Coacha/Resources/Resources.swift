//
//  Resources.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

typealias R = Resources

// MARK: - COLOR_NAMING
// https://chir.ag/projects/name-that-color
// MARK: - COLOR_PALETTE
// https://coolors.co/palette/0b090a-161a1d-660708-a4161a-ba181b-e5383b-b1a7a6-d3d3d3-f5f3f4-ffffff

enum Resources {
    enum color {
        enum perm {
            /// WHITE | HEX: #FFFFFF
            static let white = Color("Perm_White")
            /// BLACK | HEX: #000000
            static let black = Color("Perm_Black")
        }
        
        enum shadow {
            /// BLACK_16% | HEX: #000000 O: 16%
            static let black016 = Color("ShadowBlack016")
        }
        
        /// WHITE  | L: HEX: #FFFFFF | D: HEX: #000000
        static let white = Color("White")
        /// BLACK | L: HEX: #000000 | D: HEX: #FFFFFF
        static let black = Color("Black")
        
        /// LIGHT_GRAY | L: HEX: #D3D3D3 | D: HEX: #D3D3D3
        static let alto = Color("Alto")
        /// LIGHT_GRAY | L: HEX: #F5F3F4 | D: HEX: #F5F3F4
        static let bonJour = Color("Alto")
        /// GRAY | L: HEX: #B1A7A6 | D: HEX: #B1A7A6
        static let martini = Color("Martini")
        /// DARK_GRAY | L: HEX: #161A1D | D: HEX: #161A1D
        static let woodsmoke = Color("Woodsmoke")
        /// DARK_GRAY | L: HEX: #0B090A | D: HEX: #0B090A
        static let codGray = Color("CodGray")
        
        /// LIGHT_RED | L: HEX: #E5383B | D: HEX: #E5383B
        static let cinnabar = Color("Cinnabar")
        /// RED | L: HEX: #E5383B | D: HEX: #E5383B
        static let tamarillo = Color("Tamarillo")
        /// DARK_RED | L: HEX: #E5383B | D: HEX: #E5383B
        static let darkBurgundy = Color("DarkBurgundy")
    }
    
    enum font {
        // MARK: - BOLD
        static let bold34 = Font.system(size: 34, weight: .bold, design: .default)
        
        // MARK: - SEMIBOLD
        static let semibold17 = Font.system(size: 17, weight: .semibold, design: .default)
        static let semibold16 = Font.system(size: 16, weight: .semibold, design: .default)
        static let semibold14 = Font.system(size: 14, weight: .semibold, design: .default)
        
        // MARK: - MEDIUM
        static let medium17 = Font.system(size: 17, weight: .medium, design: .default)
        static let medium14 = Font.system(size: 14, weight: .medium, design: .default)
        
        // MARK: - REGULAR
        static let regular14 = Font.system(size: 14, weight: .regular, design: .default)
        static let regular13 = Font.system(size: 13, weight: .regular, design: .default)
        static let regular12 = Font.system(size: 12, weight: .regular, design: .default)
        static let regular10 = Font.system(size: 10, weight: .regular, design: .default)
    }
    
    enum image {
        enum apple {
            static let plus = Image(systemName: "plus")
            static let trash = Image(systemName: "trash")
            static let chevronRight = Image(systemName: "chevron.right")
            static let magnifyingglass = Image(systemName: "magnifyingglass")
            
            enum fill {
                static let flag2Crossed = Image(systemName: "flag.2.crossed.fill")
                static let multiplyCircle = Image(systemName: "multiply.circle.fill")
            }
        }
    }
}
