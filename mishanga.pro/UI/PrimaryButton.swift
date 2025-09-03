//
//  PrimaryButton.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI

enum ButtonStyle {
    case primary
    case secondary
    case navigation
}

struct PrimaryButton: View {
    let text: String
    let action: (() -> Void)?
    let style: ButtonStyle
    let height: CGFloat

    init(text: String, style: ButtonStyle = .primary, height: CGFloat = 48, action: (() -> Void)? = nil) {
        self.text = text
        self.style = style
        self.height = height
        self.action = action
    }

    var body: some View {
        if let action = action {
            Button(action: action) {
                buttonContent
            }
        } else {
            buttonContent
        }
    }

    private var buttonContent: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeWidth)
            )
            .cornerRadius(cornerRadius)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .brandPrimary
        case .secondary:
            return .backgroundSecondary
        case .navigation:
            return .clear
        }
    }

    private var textColor: Color {
        switch style {
        case .primary, .secondary:
            return .brandBlack
        case .navigation:
            return .primary
        }
    }

    private var strokeColor: Color {
        switch style {
        case .primary, .secondary, .navigation:
            return .brandBlack
        }
    }

    private var strokeWidth: CGFloat {
        switch style {
        case .primary:
            return 2
        case .secondary, .navigation:
            return 1
        }
    }

    private var cornerRadius: CGFloat {
        switch style {
        case .primary, .secondary:
            return 12
        case .navigation:
            return 0
        }
    }

    private var verticalPadding: CGFloat {
        switch style {
        case .primary, .secondary:
            return 0 // Height is controlled by frame
        case .navigation:
            return 8
        }
    }
}

// Convenience views for different button types
struct NavigationButton: View {
    let systemName: String
    let action: (() -> Void)?

    init(systemName: String, action: (() -> Void)? = nil) {
        self.systemName = systemName
        self.action = action
    }

    var body: some View {
        if let action = action {
            Button(action: action) {
                iconView
            }
        } else {
            iconView
        }
    }

    private var iconView: some View {
        Image(systemName: systemName)
            .font(.title2)
            .foregroundColor(.primary)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.brandBlack, lineWidth: 1)
            )
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(text: "Primary Button") {
            print("Primary tapped")
        }

        PrimaryButton(text: "Secondary Button", style: .secondary) {
            print("Secondary tapped")
        }

        NavigationButton(systemName: "chevron.left") {
            print("Navigation tapped")
        }
    }
    .padding()
}
