import SwiftUI

struct FinalReviewView: View {
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
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Final Review")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Summary")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ReviewItem(title: "Prosthodontist", value: caseItem.doctorName)
                        ReviewItem(title: "Case ID: \(caseItem.patientId)", value: "Patient: \(caseItem.patientName)")
                        ReviewItem(title: "Date", value: formatDate(caseItem.createdDate))
                        ReviewItem(title: "Plan Type", value: "AI-Generated")
                        ReviewItem(title: "Treatment", value: caseItem.chiefComplaint)
                        ReviewItem(title: "Prognosis", value: "Excellent")
                    }
                    
                    // Empty Box placeholder
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 231/255, green: 235/255, blue: 243/255), lineWidth: 1)
                        .frame(height: 200)
                        .background(Color.white)
                    
                    
                    Text("AI Learning: Your choices help refine the algorithm")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                }
                .padding(20)
                .padding(.bottom, 80) // Space for fixed button
            }
            .overlay(
                VStack {
                    Spacer()
                    NavigationLink(destination: FinalPlanView(caseItem: caseItem)) {
                        Text("Next")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 37/255, green: 99/255, blue: 235/255)))
                    }
                    .buttonStyle(.plain)
                    .padding(20)
                    .background(
                        LinearGradient(colors: [Color.white.opacity(0), Color.white], startPoint: .top, endPoint: .bottom)
                            .padding(.top, -20)
                    )
                },
                alignment: .bottom
            )
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

private struct ReviewItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
        }
    }
}

#Preview {
    FinalReviewView(caseItem: Case.sampleCases[0])
}
