import SwiftUI

struct UpdateStatusView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var repository = CaseRepository.shared
    let caseItem: Case
    
    @State private var selectedStatus: Case.CaseStatus
    
    init(caseItem: Case) {
        self.caseItem = caseItem
        _selectedStatus = State(initialValue: caseItem.status)
    }
    
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
                
                Text("Update Status")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Divider()
                .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Select new status for \(caseItem.patientName)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                    .padding(.top, 20)
                
                VStack(spacing: 12) {
                    ForEach(Case.CaseStatus.allCases, id: \.self) { status in
                        StatusOptionRow(status: status, isSelected: selectedStatus == status) {
                            selectedStatus = status
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    updateStatus()
                } label: {
                    Text("Update Status")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0/255, green: 122/255, blue: 255/255))
                        )
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
    
    private func updateStatus() {
        if let index = repository.cases.firstIndex(where: { $0.id == caseItem.id }) {
            repository.cases[index].status = selectedStatus
            repository.cases[index].lastUpdated = Date()
        }
        dismiss()
    }
}

private struct StatusOptionRow: View {
    let status: Case.CaseStatus
    let isSelected: Bool
    let action: () -> Void
    
    var statusColor: Color {
        switch status {
        case .active: return Color(red: 7/255, green: 136/255, blue: 59/255)
        case .pending: return Color(red: 245/255, green: 158/255, blue: 11/255)
        case .completed: return Color(red: 59/255, green: 130/255, blue: 246/255)
        case .archived: return Color(red: 107/255, green: 114/255, blue: 128/255)
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Circle()
                    .fill(statusColor.opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .fill(statusColor)
                            .frame(width: 12, height: 12)
                    )
                
                Text(status.rawValue)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 0/255, green: 122/255, blue: 255/255))
                        .font(.system(size: 22))
                } else {
                    Circle()
                        .stroke(Color(red: 207/255, green: 215/255, blue: 231/255), lineWidth: 1)
                        .frame(width: 22, height: 22)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(red: 0/255, green: 122/255, blue: 255/255) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

extension Case.CaseStatus: CaseIterable {
    public static var allCases: [Case.CaseStatus] {
        return [.active, .pending, .completed, .archived]
    }
}
