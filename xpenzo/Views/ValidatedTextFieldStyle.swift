//
//  ValidatedTextFieldStyle.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 06/08/24.
//

import SwiftUI

struct ValidatedTextFieldStyle: TextFieldStyle {
    @FocusState private var isFocused: Bool
    var hasError: Bool
    var leadingText: String?
    
    private var borderColor: Color {
        if hasError {
            return Color.danger
        }
        if isFocused {
            return Color.accentColor
        }
        return Color.disabled
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let leadingText = leadingText {
                Text(leadingText)
                    .padding()
                    .background(.disabled)
            }
            configuration
                .focused($isFocused)
                .padding()
            
        }
        .background(Color.white.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 1.0)
        }
        .padding(1)
    }
}

#Preview {
    @State var text = ""
    
    return Group {
        TextField("Hola", text: $text)
            .textFieldStyle(ValidatedTextFieldStyle(hasError: false))
        
        TextField("Hola", text: $text)
            .textFieldStyle(ValidatedTextFieldStyle(hasError: true))
        
        TextField("Hola", text: $text)
            .textFieldStyle(ValidatedTextFieldStyle(hasError: false, leadingText: "$"))
    }
    .padding()
}
