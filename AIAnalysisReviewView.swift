import SwiftUI

struct AIAnalysisReviewView: View {
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
                
                Text("AI Analysis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Divider()
                .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=1000&auto=format&fit=crop")) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1).overlay(ProgressView())
                    }
                    .frame(maxWidth: .infinity).frame(height: 400).cornerRadius(16).clipped()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("AI Tags").font(.system(size: 20, weight: .bold)).foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        VStack(spacing: 16) {
                            AnalysisRow(title: "Facial Symmetry", color: .green)
                            AnalysisRow(title: "Lower Facial Height", color: .green)
                            AnalysisRow(title: "Smile Line", color: .green)
                            AnalysisRow(title: "Lip Competence", color: .green)
                        }
                    }
                }
                .padding(16)
            }
            
            Spacer()
            
            // MARK: - Navigation Button
            NavigationLink(destination: TMJRiskAnalysisView()) {
                Text("Continue to Risk Analysis")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color(red: 0/255, green: 122/255, blue: 255/255)))
            }
            .padding(16)
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

private struct AnalysisRow: View {
    let title: String
    let color: Color
    var body: some View {
        HStack {
            Text(title).font(.system(size: 16, weight: .medium)).foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
            Spacer()
            Circle().fill(color).frame(width: 8, height: 8)
        }
    }
}
