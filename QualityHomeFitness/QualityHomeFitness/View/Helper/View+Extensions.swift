//
//  View+Extensions.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI

extension View {
    func disableWithOpacity(_ condition: Bool) -> some View {
        self.disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment:  alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment:  alignment)
    }
    
    func border(_ width: CGFloat, _ color: Color) -> some View {
        self.padding(.horizontal,15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(color, lineWidth:width )
            }
    }
    
    func fillView( _ color: Color) -> some View {
        self.padding(.horizontal,15)
            .padding(.vertical, 15)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(color)
            }
    }
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    // MARK: CustomTextField
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value:Binding<String>) -> some View{
        
        VStack(alignment: .leading,spacing: 12) {
            Label{
                Text(title)
                    .font(.callout)
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") {
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else {
                TextField(hint,text: value)
                    .padding(.top, 2)
            }
            
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
    }
    
    
    
}
