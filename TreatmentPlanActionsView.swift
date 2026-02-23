import SwiftUI

struct TreatmentPlanActionsView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    
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
                
                Spacer()
                
                Text("Treatment Plan Actions")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Module 1: Smile Transformation
                    ActionCard(
                        title: "Smile Transformation",
                        buttonText: "Status",
                        imageURL: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?q=80&w=800&auto=format&fit=crop",
                        destination: AnyView(SmileTransformationView(caseItem: caseItem))
                    )
                    
                    // Module 2: Final Review
                    ActionCard(
                        title: "Final Review",
                        buttonText: "Review",
                        imageURL: "https://images.unsplash.com/photo-1606811841689-23dfddce3e95?q=80&w=800&auto=format&fit=crop",
                        destination: AnyView(FinalReviewView(caseItem: caseItem))
                    )
                    
                    // Module 3: Summary
                    ActionCard(
                        title: "Summary",
                        buttonText: "View",
                        imageURL: "https://images.unsplash.com/photo-1629909613654-28a3a7c4ad45?q=80&w=800&auto=format&fit=crop",
                        destination: AnyView(CaseSummaryReportView(caseItem: caseItem))
                    )
                }
                .padding(20)
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

private struct ActionCard: View {
    let title: String
    let buttonText: String
    let imageURL: String
    let destination: AnyView
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Hero area for card
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.appBorder.opacity(0.1)
                    .overlay(ProgressView())
            }
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .cornerRadius(12)
            .clipped()
            
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                NavigationLink(destination: destination) {
                    Text(buttonText)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TreatmentPlanActionsView(caseItem: Case.sampleCases[0])
    }
}
