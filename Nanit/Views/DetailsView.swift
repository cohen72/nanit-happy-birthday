//
//  DetailsView.swift
//  Nanit
//
//  Created by Yehuda Oren Cohen on Sep 14, 2021.
//

import SwiftUI

struct DetailsView: View {
  
  @State var name: String = ""
  @State var date: Date = Date()
  
  var body: some View {
    NavigationView {
      VStack(alignment: HorizontalAlignment.center, spacing: 20, content: {
        Image("nanitLogoDark").resizable().aspectRatio(contentMode: .fit).frame(width: 100, alignment: .center)
        HStack {
          Image(systemName: "person").foregroundColor(.gray)
          TextField("Name", text: $name)
        }.modifier(FormFieldModifier())
        HStack {
          Image(systemName: "calendar").foregroundColor(.gray)
          DatePicker("", selection: $date, displayedComponents: .date)
        }.modifier(FormFieldModifier())
        VStack {
          Image("defaultPlaceHolderBlue").resizable().scaledToFit()
            .frame(width: 60, height: 60, alignment: .center)
            .clipShape(Circle())
          Spacer()
        }
        Spacer()
        NavigationLink(destination: BirthdayView()) {
          Text("Show Detail View").padding(.horizontal, 20)
        }
        .buttonStyle(GrowingButtonStyle())
        
      }).padding()
      .navigationTitle("")
      .navigationBarHidden(true)
      .background(Color.white.edgesIgnoringSafeArea(.all))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    DetailsView()
  }
}
