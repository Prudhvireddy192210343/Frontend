import SwiftUI

struct SplashOneView: View {

    @State private var goToSplashTwo = false
    @AppStorage("selectedLanguageCode") private var selectedLanguageCode = "en"

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // MARK: Premium Background
            Color.appBackground
                .ignoresSafeArea()
            
            // MARK: Language Switcher (Upside Move)
            NavigationLink(destination: LanguagesView()) {
                HStack(spacing: 6) {
                    Image(systemName: "globe")
                        .font(.system(size: 14))
                    Text(selectedLanguageCode.uppercased())
                        .font(.system(size: 12, weight: .black))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.appCardBackground)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
            .padding(.trailing, 20)
            .padding(.top, 10)
            .zIndex(10)
            
            VStack(spacing: 0) {
                // MARK: Hero Image Section
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.appCardBackground)
                        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 8)
                    
                    Image("onboarding_1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .padding(20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 60)

                // MARK: Content Section
                VStack(spacing: 16) {
                    Text("Restoring More Than Just Teeth")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 10)
                    
                    Text("Understand the holistic journey of full-mouth rehabilitation, focusing on health, function, and aesthetics.")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.appSecondaryText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 30)
                .padding(.top, 40)

                Spacer()

                // MARK: Footer Controls
                VStack(spacing: 30) {
                    // Modern Page Indicators
                    HStack(spacing: 8) {
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 24, height: 8)
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                    }
                    
                    Button {
                        goToSplashTwo = true
                    } label: {
                        Text("Next")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 64)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.blue.opacity(0.3), radius: 15, x: 0, y: 8)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
        .navigationDestination(isPresented: $goToSplashTwo) {
            SplashTwoView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
#Preview {
    SplashOneView()
}
