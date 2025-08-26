//
//  ContentView.swift
//  mishanga.pro
//
//  Created by Mihail Troshev on 25.08.2025.
//

import SwiftUI

// Универсальный экран, который мы будем использовать для Banner, Interstitial и Rewarded
struct AdScreen: View {
    let title: String // Заголовок экрана, который мы передадим
    @Environment(\.presentationMode) var presentationMode // Для кнопки "Назад"
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            
            // Кнопка для возврата на главный экран
            Button("Back") {
                // Закрывает текущий экран и возвращает на предыдущий
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
    }
}


// Экран настроек будет почти таким же, но в будущем его можно будет сделать сложнее
struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            
            Text("Here will be settings later...")
                .padding()
            
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Кнопка "Banner"
                NavigationLink(destination: AdScreen(title: "Banner")) {
                    Text("Banner")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Кнопка "Interstitial"
                NavigationLink(destination: AdScreen(title: "Interstitial")) {
                    Text("Interstitial")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Кнопка "Rewarded"
                NavigationLink(destination: AdScreen(title: "Rewarded")) {
                    Text("Rewarded")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Кнопка "Settings"
                NavigationLink(destination: SettingsScreen()) {
                    Text("Settings")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer() // Разделитель, который толкает контент вверх
            }
            .padding() // Отступы вокруг всего VStack
            .navigationTitle("Main Screen") // Заголовок главного экрана
        }
    }
}

#Preview {
    ContentView()
}
