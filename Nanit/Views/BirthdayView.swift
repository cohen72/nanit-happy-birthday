//
//  BirthdayView.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 19, 2021.
//

import SwiftUI

struct BirthdayView: View {
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @ObservedObject private var viewModel: BirthdayViewModel = BirthdayViewModel()
  @State private var showingActionSheet = false
  
  func mainView(isSnapshot: Bool = false) -> some View {
    return ZStack {
      viewModel.anniversaryType.bgColor.edgesIgnoringSafeArea(.all)
      Image(viewModel.anniversaryType.bgImageName).resizable().edgesIgnoringSafeArea(.all).frame(alignment: .bottom)
      BackButtonView { self.mode.wrappedValue.dismiss()}.opacity(isSnapshot ? 0.0 : 1.0)
      VStack(spacing: 0) {
        VStack(spacing: 0) {
          VStack(spacing: 0) {
            Spacer().frame(minHeight: 20).background(Color.blue)
            AgeTextView(titleText: viewModel.titleText, ageText: viewModel.ageTextImageName.ageText, ageImageName: viewModel.ageTextImageName.imageName)
            Spacer().frame(minHeight: 20).background(Color.blue)
          }
          CircleCameraIconView(anniversaryType: viewModel.anniversaryType, image: viewModel.imagePickerViewModel.image, hideCameraIcon: isSnapshot) {
            self.showingActionSheet = true
          }
          .frame(maxHeight: .infinity)
          Image("nanitLogoDark").resizable().aspectRatio(contentMode: .fit).frame(width: 59, height: 20, alignment: .center).padding(.top, 15)
        }
        Button(action:{
          shareSheet(image: mainView(isSnapshot: true).snapshot())
        }, label: {
          HStack(spacing: 3) {
            Text(shareTheNews).font(.system(size: 16.0))
            Image("shareWhiteSmall")
          }
        })
        .buttonStyle(GrowingButtonStyle())
        .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 88, trailing: 0))
        .opacity(isSnapshot ? 0.0 : 1.0)
      }
      .padding(.horizontal, 50)
    }
  }
  
  var body: some View {
    mainView()
      .navigationBarHidden(true)
      .onAppear {
        viewModel.updateView()
      }
      .sheet(isPresented: $viewModel.imagePickerViewModel.isPresentingImagePicker, onDismiss: viewModel.imagePickerViewModel.loadImage) {
        ImagePicker(image: $viewModel.imagePickerViewModel.selectedImage, sourceType: viewModel.imagePickerViewModel.sourceType)
      }
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(imagePickerViewModel: viewModel.imagePickerViewModel)
      }
  }
}

struct BirthdayView_Previews: PreviewProvider {
  static var previews: some View {
    BirthdayView()
  }
}

