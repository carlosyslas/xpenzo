//
//  IconSelectorView.swift
//  xpenzo
//
//  Created by Carlos Yslas Altamirano on 02/08/24.
//

import SwiftUI

struct IconSelectorView: View {
    @Binding var selectedIcon: CategoryIcon
    var color: CategoryColor
    
    private let columns = [
        GridItem(.flexible(minimum: 10, maximum: 300)),
        GridItem(.flexible(minimum: 10, maximum: 300)),
        GridItem(.flexible(minimum: 10, maximum: 300)),
        GridItem(.flexible(minimum: 10, maximum: 300)),
        GridItem(.flexible(minimum: 10, maximum: 300)),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(CategoryIcon.allCases, id: \.rawValue) { icon in
                VStack(alignment: .center) {
                    Image(systemName: icon.rawValue)
                        .resizable()
                        .scaledToFit()
                }
                .aspectRatio(1, contentMode: .fill)
                .padding()
                .background(selectedIcon == icon ? color.background : Color.disabledIconBackground)
                .foregroundStyle(selectedIcon == icon ? color.foreground : Color.disabledIconForeground)
                
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    selectedIcon = icon
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(selectedIcon == icon ? color.foreground : Color.disabledIconForeground, lineWidth: 2)
                }
                .opacity(selectedIcon == icon ? 1 : 0.5)
            }
        }
        .padding(1)
    }
}

#Preview {
    IconSelectorView(selectedIcon: .constant(.carrot), color: .color1)
}
