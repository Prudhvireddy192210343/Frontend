import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notifications = [
        NotificationData(title: "New Case Assigned", message: "A new patient case (ID: 20240715-003) has been assigned to you.", time: "2h ago", isNew: true),
        NotificationData(title: "Plan Approved", message: "Your treatment plan for Raju has been approved by the clinical director.", time: "5h ago", isNew: true),
        NotificationData(title: "Scan Uploaded", message: "Intraoral scans for Ethan Harper have been successfully uploaded.", time: "Yesterday", isNew: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Notifications")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                if !notifications.isEmpty {
                    Button {
                        withAnimation {
                            notifications.removeAll()
                        }
                    } label: {
                        Text("Clear All")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)
                    }
                } else {
                    Color.clear.frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            if notifications.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "bell.slash")
                        .font(.system(size: 64))
                        .foregroundColor(.gray.opacity(0.3))
                    Text("No new notifications")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(notifications) { notification in
                            NotificationRow(title: notification.title, message: notification.message, time: notification.time, isNew: notification.isNew)
                        }
                    }
                }
            }
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

struct NotificationData: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
    let isNew: Bool
}

private struct NotificationRow: View {
    let title: String
    let message: String
    let time: String
    let isNew: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(isNew ? Color.blue : Color.gray.opacity(0.3))
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                
                Text(time)
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                    .padding(.top, 2)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
    }
}

#Preview {
    NotificationsView()
}
