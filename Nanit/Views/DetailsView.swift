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
          CircleCameraIconView(iconSize: 20, image: viewModel.imagePickerViewModel.image, borderWidth: 3.0)
          .frame(width: 60, height: 60, alignment: .center)
          .onTapGesture {
            self.showingActionSheet = true
          }
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
      .sheet(isPresented: $viewModel.imagePickerViewModel.isPresentingImagePicker, onDismiss: viewModel.imagePickerViewModel.loadImage) {
        ImagePicker(image: $viewModel.imagePickerViewModel.selectedImage, sourceType: viewModel.imagePickerViewModel.sourceType)
      }
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(imagePickerViewModel: viewModel.imagePickerViewModel)
      }
      .onAppear {
        viewModel.updateView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    DetailsView()
  }
}
