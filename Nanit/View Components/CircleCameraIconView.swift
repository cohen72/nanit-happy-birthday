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
  var hideCameraIcon: Bool = false
  private let cameraIconAngle: Double = 45.0
  var action: () -> Void = {}
  
  var body: some View {
    ZStack {
      Group {
        if image != nil {
          image?.resizable().aspectRatio(contentMode: .fill).layoutPriority(-1).clipShape(Circle())
        } else {
          anniversaryType.placeHolderImage.resizable().aspectRatio(contentMode: .fill).clipShape(Circle())
        }
      }
      Circle().stroke(anniversaryType.color, lineWidth: borderWidth)
      VStack {
        anniversaryType.cameraIconImage.resizable().scaledToFit()
          .frame(width: iconSize, height: iconSize, alignment: Alignment.top)
          .rotationEffect(Angle(degrees: -cameraIconAngle))
          .offset(y: -iconSize/2.0)
        Spacer()
      }
      .rotationEffect(Angle(degrees: cameraIconAngle))
      .opacity(hideCameraIcon ? 0.0 : 1.0)
      .onTapGesture {
        self.action()
      }
    }
    .aspectRatio(1.0, contentMode: .fit)
  }
}


