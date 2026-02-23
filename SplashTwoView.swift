import SwiftUI

struct SplashTwoView: View {

    @State private var goToSplashThree = false

    var body: some View {
        ZStack {
            // MARK: Premium Background
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: Hero Image Section
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.appCardBackground)
                        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 8)
                    
                    Image("onboarding_2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .padding(20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 60)

                // MARK: Content Section
                VStack(spacing: 16) {
                    Text("Precision Powered by AI")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 10)
                    
                    Text("Our AI-assisted planning leverages advanced algorithms to analyze patient data, ensuring precise and efficient dental rehabilitation.")
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
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 24, height: 8)
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                    }
                    
                    Button {
                        goToSplashThree = true
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
        .navigationDestination(isPresented: $goToSplashThree) {
            SplashThreeView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    SplashTwoView()
}
