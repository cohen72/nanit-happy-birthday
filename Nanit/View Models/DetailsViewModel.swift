//
//  DetailsViewModel.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject {
  
  @Published var isFormValid = false
  @Published var dateOfBirthPlaceholder: LocalizedStringKey = enterDateOfBirthLabel
  
  @Published var dateOfBirth: Date = Date() {
    didSet {
      self.dateOfBirthPlaceholder = dateOfBirthLabel
      self.save()
    }
  }
  @Published var name: String = "" {
    didSet {
      self.save()
    }
  }
    
  private func save() {
    guard self.name.count > 0, self.dateOfBirthPlaceholder != enterDateOfBirthLabel else {
      self.isFormValid = false
      return
    }
    self.isFormValid = true
  }
}

