import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var showCalendar = false
    
    var body: some View {
        NavigationView {
            VStack {
                DisclosureGroup("Select Date", isExpanded: $showCalendar) {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxWidth: 400, maxHeight: 280)
                    .padding()
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Calendar")
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
