import SwiftUI

struct AIAnalysisProcessingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var progress: Double = 0.0
    @State private var navigateToResult = false
    
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
                
                Text("AI Analysis")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Spacer()
            
            VStack(spacing: 40) {
                // MARK: - Analysis Image (Wireframe Visualization)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 31/255, green: 41/255, blue: 55/255))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(0.7, contentMode: .fit)
                        .padding(.horizontal, 24)
                    
                    AsyncImage(url: URL(string: "https://cdni.iconscout.com/illustration/premium/thumb/face-recognition-illustration-download-in-svg-png-gif-file-formats--biometric-authentication-cyber-security-scanned-protection-pack-illustrations-5219277.png")) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(40)
                    } placeholder: {
                        ProgressView().tint(.white)
                    }
                }
                
                // MARK: - Progress & Status
                VStack(spacing: 60) {
                    Text("Analyzing facial proportions & occlusion...")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                        .multilineTextAlignment(.center)
                    
                    VStack(alignment: .trailing, spacing: 12) {
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 229/255, green: 231/255, blue: 235/255))
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                                    .frame(width: geometry.size.width * progress, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                    .padding(.horizontal, 24)
                }
            }
            
            Spacer()
            
            // Automatic transition trigger
            NavigationLink(destination: AIAnalysisReviewView(), isActive: $navigateToResult) {
                EmptyView()
            }
        }
        .background(Color(red: 249/255, green: 250/255, blue: 251/255))
        .navigationBarHidden(true)
        .onAppear {
            // Simulated progression logic
            withAnimation(.linear(duration: 2.0)) {
                progress = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                navigateToResult = true
            }
        }
    }
}
