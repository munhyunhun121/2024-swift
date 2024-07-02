import SwiftUI

struct VisitUIView: View {
    @StateObject private var viewModel = VisitViewModel()
    @State private var selectedCustomer: Customer?
    @State private var selectedDate = Date()
    @State private var showVisitsOnSelectedDate = false
    @State private var visitsOnSelectedDate: [Customer] = []
    @State private var showCalendar = true
    
    var body: some View {
        NavigationView {
            VStack {
                  
                
                
                    
                    // -------------------- 디스클로저그룹으로 달력접기  -----------------------
                        
                DisclosureGroup(
                    isExpanded: $showCalendar,
                            content: {
                                DatePicker(
                                    "Select Date",
                                    selection: $selectedDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding()
                            },
                            label: {
                                HStack {
                                    Spacer()
                                    Text("캘린더 펼치기")
                                    Spacer()
                                }
                            }
                        )
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 4)

                     
                    
                    // -------------------- 디스클로저그룹으로 달력접기  -----------------------
               
                
                
                
                
                
                
                
                // --------------------  카운트 텍스트 뷰 -----------------------
                
                    Text("거래처 수: \(viewModel.customers.count)")
                        .font(.headline)
                        .padding()
                 
                    Text("Selected Customers: \(viewModel.selectedCustomerCount)")
                                  .font(.headline)
                                  .padding()
                    
                // --------------------  카운트 텍스트 뷰 -----------------------
                
                
                
                
                
                
                
                
                
                    // -------------------- 거래처등록버튼 -----------------------
                    
                    NavigationLink(destination: AddCustomerView(viewModel: viewModel)) {
                        Text("거래처 확인")
                            .frame(width: 150, height: 35)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    // -------------------- 거래처등록버튼 -----------------------
                    
         
                
                

               Spacer()
            }
            // -------------------- 위 괄호가 V스텍 끝부분 ----------------------- //
     
                //.navigationTitle("Customer Visits")
        }
    }
}

struct VisitUIView_Previews: PreviewProvider {
    static var previews: some View {
        VisitUIView()
    }
}
