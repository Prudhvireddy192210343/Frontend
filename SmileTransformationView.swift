import SwiftUI

struct SmileTransformationView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.appPrimaryText)
                    .frame(height: 44)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Smile Transformation")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Before Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Before")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?q=80&w=800&auto=format&fit=crop")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.appBorder.opacity(0.1)
                                .overlay(ProgressView())
                        }
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .offset(y: 4)
                        .clipped()
                    }
                    
                    // After Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("After")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1549480017-d76466a4b7e8?q=80&w=800&auto=format&fit=crop")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.appBorder.opacity(0.1)
                                .overlay(ProgressView())
                        }
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .clipped()
                    }
                }
                .padding(16)
            }
            
            // MARK: - Bottom Tab Bar

        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        SmileTransformationView(caseItem: Case.sampleCases[0])
    }
}
