//
//  Extensions.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI


struct CircleCameraIconView: View {
  var anniversaryType: AnniversaryType = .blue
  var iconSize: CGFloat = 36.0
  var image: Image?
  var borderWidth: CGFloat = 6.0
  
  var body: some View {
    ZStack {
      Group {
        if image != nil {
          image?.resizable().aspectRatio(1.0, contentMode: .fill).layoutPriority(-1).clipShape(Circle())
        } else {
          anniversaryType.placeHolderImage.resizable().aspectRatio(1.0, contentMode: .fill).clipShape(Circle())
        }
      }
      Circle().stroke(anniversaryType.color, lineWidth: borderWidth)
      VStack {
        anniversaryType.cameraIconImage.resizable().scaledToFit()
          .frame(width: iconSize, height: iconSize, alignment: Alignment.top)
          .rotationEffect(Angle(degrees: -45.0))
          .offset(y: -iconSize/2.0)
        Spacer()
      }
      .rotationEffect(Angle(degrees: 45.0))
    }
    .aspectRatio(1.0, contentMode: .fit)
  }
}


