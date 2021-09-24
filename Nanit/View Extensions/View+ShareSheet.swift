//
//  View+ShareSheet.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 24, 2021.
//

import Foundation
import UIKit
import SwiftUI

extension View {
  func shareSheet(image: UIImage) {
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
  }
}
