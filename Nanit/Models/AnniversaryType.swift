//
//  AnniversaryType.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI

enum AnniversaryType {
  case blue
  case green
  case yellow
  
  var cameraIconImage: Image {
    switch self {
    case .blue:
      return Image("cameraIconBlue")
    case .green:
      return Image("cameraIconGreen")
    case .yellow:
      return Image("cameraIconYellow")
    }
  }
  
  var placeHolderImage: Image {
    switch self {
    case .blue:
      return Image("defaultPlaceHolderBlue")
    case .green:
      return Image("defaultPlaceHolderGreen")
    case .yellow:
      return Image("defaultPlaceHolderYellow")
    }
  }
  
  var color: Color {
    switch self {
    case .blue:
      return Color.lightTeal
    case .green:
      return Color.paleTeal
    case .yellow:
      return Color.goldenYellow
    }
  }
}
