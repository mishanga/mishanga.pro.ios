//
//  SettingsView.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var settings = SettingsStore.shared.read()
    @State private var showingClearAlert = false

    var body: some View {
        CustomBackground {
            VStack {
                // Main content
                ScrollView {
                    VStack(spacing: 16) {
                        Spacer().frame(height: 20)

                        VStack(spacing: 12) {
                            SettingsTextField(
                                title: "aim banner id",
                                placeholder: "Enter aim banner id",
                                text: $settings.aimBannerId
                            )

                            SettingsTextField(
                                title: "region id",
                                placeholder: "Enter region id",
                                text: $settings.regionId
                            )

                            SettingsTextField(
                                title: "uuid",
                                placeholder: "Enter uuid",
                                text: $settings.uuid
                            )

                            SettingsTextField(
                                title: "ad unit id",
                                placeholder: "Enter ad unit id",
                                text: $settings.adUnitId
                            )
                        }
                        .padding(.horizontal, 16)

                        Spacer().frame(height: 20)

                        // Clear button
                        PrimaryButton(text: "clear") {
                            showingClearAlert = true
                        }
                        .padding(.horizontal, 16)
                        .alert("Clear Settings", isPresented: $showingClearAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Clear", role: .destructive) {
                                clearSettings()
                            }
                        } message: {
                            Text("This will clear all saved settings. Are you sure?")
                        }

                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("settings")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: settings) { _ in
            saveSettings()
        }
        .onAppear {
            settings = SettingsStore.shared.read()
        }
    }

    private func saveSettings() {
        SettingsStore.shared.write(settings)
    }

    private func clearSettings() {
        SettingsStore.shared.clear()
        settings = AdSettings()
    }
}

#Preview {
    SettingsView()
}
