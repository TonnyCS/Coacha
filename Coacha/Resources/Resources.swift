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

enum Resources {
    enum color {
        enum perm {
            /// WHITE | HEX: #FFFFFF
            static let white = Color("Perm_White")
            /// BLACK | HEX: #000000
            static let black = Color("Perm_Black")
            
            /// LIGHT_RED | L: HEX: #E5383B
            static let cinnabar = Color("Perm_Cinnabar")
            /// DARK_RED | L: HEX: #A4161A
            static let tamarillo = Color("Perm_Tamarillo")
        }
        
        enum shadow {
            /// BLACK_10% | HEX: #000000 O: 10%
            static let black010 = Color("ShadowBlack010")
        }
        
        /// WHITE  | L: HEX: #FFFFFF | D: HEX: #000000
        static let white = Color("White")
        /// WHITE_DM_GRAY  | L: HEX: #FFFFFF | D: HEX: #1C1C1E
        static let whiteDMGray = Color("WhiteDMGray")
        
        /// LIGHT_GRAY | L: HEX: #D3D3D3 | D: HEX: #424242
        static let alto = Color("Alto")
        /// DARK_GRAY | L: HEX: #0B090A | D: HEX: #FFFFFF
        static let codGray = Color("CodGray")
        
        /// LIGHT_BLUE | L: HEX: #47A8BD | D: HEX: #2E4052
        static let pelorous = Color("Pelorous")
    }
    
    enum font {
        // MARK: - BOLD
        static let bold34 = Font.system(size: 34, weight: .bold, design: .default)
        
        // MARK: - SEMIBOLD
        static let semibold32 = Font.system(size: 32, weight: .semibold, design: .default)
        
        // MARK: - MEDIUM
        static let medium17 = Font.system(size: 17, weight: .medium, design: .default)
        
        // MARK: - REGULAR
        static let regular16 = Font.system(size: 16, weight: .regular, design: .default)
        static let regular14 = Font.system(size: 14, weight: .regular, design: .default)
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
                static let icloudCircle = Image(systemName: "icloud.circle.fill")
                static let iphoneCircle = Image(systemName: "iphone.circle.fill")
            }
        }
    }
}
