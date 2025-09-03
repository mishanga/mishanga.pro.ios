//
//  ToastView.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(message)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.bottom, 100)
                    Spacer()
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: isShowing)
        }
    }
}

// MARK: - Toast Manager
class ToastManager: ObservableObject {
    @Published var isShowing = false
    @Published var message = ""
    
    func show(_ message: String, duration: TimeInterval = 2.0) {
        self.message = message
        withAnimation {
            isShowing = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isShowing = false
            }
        }
    }
}

// MARK: - View Extension
extension View {
    func toast(isShowing: Binding<Bool>, message: String) -> some View {
        ZStack {
            self
            ToastView(message: message, isShowing: isShowing)
        }
    }
}

#Preview {
    VStack {
        Text("Main Content")
            .font(.title)
        
        Button("Show Toast") {
            // Toast will be shown
        }
    }
    .toast(isShowing: .constant(true), message: "This is a toast message!")
}
