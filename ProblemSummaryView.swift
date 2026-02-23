import SwiftUI

struct ProblemSummaryView: View {
    @Environment(\.dismiss) var dismiss
    
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
                
                Text("Problem Summary")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Disease Activity
                    ProblemFlagCard(
                        flagColor: Color(red: 235/255, green: 69/255, blue: 41/255),
                        title: "Disease Activity",
                        description: "AI-generated summary: Active periodontal disease detected in multiple quadrants. Bone loss evident in posterior regions. High risk of further progression without intervention.",
                        imageURL: "https://images.unsplash.com/photo-1598256989800-fe5f95da9787?q=80&w=800&auto=format&fit=crop"
                    )
                    
                    // Occlusal Instability
                    ProblemFlagCard(
                        flagColor: Color(red: 249/255, green: 115/255, blue: 22/255),
                        title: "Occlusal Instability",
                        description: "AI-generated summary: Signs of occlusal instability observed, including fremitus and tooth mobility. Potential for TMJ dysfunction and further tooth wear.",
                        imageURL: "https://images.unsplash.com/photo-1606811971618-4486d14f3f99?q=80&w=800&auto=format&fit=crop"
                    )
                    
                    // VDO Loss
                    ProblemFlagCard(
                        flagColor: Color(red: 234/255, green: 179/255, blue: 8/255),
                        title: "VDO Loss",
                        description: "AI-generated summary: Vertical dimension of occlusion (VDO) loss identified. Reduced interocclusal space and potential for esthetic and functional compromise.",
                        imageURL: "https://images.unsplash.com/photo-1629909613654-28a3a7c4ad45?q=80&w=800&auto=format&fit=crop"
                    )
                    
                     // Esthetic Assessment
                    ProblemFlagCard(
                        flagColor: Color.blue,
                        title: "Esthetic Assessment",
                        description: "AI Summary: Patient only came for final review and report. Esthetic concerns noted, including tooth discoloration and uneven incisal edges.",
                        imageURL: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=800&auto=format&fit=crop"
                    )
                }
                .padding(16)
                .padding(.bottom, 32)
            }
            
            Spacer()
            
            // MARK: - Next Button
            NavigationLink(destination: CaseSubmissionReviewView()) {
                Text("Next")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue)
                    )
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

private struct ProblemFlagCard: View {
    let flagColor: Color
    let title: String
    let description: String
    let imageURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Flag Image Placeholder
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(flagColor.opacity(0.1))
                    .overlay(
                        Image(systemName: "flag.fill")
                            .font(.system(size: 80))
                            .foregroundColor(flagColor)
                    )
            }
            .frame(height: 180)
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Priority Flag")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                    .lineSpacing(4)
            }
        }
    }
}
