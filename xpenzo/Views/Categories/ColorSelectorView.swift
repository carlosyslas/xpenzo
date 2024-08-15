//
//  ColorSelectorView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI

struct ColorSelectorView: View {
    @Binding var selectedColor: CategoryColor
    
    var body: some View {
        HStack {
            ForEach(CategoryColor.allCases, id: \.rawValue) { color in
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.foreground)
                    .strokeBorder(selectedColor == color ? .black : .clear, lineWidth: 3)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

#Preview {
    @State var selectedColor = CategoryColor.color1
    
    return ColorSelectorView(selectedColor: $selectedColor)
}
