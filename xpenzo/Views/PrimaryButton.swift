//
//  PrimaryButton.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 05/08/24.
//

import SwiftUI

struct PrimaryButton: View {
    var localizedStringKey: LocalizedStringKey
    var isEnabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(localizedStringKey, action: action)
        .disabled(!isEnabled)
        .frame(maxWidth: .infinity)
        .padding()
        .background(isEnabled ? .accent : .disabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    PrimaryButton(localizedStringKey: "Button", isEnabled: true) {
        print("Hello world")
    }
}
