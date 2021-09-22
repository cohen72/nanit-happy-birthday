//
//  DetailsView.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 14, 2021.
//

import SwiftUI

struct DetailsView: View {
  
  @ObservedObject private(set) var viewModel = DetailsViewModel()
  @State private var showingActionSheet = false
  
  var body: some View {
    NavigationView {
      VStack(alignment: HorizontalAlignment.center, spacing: 20, content: {
        Image("nanitLogoDark").resizable().aspectRatio(contentMode: .fit).frame(width: 100, alignment: .center)
        HStack {
          Image(systemName: "person").foregroundColor(.gray)
          TextField("Name", text: $viewModel.name)
        }.modifier(FormFieldModifier())
        HStack {
          Image(systemName: "calendar").foregroundColor(.gray)
          DatePicker(viewModel.dateOfBirthPlaceholder, selection: $viewModel.dateOfBirth, in: ...Date(), displayedComponents: .date)
        }.modifier(FormFieldModifier())
        VStack {
          Group {
            if viewModel.image != nil {
              viewModel.image?.resizable().scaledToFill()
            } else {
              Image("defaultPlaceHolderBlue").resizable().scaledToFit()
            }
          }
          .frame(width: 60, height: 60, alignment: .center)
          .clipShape(Circle())
          .overlay(CircleCameraIconView(anniversaryType: .blue, iconScale: 0.4))
          .onTapGesture {
            self.showingActionSheet = true
          }
          Spacer()
        }
        Spacer()
        NavigationLink(destination: BirthdayView()) {
          Text("Show Detail View").padding(.horizontal, 20)
        }
        .buttonStyle(GrowingButtonStyle(isDisabled: !viewModel.isFormValid))
        .disabled(!viewModel.isFormValid)
      }).padding()
      .navigationTitle("")
      .navigationBarHidden(true)
      .background(Color.white.edgesIgnoringSafeArea(.all))
      .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: viewModel.loadImage) {
        ImagePicker(image: $viewModel.inputImage)
      }
      .sheet(isPresented: $viewModel.showingCamera, onDismiss: viewModel.loadImage) {
        ImagePicker(image: $viewModel.inputImage, sourceType: UIImagePickerController.SourceType.camera)
      }
      .actionSheet(isPresented: $showingActionSheet) {
          ActionSheet(title: Text("Choose a Picture"), buttons: [
              .default(Text("Camera")) {
                #if !targetEnvironment(simulator)
                  viewModel.showingCamera = true
                #endif
              },
              .default(Text("Photo Library")) {
                viewModel.showingImagePicker = true
              },
              .cancel()
          ])
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    DetailsView()
  }
}
