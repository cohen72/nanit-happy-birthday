//
//  Extensions.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI


struct CircleCameraIconView: View {
  let anniversaryType: AnniversaryType
  var iconScale: CGFloat = 0.2
  
  private func calculateCameraSize(_ geo: GeometryProxy) -> CGFloat {
    return geo.size.height * iconScale
  }
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        Circle().stroke(anniversaryType.color, lineWidth: 2)
        VStack {
          anniversaryType.cameraIconImage.resizable().scaledToFit().frame(width: calculateCameraSize(geo), height: calculateCameraSize(geo), alignment: Alignment.top)
            .rotationEffect(Angle(degrees: -45.0))
            .offset(y: -calculateCameraSize(geo)/2.0)
            
          Spacer()
        }
      }.rotationEffect(Angle(degrees: 45.0))
    }
  }
}


