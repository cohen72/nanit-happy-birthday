//
//  AgeTextView.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 24, 2021.
//

import SwiftUI

struct AgeTextView: View {
  var titleText: String
  var ageText: String
  var ageImageName: String
  var body: some View {
    VStack {
      Text(titleText)
        .font(.system(size: 21.0, weight: .medium))
        .fixedSize(horizontal: false, vertical: true)
        .lineLimit(2)
        .multilineTextAlignment(.center)
      HStack {
        Image("leftSwirls")
        Image(ageImageName).padding(.horizontal, 22)
        Image("rightSwirls")
      }
      Text(ageText)
        .font(.system(size: 21.0))
        .multilineTextAlignment(.center)
    }
  }
}

struct AgeTextView_Previews: PreviewProvider {
  static var previews: some View {
    AgeTextView(titleText: "TITLE", ageText: "MONTH", ageImageName: "1")
  }
}
