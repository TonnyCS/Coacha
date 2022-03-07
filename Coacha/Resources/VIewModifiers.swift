//
//  VIewModifiers.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

extension View {
    // MARK: - COMMON
    func toSquare(side: CGFloat) -> some View { frame(width: side, height: side) }
    
    // MARK: - BACKGROUNDS
    /// Encloses content into a ZStack with a selected color underneath
    func zStackBackground(_ color: Color) -> some View { modifier(ZStackBackground(color: color)) }
    /// BASE SHADOW:
    ///     Color: RegalBlue020
    ///     Radius: 1
    ///     X: 0
    ///     Y: 3
    func commonBackground(
        _ color: Color = R.color.white,
        _ cornerRadius: CGFloat = 20,
        shadowColor: Color? = R.color.shadow.black010,
        shadowRadius: CGFloat = 6,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 3) -> some View {
            modifier(CommonBackground(
                color: color,
                cornerRadius: cornerRadius,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowX: shadowX,
                shadowY: shadowY
            ))
        }
    
    // MARK: - FONTS
    func bold34(_ color: Color = R.color.codGray) -> some View { modifier(Bold34(color: color)) }
    
    func semibold32(_ color: Color = R.color.codGray) -> some View { modifier(Semibold32(color: color)) }
    func semibold17(_ color: Color = R.color.codGray) -> some View { modifier(Semibold17(color: color)) }
    func semibold16(_ color: Color = R.color.codGray) -> some View { modifier(Semibold16(color: color)) }
    func semibold14(_ color: Color = R.color.codGray) -> some View { modifier(Semibold14(color: color)) }
    
    func medium17(_ color: Color = R.color.codGray) -> some View { modifier(Medium17(color: color)) }
    func medium16(_ color: Color = R.color.codGray) -> some View { modifier(Medium16(color: color)) }
    func medium14(_ color: Color = R.color.codGray) -> some View { modifier(Medium14(color: color)) }
    
    func regular16(_ color: Color = R.color.codGray) -> some View { modifier(Regular16(color: color)) }
    func regular14(_ color: Color = R.color.codGray) -> some View { modifier(Regular14(color: color)) }
    func regular13(_ color: Color = R.color.codGray) -> some View { modifier(Regular13(color: color)) }
    func regular12(_ color: Color = R.color.codGray) -> some View { modifier(Regular12(color: color)) }
    func regular10(_ color: Color = R.color.codGray) -> some View { modifier(Regular10(color: color)) }
    
    // MARK: - BUTTON_STYLES
    func scaleableLinkStyle() -> some View { buttonStyle(ScaleableLinkStyle()) }
    func flatLinkStyle() -> some View { buttonStyle(FlatLinkStyle()) }
}

// MARK: - VIEW_MODIFIERS
// MARK: - BACKGROUNDS
fileprivate struct ZStackBackground: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            color.edgesIgnoringSafeArea(.all)
            content
        }
    }
}

fileprivate struct CommonBackground: ViewModifier {
    let color: Color
    let cornerRadius: CGFloat
    
    let shadowColor: Color?
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(color)
                    .shadow(color: shadowColor ?? Color.clear, radius: shadowRadius, x: shadowX, y: shadowY)
            )
    }
}

// MARK: - BOLD
fileprivate struct Bold34: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .lineLimit(2)
            .font(R.font.bold34)
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
}

// MARK: - SEMIBOLD
fileprivate struct Semibold32: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.semibold32)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

fileprivate struct Semibold17: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.semibold17)
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
}

fileprivate struct Semibold16: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.semibold16)
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
}

fileprivate struct Semibold14: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.semibold14)
            .foregroundColor(color)
    }
}

// MARK: - MEDIUM
fileprivate struct Medium17: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.medium17)
            .foregroundColor(color)
    }
}

fileprivate struct Medium16: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.medium16)
            .foregroundColor(color)
    }
}

fileprivate struct Medium14: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.medium14)
            .foregroundColor(color)
    }
}

// MARK: - REGULAR
fileprivate struct Regular16: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.regular16)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

fileprivate struct Regular14: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.regular14)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

fileprivate struct Regular13: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.regular13)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

fileprivate struct Regular12: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.regular12)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

fileprivate struct Regular10: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(R.font.regular10)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

