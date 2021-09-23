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
  
  var body: some View {
    ZStack {
      viewModel.anniversaryType.bgColor.edgesIgnoringSafeArea(.all)
      Image(viewModel.anniversaryType.bgImageName).resizable()
        .edgesIgnoringSafeArea(.all)
        .frame(alignment: .bottom)
      BackButtonView { self.mode.wrappedValue.dismiss()}
      VStack(spacing: 0) {
        VStack(spacing: 0) {
          Spacer().frame(minHeight: 20).background(Color.blue)
          AgeTextView(titleText: viewModel.titleText, ageText: viewModel.ageTextImageName.ageText, ageImageName: viewModel.ageTextImageName.imageName)
          Spacer().frame(minHeight: 20).background(Color.blue)
        }
        CircleCameraIconView(anniversaryType: viewModel.anniversaryType, image: viewModel.imagePickerViewModel.image )
          .frame(maxHeight: .infinity)
          .onTapGesture {
            self.showingActionSheet = true
          }
        Image("nanitLogoDark").resizable().aspectRatio(contentMode: .fit).frame(width: 59, height: 20, alignment: .center).padding(.top, 15)
        Button(action: {
          
        }, label: {
          HStack(spacing: 3) {
            Text(shareTheNews).font(.system(size: 16.0))
            Image("shareWhiteSmall")
          }
        })
        .buttonStyle(GrowingButtonStyle())
        .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 88, trailing: 0))
      }
      .padding(.horizontal, 50)
    }
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

struct BackButtonView: View {
  let action: () -> Void
  var body: some View {
    VStack {
      HStack {
        Button(action: action, label: {
          Image("arrowBackBlue")
        }).padding(EdgeInsets.init(top: 7.5, leading: 11.0, bottom: 0, trailing: 0))
        Spacer()
      }
      Spacer()
    }
  }
}

struct AgeTextView: View {
  var titleText: String
  var ageText: String
  var ageImageName: String
  var body: some View {
    VStack {
      Text(titleText)
        .font(.system(size: 21.0, weight: .medium))
        .fixedSize(horizontal: false, vertical: true)
        .lineLimit(2)
        .multilineTextAlignment(.center)
      HStack {
        Image("leftSwirls")
        Image(ageImageName).padding(.horizontal, 22)
        Image("rightSwirls")
      }
      Text(ageText)
        .font(.system(size: 21.0))
        .multilineTextAlignment(.center)
    }
  }
}
