//
//  CustomBackground.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI

struct CustomBackground<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    .backgroundPrimary,
                    .backgroundSecondary,
                    .backgroundAccent
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Content
            content
        }
    }
}

#Preview {
    CustomBackground {
        VStack {
            Text("Example Content")
                .font(.title)
            Text("Custom Background Preview")
                .font(.body)
        }
    }
}
