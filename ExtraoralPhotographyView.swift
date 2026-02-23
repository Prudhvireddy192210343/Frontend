import SwiftUI

struct ExtraoralPhotographyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isFrontCaptured = true
    @State private var isSmileCaptured = false
    @State private var isProfileCaptured = false
    
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
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Extraoral Photography")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    // MARK: - Patient Records Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Patient Records")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        
                        Text("Align the patient's face with the guides to capture the required perspectives.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                    }
                    .padding(.top, 8)
                    
                    // MARK: - Required Perspectives
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Required Perspectives")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        
                        VStack(spacing: 28) {
                            // Front at Rest
                            PhotographyCard(
                                title: "Front at Rest",
                                isCaptured: isFrontCaptured,
                                imageURL: "https://cdni.iconscout.com/illustration/premium/thumb/man-portrait-illustration-download-in-svg-png-gif-file-formats--person-profile-male-user-avatar-people-avatars-pack-illustrations-4043236.png",
                                statusText: "CAPTURED"
                            ) {
                                isFrontCaptured.toggle()
                            }
                            
                            // Smile
                            PhotographyCard(
                                title: "Smile",
                                isCaptured: isSmileCaptured,
                                imageURL: "https://static.vecteezy.com/system/resources/previews/009/273/280/non_2x/smile-icon-isolated-on-white-background-free-vector.jpg",
                                statusText: ""
                            ) {
                                isSmileCaptured.toggle()
                            }
                            
                            // Profile
                            PhotographyCard(
                                title: "Profile",
                                isCaptured: isProfileCaptured,
                                imageURL: "https://cdni.iconscout.com/illustration/premium/thumb/side-view-of-man-portrait-illustration-download-in-svg-png-gif-file-formats--person-profile-male-user-avatar-people-avatars-pack-illustrations-4043239.png",
                                statusText: ""
                            ) {
                                isProfileCaptured.toggle()
                            }
                        }
                    }
                    
                    // MARK: - Continue Button
                    NavigationLink(destination: IntraoralDetailedScansView()) {
                        Text("Continue")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 8)
                    
                    Text("HIPAA and GDPR compliant")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 156/255, green: 163/255, blue: 175/255))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 32)
                }
                .padding(16)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

// MARK: - Photography Card Component (Matching design)
private struct PhotographyCard: View {
    let title: String
    let isCaptured: Bool
    let imageURL: String
    let statusText: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Diagram/Image Area
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 243/255, green: 244/255, blue: 246/255))
                    .frame(height: 350)
                
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                        .scaledToFit()
                        .padding(10)
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 4) {
                if isCaptured {
                    Text("Completed")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 107/255, green: 114/255, blue: 128/255))
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                HStack {
                    if isCaptured && !statusText.isEmpty {
                        Text(statusText)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(red: 156/255, green: 163/255, blue: 175/255))
                    }
                    
                    Spacer()
                    
                    Button(action: action) {
                        Text(isCaptured ? "Retake" : "Capture")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
