import SwiftUI

// MARK: - Chief Complaint View (Now the start of a multi-page flow)
struct ChiefComplaintView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedComplaint: Case.ComplaintType?
    
    var body: some View {
        VStack(spacing: 0) {
                // MARK: - Top Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.appPrimaryText)
                            .frame(width: 44, height: 44, alignment: .leading)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    
                    Text("Chief Complaint")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appPrimaryText)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.appCardBackground)
                
                Divider()
                    .background(Color.appBorder)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tell us about your concern")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        Text("Select the primary reason for your visit today.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.appSecondaryText)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ComplaintCard(type: .pain, isSelected: selectedComplaint == .pain) { selectedComplaint = .pain }
                            ComplaintCard(type: .wornTeeth, isSelected: selectedComplaint == .wornTeeth) { selectedComplaint = .wornTeeth }
                            ComplaintCard(type: .poorEsthetics, isSelected: selectedComplaint == .poorEsthetics) { selectedComplaint = .poorEsthetics }
                            ComplaintCard(type: .difficultyChewing, isSelected: selectedComplaint == .difficultyChewing) { selectedComplaint = .difficultyChewing }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
                .onChange(of: selectedComplaint) { newValue in
                    if let type = newValue {
                        CaseRepository.shared.draftChiefComplaint = type.rawValue
                    }
                }
                
                Spacer()
                
                // MARK: - Navigation Button
                NavigationLink(destination: ComplaintDetailsView()) {
                    Text("Continue")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.blue)
                        )
                }
                .disabled(selectedComplaint == nil)
                .opacity(selectedComplaint == nil ? 0.5 : 1.0)
                .padding(.horizontal, 16)
                .padding(.bottom, 40) // Moved down
            }
            .background(Color.appBackground)
            .navigationBarHidden(true)
    }
}

// MARK: - Complaint Card Component
private struct ComplaintCard: View {
    let type: Case.ComplaintType
    let isSelected: Bool
    let action: () -> Void
    
    var backgroundColor: LinearGradient {
        switch type {
        case .pain:
            return LinearGradient(
                colors: [Color.red.opacity(0.8), Color.red.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .wornTeeth:
            return LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .poorEsthetics:
            return LinearGradient(
                colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .difficultyChewing:
            return LinearGradient(
                colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                ZStack {
                    backgroundColor
                    if type == .pain {
                        Image(systemName: "bolt.fill").font(.system(size: 40, weight: .bold)).foregroundColor(.white).shadow(color: .white.opacity(0.5), radius: 10)
                    } else if type == .wornTeeth {
                        Text("🦷").font(.system(size: 60))
                    } else if type == .poorEsthetics {
                        Image(systemName: "sparkles").font(.system(size: 40, weight: .bold)).foregroundColor(.yellow).shadow(color: .yellow.opacity(0.6), radius: 15)
                    } else {
                        Text("🍎").font(.system(size: 60))
                    }
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                
                Text(type.rawValue)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.appCardBackground)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isSelected ? Color.blue : Color.appBorder, lineWidth: isSelected ? 2 : 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ChiefComplaintView()
    }
}
