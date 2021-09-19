//
//  Modifiers.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import SwiftUI

struct FormFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(Color.darkBlue)
      .font(.body)
      .frame(height: 60)
      .padding(.horizontal, 20)
      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))
  }
}
