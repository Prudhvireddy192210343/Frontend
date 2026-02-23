import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var goToLogin = false
    @State private var isAnimating = false
    
    let pages = [
        OnboardingData(
            title: "Restoring More Than Just Teeth",
            description: "Understand the holistic journey of full-mouth rehabilitation, focusing on health, function, and aesthetics.",
            image: "onboarding_1",
            accentColor: .blue
        ),
        OnboardingData(
            title: "Precision Powered by AI",
            description: "Our AI-assisted planning leverages advanced algorithms to analyze patient data for precise dental rehabilitation.",
            image: "onboarding_2",
            accentColor: .cyan
        ),
        OnboardingData(
            title: "A Proven Success Logic",
            description: "A systematic approach across Health, Bite, and Smile ensures a comprehensive treatment plan.",
            image: "onboarding_1", // Using existing asset
            accentColor: .indigo
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: Persistent Animated Background
                Color(hex: "#020305")
                    .ignoresSafeArea()
                
                // Animated Background Orbs (persistent across swipes)
                GeometryReader { geo in
                    ZStack {
                        Circle()
                            .fill(pages[currentPage].accentColor.opacity(0.15))
                            .frame(width: 400, height: 400)
                            .blur(radius: 100)
                            .offset(x: isAnimating ? -50 : 50, y: isAnimating ? -100 : 100)
                        
                        Circle()
                            .fill(Color.purple.opacity(0.1))
                            .frame(width: 300, height: 300)
                            .blur(radius: 80)
                            .offset(x: isAnimating ? 150 : -50, y: isAnimating ? 200 : 0)
                    }
                }
                
                VStack(spacing: 0) {
                    // MARK: Page Content
                    TabView(selection: $currentPage) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            OnboardingPageContent(data: pages[index], isVisible: currentPage == index)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentPage)
                    
                    // MARK: Footer UI
                    VStack(spacing: 30) {
                        // Custom Page Indicators
                        HStack(spacing: 12) {
                            ForEach(0..<pages.count, id: \.self) { index in
                                Capsule()
                                    .fill(currentPage == index ? pages[currentPage].accentColor : Color.white.opacity(0.2))
                                    .frame(width: currentPage == index ? 32 : 8, height: 8)
                                    .overlay(
                                        currentPage == index ? 
                                        Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1) : nil
                                    )
                            }
                        }
                        
                        // Action Button
                        Button {
                            if currentPage < pages.count - 1 {
                                currentPage += 1
                            } else {
                                goToLogin = true
                            }
                        } label: {
                            HStack(spacing: 15) {
                                Text(currentPage == pages.count - 1 ? "GET STARTED" : "CONTINUE")
                                    .font(.system(size: 16, weight: .black))
                                    .tracking(2)
                                
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 24))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 64)
                            .background(
                                LinearGradient(
                                    colors: [pages[currentPage].accentColor, pages[currentPage].accentColor.opacity(0.7)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(20)
                            .shadow(color: pages[currentPage].accentColor.opacity(0.4), radius: 20, x: 0, y: 10)
                            .padding(.horizontal, 30)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
            .navigationDestination(isPresented: $goToLogin) {
                ClinicianLoginView()
            }
        }
    }
}

struct OnboardingPageContent: View {
    let data: OnboardingData
    let isVisible: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Image Section with Floating Effect
            ZStack {
                Circle()
                    .fill(data.accentColor.opacity(0.1))
                    .frame(width: 320, height: 320)
                    .blur(radius: 20)
                
                Image(data.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(
                                LinearGradient(
                                    colors: [data.accentColor, .clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                    .shadow(color: data.accentColor.opacity(0.3), radius: 30, x: 0, y: 20)
                    .scaleEffect(isVisible ? 1.0 : 0.8)
                    .rotation3DEffect(
                        .degrees(isVisible ? 0 : 15),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            
            // Text Section
            VStack(spacing: 20) {
                Text(data.title)
                    .font(.system(size: 34, weight: .black))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 20)
                    .offset(y: isVisible ? 0 : 20)
                
                if data.image == "onboarding_1" && data.accentColor == .indigo { // Detect page 3
                     VStack(spacing: 20) {
                        OnboardingTimelineRow(icon: "shield.fill", title: "Health", subtitle: "Prioritize oral hygiene", isVisible: isVisible, delay: 0.1)
                        OnboardingTimelineRow(icon: "arrow.triangle.2.circlepath", title: "Bite", subtitle: "Restore proper function", isVisible: isVisible, delay: 0.3)
                        OnboardingTimelineRow(icon: "sparkles", title: "Smile", subtitle: "Enhance aesthetics", isVisible: isVisible, delay: 0.5)
                    }
                    .padding(.top, 10)
                } else {
                    Text(data.description)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 40)
                        .opacity(isVisible ? 1 : 0)
                        .offset(y: isVisible ? 0 : 20)
                }
            }
            .padding(.top, 50)
            
            Spacer()
        }
    }
}

struct OnboardingTimelineRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let isVisible: Bool
    let delay: Double
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.indigo.opacity(0.2))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .foregroundColor(.indigo)
                    .font(.system(size: 18, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
            }
            Spacer()
        }
        .padding(.horizontal, 40)
        .opacity(isVisible ? 1 : 0)
        .offset(x: isVisible ? 0 : -20)
        .animation(.easeOut(duration: 0.5).delay(delay), value: isVisible)
    }
}

struct OnboardingData {
    let title: String
    let description: String
    let image: String
    let accentColor: Color
}

#Preview {
    OnboardingView()
}
