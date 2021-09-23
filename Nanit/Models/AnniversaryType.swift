//
//  AnniversaryType.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI

enum AnniversaryType: Int {
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
  
  var bgColor: Color {
    switch self {
    case .blue:
      return Color.lightBlueGrey
    case .green:
      return Color.lightBlueGreyTwo
    case .yellow:
      return Color.pale
    }
  }
  
  var bgImageName: String {
    switch self {
    case .blue:
      return "bgPelican"
    case .green:
      return "bgFox"
    case .yellow:
      return "bgElephant"
    }
  }
  
  static var randomAnniversaryType: AnniversaryType {
    let randomInt = Int.random(in: 1..<4)
    return AnniversaryType(rawValue: randomInt) ?? AnniversaryType.blue
  }
}
