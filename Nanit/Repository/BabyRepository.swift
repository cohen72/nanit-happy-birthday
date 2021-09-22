//
//  BabyRepository.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI

protocol BirthdayAPI {
  func save(name: String)
  func save(dateOfBirth: Date)
  func save(imageData: Data)
  func getName() -> String
  func getDateOfBirth() -> Date?
  func getImageData() -> Data?
}

class BabyBirthdayRepository: ObservableObject, BirthdayAPI {
    
  var birthdayDB: BabyBirthdayDB = BabyBirthdayDB()
  
  func save(name: String) {
    self.birthdayDB.save(name: name)
  }
  
  func save(dateOfBirth: Date) {
    self.birthdayDB.save(dateOfBirth: dateOfBirth)
  }
  
  func save(imageData: Data) {
    self.birthdayDB.save(imageData: imageData)
  }
  
  func getName() -> String {
    return self.birthdayDB.getName()
  }
  
  func getDateOfBirth() -> Date? {
    return self.birthdayDB.getDateOfBirth()
  }
  
  func getImageData() -> Data? {
    return self.birthdayDB.getImageData()
  }
}

class BabyBirthdayDB: BirthdayAPI {
  
  private let nameKey = "name"
  private let dateOfBirthKey = "dateOfBirth"
  private let imageDataKey = "imageData"
  
  func getName() -> String {
    if let name = UserDefaults.standard.string(forKey: nameKey) {
      return name
    }
    return ""
  }
  
  func getDateOfBirth() -> Date? {
    let dob = UserDefaults.standard.double(forKey: dateOfBirthKey)
    if dob == 0.0 {
      return nil
    }
    return Date(timeIntervalSince1970:  UserDefaults.standard.double(forKey: dateOfBirthKey))
  }
  
  func getImageData() -> Data? {
    if let imageData = UserDefaults.standard.data(forKey: imageDataKey) {
      return imageData
    }
    return nil
  }
  
  func save(name: String) {
    UserDefaults.standard.set(name, forKey: nameKey)
  }
  
  func save(dateOfBirth: Date) {
    UserDefaults.standard.set(dateOfBirth.timeIntervalSince1970, forKey: dateOfBirthKey)
  }
  
  func save(imageData: Data) {
    UserDefaults.standard.setValue(imageData, forKey: imageDataKey)
  }
}
