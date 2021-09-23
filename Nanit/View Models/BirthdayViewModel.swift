//
//  BirthdayViewModel.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 22, 2021.
//

import Foundation

struct AgeTextImageName {
  let imageName: String
  let ageText: String
}

class BirthdayViewModel: ObservableObject {
  
  let babyBirthdayRepository = BabyBirthdayRepository()
  @Published var anniversaryType = AnniversaryType.randomAnniversaryType
  @Published var ageTextImageName = AgeTextImageName(imageName: "1", ageText: "MONTH OLD")
  @Published var imagePickerViewModel = ImagePickerViewModel()
  @Published var titleText: String = ""
  
  func updateView() {
    self.anniversaryType = AnniversaryType.randomAnniversaryType
    self.titleText = "TODAY \(babyBirthdayRepository.getName().uppercased()) IS"
    self.imagePickerViewModel.updateView()
    
    guard let dob = babyBirthdayRepository.getDateOfBirth() else {
      return
    }
    
    let comps = Calendar.current.dateComponents([.year, .month, .day], from: dob)
    let birthdate = DateComponents(year: comps.year, month: comps.month, day: comps.day)
    let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let ageComponents = Calendar.current.dateComponents([.year, .month], from: birthdate, to: now)
    
    guard let month = ageComponents.month, let year = ageComponents.year else { return }
    
    switch year {
    case 0:
      self.ageTextImageName = AgeTextImageName(imageName: "\(month)", ageText: "MONTH OLD")
    case 1...12:
      self.ageTextImageName =  AgeTextImageName(imageName: "\(year)", ageText: "YEAR OLD")
    default: break
    }
  }
}
