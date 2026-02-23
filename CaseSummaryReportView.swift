import SwiftUI

struct CaseSummaryReportView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    
    var body: some View {
        VStack(spacing: 0) {
                // MARK: - Top Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.appPrimaryText)
                            .frame(width: 44, height: 44, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Text("Case Summary Report")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.appCardBackground)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // Clinical Diagnosis
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Clinical Diagnosis")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.appPrimaryText)
                            
                            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 16) {
                                GridRow {
                                    DiagnosisItem(label: "Patient Name", value: caseItem.patientName)
                                    DiagnosisItem(label: "Patient ID", value: caseItem.patientId)
                                }
                                Divider()
                                
                                // Parse Age/Gender if they exist in formatted string
                                let info = parseMedicalHistory(caseItem.medicalHistory)
                                GridRow {
                                    DiagnosisItem(label: "Age", value: info.age)
                                    DiagnosisItem(label: "Gender", value: info.gender)
                                }
                                Divider()
                                
                                GridRow {
                                    DiagnosisItem(label: "Medical History", value: info.other)
                                    DiagnosisItem(label: "Chief Complaint", value: caseItem.chiefComplaint)
                                }
                                Divider()
                                GridRow {
                                    DiagnosisItem(label: "Last Updated", value: formatDate(caseItem.lastUpdated))
                                    DiagnosisItem(label: "Status", value: caseItem.status.rawValue)
                                }
                                Divider()
                                GridRow {
                                    DiagnosisItem(label: "Radiographic Findings", value: "Evaluation complete")
                                    DiagnosisItem(label: "Clinical Findings", value: caseItem.additionalDetails.isEmpty ? "No significant issues noted" : caseItem.additionalDetails)
                                }
                            }
                        }
                    
                    // Sequencing Logic
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Sequencing Logic")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            SequencePhaseItem(phase: "Phase 1: Initial Care", description: "Addressing primary complaint: \(caseItem.chiefComplaint)")
                            SequencePhaseItem(phase: "Phase 2: Restoration", description: "Biomimetic restorative approach based on AI findings.")
                            SequencePhaseItem(phase: "Phase 3: Maintenance", description: "Regular 6-month monitoring and preventive care.")
                        }
                    }
                    
                    // Identified Risks
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Identified Risks")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        RiskItem(title: "Structural Integrity", level: "Low-Moderate")
                        RiskItem(title: "Functional Stability", level: "Stable")
                    }
                    
                    // Final Recommendation
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Final Recommendation")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        Text("Based on the clinical data for \(caseItem.patientName), the recommended course of action is to proceed with the phased treatment plan. The patient only came for final review and report. Our analysis suggests that monitoring for the next 6 months is sufficient unless symptoms change.")
                            .font(.system(size: 16))
                            .foregroundColor(.appSecondaryText)
                            .lineSpacing(4)
                    }
                }
                .padding(20)
                .padding(.bottom, 60)
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
    
    private func parseMedicalHistory(_ raw: String) -> (age: String, gender: String, other: String) {
        // Simple parser for "Age: X, Gender: Y" format
        var age = "N/A"
        var gender = "N/A"
        var other = raw
        
        if let ageRange = raw.range(of: "Age: "),
           let commaRange = raw.range(of: ",", range: ageRange.upperBound..<raw.endIndex) {
            age = String(raw[ageRange.upperBound..<commaRange.lowerBound]).trimmingCharacters(in: .whitespaces)
            other = raw.replacingOccurrences(of: "Age: \(age), ", with: "")
        }
        
        if let genderRange = other.range(of: "Gender: ") {
            gender = String(other[genderRange.upperBound...]).trimmingCharacters(in: .whitespaces)
            other = other.replacingOccurrences(of: "Gender: \(gender)", with: "")
        }
        
        if other.isEmpty || other == "Age: \(age), Gender: \(gender)" {
            other = "No significant history"
        }
        
        return (age, gender, other.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

private struct DiagnosisItem: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.system(size: 14)).foregroundColor(.appSecondaryText)
            Text(value).font(.system(size: 14, weight: .medium)).foregroundColor(.appPrimaryText)
        }
    }
}

private struct SequencePhaseItem: View {
    let phase: String
    let description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(phase).font(.system(size: 14, weight: .medium)).foregroundColor(.appSecondaryText)
            Text(description).font(.system(size: 15)).foregroundColor(.appPrimaryText)
        }
    }
}

private struct RiskItem: View {
    let title: String
    let level: String
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appBorder.opacity(0.1))
                    .frame(width: 44, height: 44)
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.appPrimaryText)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 16, weight: .medium)).foregroundColor(.appPrimaryText)
                Text(level).font(.system(size: 14)).foregroundColor(.appSecondaryText)
            }
        }
    }
}

#Preview {
    CaseSummaryReportView(caseItem: Case.sampleCases[0])
}
