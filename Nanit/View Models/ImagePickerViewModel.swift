//
//  ImagePickerViewModel.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 23, 2021.
//

import Foundation
import SwiftUI
import UIKit
import Combine

final class ImagePickerViewModel: ObservableObject {
  
  private let babyBirthdayRepository = BabyBirthdayRepository()
  @Published var image: Image?
  @Published var selectedImage: UIImage?
  @Published var isPresentingImagePicker = false
  private(set) var sourceType: UIImagePickerController.SourceType = .camera
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $selectedImage
      .receive(on: DispatchQueue.main)
      .sink { [weak self]  selectedImage in
        guard let self = self else { return }
        if let imageData = selectedImage?.jpegData(compressionQuality: 0.5) {
          self.babyBirthdayRepository.save(imageData: imageData)
        }
      }.store(in: &cancellables)
  }
  
  func updateView() {
    if let imageData = babyBirthdayRepository.getImageData() {
      self.selectedImage = UIImage(data: imageData)
      self.loadImage()
    }
  }
  
  func choosePhoto() {
    sourceType = UIImagePickerController.SourceType.photoLibrary
    isPresentingImagePicker = true
  }
  
  func takePhoto() {
    sourceType = UIImagePickerController.SourceType.camera
    isPresentingImagePicker = true
  }
  
  func didSelectImage(_ image: UIImage?) {
    selectedImage = image
    isPresentingImagePicker = false
  }
  
  func loadImage() {
    guard let selectedImage = selectedImage else { return }
    image = Image(uiImage: selectedImage)
  }    
}

extension ActionSheet {
  
  init(imagePickerViewModel: ImagePickerViewModel) {
    
    self.init(title: Text("Choose a picture"), buttons: [
      ActionSheet.Button.default(Text("Photo Library")) {
        imagePickerViewModel.choosePhoto()
      },
      ActionSheet.Button.default(Text("Camera")) {
        #if !targetEnvironment(simulator)
        imagePickerViewModel.takePhoto()
        #endif
      },
      ActionSheet.Button.cancel()
    ]
    )
  }
}
