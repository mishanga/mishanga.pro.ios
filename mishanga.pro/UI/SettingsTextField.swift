//
//  SettingsTextField.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI

struct SettingsTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}

#Preview {
    VStack {
        SettingsTextField(
            title: "ad unit id",
            placeholder: "Enter ad unit id",
            text: .constant("")
        )
        
        SettingsTextField(
            title: "uuid",
            placeholder: "Enter uuid",
            text: .constant("test-uuid")
        )
    }
    .padding()
}
