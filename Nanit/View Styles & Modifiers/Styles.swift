//
//  NANTextField.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import SwiftUI

struct GrowingButtonStyle: ButtonStyle {
  var isDisabled: Bool = false
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(height: 42)
      .padding(.horizontal)
      .background(self.isDisabled ? Color.gray : Color.blush)
      .foregroundColor(.white)
      .clipShape(Capsule())
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
