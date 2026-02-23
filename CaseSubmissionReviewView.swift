import SwiftUI

struct CaseSubmissionReviewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSuccessAlert = false
    @State private var navigateToSequence = false
    @ObservedObject private var repository = CaseRepository.shared
    
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
                }
                .buttonStyle(.plain)
                
                Text("Review Case")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            Divider()
                .background(Color.appBorder)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Review & Confirm")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                    
                    Text("Please review the information before submitting.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.appSecondaryText)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ReviewRow(title: "Patient Name", value: repository.draftPatientName.isEmpty ? "New Patient" : repository.draftPatientName)
                        ReviewRow(title: "Chief Complaint", value: repository.draftChiefComplaint.isEmpty ? "Evaluation" : repository.draftChiefComplaint)
                        ReviewRow(title: "PDI Class", value: "PDI Class I")
                        ReviewRow(title: "Analysis", value: "AI Evaluation Completed")
                    }
                    .padding(16)
                    .background(Color.appCardBackground)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.appBorder, lineWidth: 1))
                }
                .padding(16)
                .padding(.bottom, 140)
            }
            .overlay(
                VStack {
                    Spacer()
                    // MARK: - Navigation Button
                    Button {
                        submitCase()
                    } label: {
                        Text("Submit Case")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.blue))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                    .background(
                        LinearGradient(colors: [.appBackground.opacity(0), .appBackground], startPoint: .top, endPoint: .bottom)
                            .frame(height: 120)
                    )
                },
                alignment: .bottom
            )
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $navigateToSequence) {
            NavigationStack {
                if !repository.cases.isEmpty {
                    TreatmentSequenceView(caseItem: repository.cases[0])
                }
            }
        }
        .overlay(
            Group {
                if showSuccessAlert {
                    ZStack {
                        Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.green)
                            
                            VStack(spacing: 8) {
                                Text("Case Submitted")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.appPrimaryText)
                                
                                Text("Patient case has been created and saved successfully!")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.appSecondaryText)
                                    .padding(.horizontal)
                            }
                            
                            Button {
                                withAnimation {
                                    showSuccessAlert = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    navigateToSequence = true
                                }
                            } label: {
                                Text("Continue")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(24)
                        .background(Color.appCardBackground)
                        .cornerRadius(24)
                        .padding(40)
                        .shadow(radius: 20)
                    }
                }
            }
        )
    }
    
    // Add logic to save case
    func submitCase() {
        CaseRepository.shared.addCase()
        withAnimation {
            showSuccessAlert = true
        }
    }
}

private struct ReviewRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text(title).font(.system(size: 14, weight: .regular)).foregroundColor(.appSecondaryText)
            Spacer()
            Text(value).font(.system(size: 14, weight: .medium)).foregroundColor(.appPrimaryText)
        }
    }
}
