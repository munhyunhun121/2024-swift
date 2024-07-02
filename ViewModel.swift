//
//  ViewModel.swift
//  2024
//
//  Created by 문현권 on 2024/6/24.
//

import Foundation
import Combine

class VisitViewModel: ObservableObject {
    
    @Published var customers: [Customer] = [] {        // 1번  커스터머 추가 유저데포트
          didSet {
              saveCustomers()
          }
      }
    
    
    @Published var selectedCustomerIDs = Set<UUID>() {
          didSet {
              selectedCustomerCount = selectedCustomerIDs.count
              saveSelectedCustomers()
          }
      }
    
    @Published var selectedCustomerCount = 0
    
    
    
    @Published var visits: [Visit] = []
    @Published var regions: [String] = []        // 1번  regions 변수 설정
    
    
    
    
    
    //----------------------------- 각종 키  --------------------- //
    
    private let customersKey = "customersKey"  // 2번  커스터머 키 추가 유저데포트
    private let selectedCustomersKey = "selectedCustomersKey" // 셀릭티드 커스터머 키
    private let regionsKey = "regionsKey" // 4번 regionskey 추가
    
    //----------------------------- 각종 키  --------------------- //
    
    
    
    
    
    
    
    
    //----------------------------- init 설정  --------------------- //
    
    
    init() {
        loadRegions()
        loadCustomers()
        loadSelectedCustomers()  // 3번  인잇 커스터머 추가 유저데포트
      }                   //6번 인잇 추가
    
    
    //----------------------------- init 설정  --------------------- //
    
    
    
    
    
    
    
    func addRegion(name: String) {
        if !regions.contains(name) {
            regions.append(name)
            saveRegions()      // 2번  saveregions 펑션 추가
        }
    }
    
    private func saveCustomers() {    // 4번 커스터머 세이브 추가
          if let encodedData = try? JSONEncoder().encode(customers) {
              UserDefaults.standard.set(encodedData, forKey: customersKey)
          }
      }
    
    private func loadCustomers() {   //5번 로드 커스터머 추가
           if let savedData = UserDefaults.standard.data(forKey: customersKey),
              let decodedData = try? JSONDecoder().decode([Customer].self, from: savedData) {
               customers = decodedData
           }
       }
    
    
    func deleteCustomer(at offsets: IndexSet) {  //. 커스터머 삭제 펑션 
           customers.remove(atOffsets: offsets)
       }
    
    
    
    private func saveRegions() {
          UserDefaults.standard.set(regions, forKey: regionsKey)   //3 번  saveregions 펑션 추가
      }
    
    private func loadRegions() {    //5 번  loadRegions 축사
        if let savedRegions = UserDefaults.standard.stringArray(forKey: regionsKey) {
            regions = savedRegions
        } else {
            regions = ["파주", "일산", "김포"]  // 기본값 설정
        }
    }
    
    func deleteRegion(at offsets: IndexSet) {
           regions.remove(atOffsets: offsets)
           saveRegions()    // 지역 삭제 시 저장     삭제는 이거 하나 펑션으로 됨
       }
    
    
    func addCustomer(name: String, region: String) {
           let newCustomer = Customer(name: name, region: region)
           customers.append(newCustomer)
            
       }
    
    
//----------------------------- 셀렉티드 커스터머  --------------------- //           save와 load,    설정후  in init 설정도 해야되고 키설정도해야되고
    private func saveSelectedCustomers() {
         let encodedData = Array(selectedCustomerIDs).map { $0.uuidString }
         UserDefaults.standard.set(encodedData, forKey: selectedCustomersKey)
     }
    
    private func loadSelectedCustomers() {
            if let savedData = UserDefaults.standard.stringArray(forKey: selectedCustomersKey) {
                selectedCustomerIDs = Set(savedData.compactMap { UUID(uuidString: $0) })
            }
        }
    //----------------------------- 셀렉티드 커스터머  --------------------- //
}

