//
//  DetailsViewModel.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import Foundation
import SwiftUI
import Combine

class DetailsViewModel: ObservableObject {
  
  private let babyBirthdayRepository = BabyBirthdayRepository()
  
  @Published var imagePickerViewModel = ImagePickerViewModel()
  @Published var isFormValid = false
  @Published var dateOfBirthPlaceholder: LocalizedStringKey = enterDateOfBirthLabel
  @Published var name: String = ""
  @Published var dateOfBirth: Date = Date()
  
  private var didSetDateOfBirth = false {
    didSet {
      self.dateOfBirthPlaceholder = dateOfBirthLabel
    }
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    self.updateView()
    
    $name
      .receive(on: DispatchQueue.main)
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .sink { [weak self] name in
        guard let self = self else { return }
        self.babyBirthdayRepository.save(name: self.name)
        self.updateFormValidity()
      }.store(in: &cancellables)
    
    $dateOfBirth
      .receive(on: DispatchQueue.main)
      .dropFirst()
      .sink { [weak self] date in
        guard let self = self else { return }
        self.didSetDateOfBirth = true
        self.babyBirthdayRepository.save(dateOfBirth: date)
        self.updateFormValidity()
      }.store(in: &cancellables)
  }
  
  func updateView() {
    self.name = babyBirthdayRepository.getName()
    
    if let date = babyBirthdayRepository.getDateOfBirth() {
      self.didSetDateOfBirth = true
      self.dateOfBirth = date
    }
    
    self.imagePickerViewModel.updateView()
    
    self.updateFormValidity()
  }
  
  private func updateFormValidity() {
    guard self.name.count > 0, self.didSetDateOfBirth else {
      self.isFormValid = false
      return
    }
    self.isFormValid = true
  }
}

