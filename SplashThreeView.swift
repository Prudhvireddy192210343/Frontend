import SwiftUI

struct SplashThreeView: View {

    @State private var goToLogin = false

    var body: some View {
        ZStack {
            // MARK: Premium Background
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: Header Section
                VStack(spacing: 8) {
                    Text("STEP 3 OF 3")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(.blue)
                        .tracking(2)
                    
                    Text("A Proven Success Logic")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                    
                    Text("Our systematic approach ensures a comprehensive and effective treatment plan.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.appSecondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 40)

                // MARK: Timeline Section
                VStack(spacing: 20) {
                    TimelineRow(
                        icon: "shield.fill",
                        title: "Health",
                        subtitle: "Prioritize oral health and hygiene",
                        showLine: true
                    )
                    
                    TimelineRow(
                        icon: "arrow.triangle.2.circlepath",
                        title: "Bite",
                        subtitle: "Restore proper bite alignment",
                        showLine: true
                    )

                    TimelineRow(
                        icon: "sparkles",
                        title: "Smile",
                        subtitle: "Enhance aesthetics for confidence",
                        showLine: false
                    )
                }
                .padding(.top, 40)
                .padding(.horizontal, 24)

                Spacer()

                // MARK: Footer Controls
                VStack(spacing: 30) {
                    // Modern Page Indicators
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(Color.appBorder)
                            .frame(width: 8, height: 8)
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 24, height: 8)
                    }
                    
                    Button {
                        goToLogin = true
                    } label: {
                        Text("Get Started")
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
        .navigationDestination(isPresented: $goToLogin) {
            ClinicianLoginView()
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarHidden(true)
    }
}

private struct TimelineRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let showLine: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(Color.appCardBackground)
                        .frame(width: 56, height: 56)
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.blue)
                }

                if showLine {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.appBorder)
                        .frame(width: 2, height: 35)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.appPrimaryText)

                Text(subtitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.appSecondaryText)
            }
            .padding(.top, 8)

            Spacer()
        }
    }
}

#Preview {
    SplashThreeView()
}
