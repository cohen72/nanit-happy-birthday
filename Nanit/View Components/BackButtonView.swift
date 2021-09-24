//
//  BackButtonView.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 23, 2021.
//

import SwiftUI

struct BackButtonView: View {
  let action: () -> Void
  var body: some View {
    VStack {
      HStack {
        Button(action: action, label: {
          Image("arrowBackBlue")
        }).padding(EdgeInsets.init(top: 7.5, leading: 11.0, bottom: 0, trailing: 0))
        Spacer()
      }
      Spacer()
    }
  }
}
