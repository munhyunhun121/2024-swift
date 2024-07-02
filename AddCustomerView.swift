//
//  AddCustomerView.swift
//  2024
//
//  Created by 문현권 on 2024/6/24.
//

import SwiftUI

struct AddCustomerView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: VisitViewModel
    @State private var customerName = ""
    @State private var selectedCustomerIDs = Set<UUID>()
    @State private var selectedRegion = "일산"
    
    
    @State private var showAlert = false  // 경고 메시지 표시 여부
    @State private var alertMessage = "ㄴㅇㄹㄴㅇㄹ"
    
    @State private var expandedRegions: [Bool] // regions 섹션 접는  1번
    
    
    @State private var isEditing = false //편집모드여부
    
    
    init(viewModel: VisitViewModel) {
           self.viewModel = viewModel
           self._expandedRegions = State(initialValue: Array(repeating: true, count: viewModel.regions.count))
       }
    
    
    
    var body: some View {
        VStack {
            //  ------------------------ 픽커뷰 에드 버튼 ---------------//
              HStack{
                  
               Spacer()
                  
                  Picker("Select Region", selection: $selectedRegion) {
                      ForEach(viewModel.regions, id: \.self) { region in
                          Text(region)
                      }
                  }
                  
                  NavigationLink(destination: AddRegionView(viewModel: viewModel)) {
                                     Text("+")
                                         .padding()
                                         .background(Color.blue)
                                         .foregroundColor(.white)
                                         .cornerRadius(8)
                                 }
                  .padding(.trailing, 20)
              }
              //  ------------------------ 픽커뷰 에드 버튼 ---------------//
            
            Spacer()
            
            
            
            List {
                           ForEach(viewModel.regions.indices, id: \.self) { index in
                               let region = viewModel.regions[index]
                               DisclosureGroup(
                                   isExpanded: $expandedRegions[index],
                                   content: {
                                       ForEach(viewModel.customers.filter { $0.region == region }, id: \.self) { customer in
                                           HStack {
                                               Text(customer.name)
                                               Spacer()
                                               if viewModel.selectedCustomerIDs.contains(customer.id) {
                                                        Image(systemName: "checkmark")
                                               }
                                           }
                                           .contentShape(Rectangle())
                                           .onTapGesture {
                                               if viewModel.selectedCustomerIDs.contains(customer.id) {
                                                   viewModel.selectedCustomerIDs.remove(customer.id)
                                               } else {
                                                   viewModel.selectedCustomerIDs.insert(customer.id)
                                               }
                                           }
                                       }
                                       .onDelete { offsets in
                                           let customersToDelete = offsets.map { viewModel.customers.filter { $0.region == region }[$0] }
                                           for customer in customersToDelete {
                                               if let index = viewModel.customers.firstIndex(of: customer) {
                                                   viewModel.customers.remove(at: index)
                                               }
                                           }
                                       }
                                   },
                                   label: {
                                       HStack {
                                           Text(region)
                                           Spacer()
                                           if isEditing {
                                               Button(action: {
                                                   if let index = viewModel.regions.firstIndex(of: region) {
                                                       viewModel.deleteRegion(at: IndexSet(integer: index))
                                                   }
                                               }) {
                                                   Image(systemName: "trash")
                                                       .foregroundColor(.red)
                                               }
                                           }
                                       }
                                   }
                               )
                           }
                                                }
                                            
            TextField("Customer Name", text: $customerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
                .navigationTitle("Add Customer")
                .padding()
            
            Button(action: {
                                   if customerName.isEmpty {
                                       alertMessage = "거래처를 입력해주세요"
                                       showAlert = true
                                   } else {
                                       viewModel.addCustomer(name: customerName, region: selectedRegion)
                                       customerName = ""  // 텍스트 필드 초기화
                                       hideKeyboard() // 다쓰고 키보드 닫는거 //펑션 필요함 밑에 펑션있음
                                   }
                
            }) {
                Text("거래처등록")
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("경고"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            
        }
        
        
        // ----------------------------------여기까지가 V스택 끝 --------------------------------------------
        .navigationTitle("Add Customer")
                   .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button(action: {
                               isEditing.toggle()
                           }) {
                               Text(isEditing ? "Done" : "Edit")
                           }
                       }
                   }
                   .padding()
               }
    
    private func hideKeyboard() {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  
       
    
    
    struct AddCustomerView_Previews: PreviewProvider {
        static var previews: some View {
            AddCustomerView(viewModel: VisitViewModel())
        }
    }
    
}
