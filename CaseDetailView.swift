import SwiftUI

// MARK: - Case Detail View
struct CaseDetailView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    @State private var showDeleteAlert = false
    
    var statusColor: Color {
        switch caseItem.status {
        case .active:
            return Color(red: 7/255, green: 136/255, blue: 59/255)
        case .pending:
            return Color(red: 245/255, green: 158/255, blue: 11/255)
        case .completed:
            return Color(red: 59/255, green: 130/255, blue: 246/255)
        case .archived:
            return Color(red: 107/255, green: 114/255, blue: 128/255)
        }
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
                        .foregroundColor(.appPrimaryText)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Case Details")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            Divider()
                .background(Color.appBorder)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Patient Header
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 16) {
                            // Patient Avatar
                            if let imageUrl = caseItem.patientImageUrl, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Circle()
                                        .fill(Color.blue.opacity(0.1))
                                        .overlay(
                                            Text(String(caseItem.patientName.prefix(1)))
                                                .font(.system(size: 28, weight: .bold))
                                                .foregroundColor(.blue)
                                        )
                                }
                                .frame(width: 72, height: 72)
                                .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.blue.opacity(0.1))
                                    .frame(width: 72, height: 72)
                                    .overlay(
                                        Text(String(caseItem.patientName.prefix(1)))
                                            .font(.system(size: 28, weight: .bold))
                                            .foregroundColor(.blue)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(caseItem.patientName)
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.appPrimaryText)
                                    
                                    Spacer()
                                    
                                    Text(caseItem.status.rawValue)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(statusColor)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(statusColor.opacity(0.1))
                                        )
                                }
                                
                                HStack(spacing: 16) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "person.circle")
                                            .font(.system(size: 14))
                                            .foregroundColor(.appSecondaryText)
                                        
                                        Text("ID: \(caseItem.patientId)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.appSecondaryText)
                                    }
                                    
                                    HStack(spacing: 6) {
                                        Image(systemName: "calendar")
                                            .font(.system(size: 14))
                                            .foregroundColor(.appSecondaryText)
                                        
                                        Text(formatDate(caseItem.createdDate))
                                            .font(.system(size: 14))
                                            .foregroundColor(.appSecondaryText)
                                    }
                                }
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                    
                    // MARK: - Chief Complaint
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            Text("Chief Complaint")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.appPrimaryText)
                        }
                        
                        Text(caseItem.complaintType.rawValue)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.appPrimaryText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                    
                    // MARK: - Additional Details
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            Text("Additional Details")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.appPrimaryText)
                        }
                        
                        Text(caseItem.additionalDetails)
                            .font(.system(size: 15))
                            .foregroundColor(.appSecondaryText)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                    
                    // MARK: - Medical History
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            Text("Medical History")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.appPrimaryText)
                        }
                        
                        Text(caseItem.medicalHistory)
                            .font(.system(size: 15))
                            .foregroundColor(.appSecondaryText)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                    
                    // MARK: - Doctor Information
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "stethoscope")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            Text("Assigned Doctor")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.appPrimaryText)
                        }
                        
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Text(String(caseItem.doctorName.prefix(1)))
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.blue)
                                )
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(caseItem.doctorName)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.appPrimaryText)
                                
                                Text("Dental Specialist")
                                    .font(.system(size: 13))
                                    .foregroundColor(.appSecondaryText)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                }
                .padding(16)
                .padding(.bottom, 24)
            }
            
            // MARK: - Action Buttons
            VStack(spacing: 12) {
                Divider()
                    .background(Color.appBorder)
                
                NavigationLink(destination: TreatmentPlanActionsView(caseItem: caseItem)) {
                    HStack {
                        Image(systemName: "doc.text")
                        Text("View Summary Report")
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.blue)
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.top, 10)
                
                HStack(spacing: 12) {
                    NavigationLink(destination: PatientInfoView(caseItem: caseItem)) {
                        HStack(spacing: 6) {
                            Image(systemName: "pencil")
                                .font(.system(size: 16, weight: .medium))
                            Text("Edit")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.blue, lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink(destination: UpdateStatusView(caseItem: caseItem)) {
                        Text("Update Status")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.blue)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .background(Color.appCardBackground)
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
        .alert("Delete Case", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                CaseRepository.shared.deleteCase(id: caseItem.id)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this case? This action cannot be undone.")
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        CaseDetailView(caseItem: Case.sampleCases[0])
    }
}
