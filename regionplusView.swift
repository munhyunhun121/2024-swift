//
//  regionplusView.swift
//  2024
//
//  Created by 문현권 on 2024/6/30.
//

import SwiftUI

struct AddRegionView: View {
    @ObservedObject var viewModel: VisitViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var newRegionName = ""

    var body: some View {
        VStack {
            TextField("새로운 지역", text: $newRegionName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !newRegionName.isEmpty {
                    viewModel.addRegion(name: newRegionName)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("등록하기")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            Spacer()
        }
        .navigationTitle("Add Region")
        .padding()
    }
}
struct AddRegionView_Previews: PreviewProvider {
    static var previews: some View {
        AddRegionView(viewModel: VisitViewModel())
    }
}
