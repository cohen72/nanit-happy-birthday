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
  
  let babyBirthdayRepository = BabyBirthdayRepository()
  
  @Published var isFormValid = false
  @Published var dateOfBirthPlaceholder: LocalizedStringKey = enterDateOfBirthLabel
  @Published var inputImage: UIImage?
  @Published var showingImagePicker = false
  @Published var showingCamera = false
  @Published var name: String = ""
  @Published var image: Image?
  @Published var dateOfBirth: Date = Date()
  
  private var didSetDateOfBirth = false {
    didSet {
      self.dateOfBirthPlaceholder = dateOfBirthLabel
    }
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
  
    self.loadSavedBirthday()
    
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
    
    $inputImage
      .receive(on: DispatchQueue.main)
      .sink { [weak self] inputImage in
        guard let self = self else { return }
        if let imageData = inputImage?.jpegData(compressionQuality: 1.0) {
          self.babyBirthdayRepository.save(imageData: imageData)
        }
      }.store(in: &cancellables)
  }
  
  func loadSavedBirthday() {
    self.name = babyBirthdayRepository.getName()
    
    if let date = babyBirthdayRepository.getDateOfBirth() {
      self.didSetDateOfBirth = true
      self.dateOfBirth = date
    }
    
    if let imageData = babyBirthdayRepository.getImageData() {
      self.inputImage = UIImage(data: imageData)
      self.loadImage()
    }
    
    self.updateFormValidity()
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
  }
  
  private func updateFormValidity() {
    guard self.name.count > 0, self.didSetDateOfBirth else {
      self.isFormValid = false
      return
    }
    self.isFormValid = true
  }
}

