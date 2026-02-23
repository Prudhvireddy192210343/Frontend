import SwiftUI

struct IntroView: View {

    @State private var progress: CGFloat = 0.0
    @State private var goToSplash1 = false
    
    // Animation States
    @State private var mainOpacity: Double = 0.0
    @State private var imageScale: CGFloat = 0.8
    @State private var titleOffset: CGFloat = 30
    @State private var scannerOffset: CGFloat = -1.0
    @State private var isBreathing = false
    @State private var rotation: Double = 0.0
    @State private var ringRotation: Double = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: Deep Space Dark Background
                Color(hex: "#020304")
                    .ignoresSafeArea()
                
                // 🌌 Animated Starfield & Nebula
                GeometryReader { geo in
                    ZStack {
                        // Moving Nebula Orbs
                        Circle()
                            .fill(RadialGradient(colors: [.blue.opacity(0.15), .clear], center: .center, startRadius: 0, endRadius: 200))
                            .frame(width: 400, height: 400)
                            .blur(radius: 60)
                            .offset(x: isBreathing ? -150 : 150, y: isBreathing ? 100 : -100)
                        
                        Circle()
                            .fill(RadialGradient(colors: [.cyan.opacity(0.12), .clear], center: .center, startRadius: 0, endRadius: 180))
                            .frame(width: 350, height: 350)
                            .blur(radius: 50)
                            .offset(x: isBreathing ? 180 : -120, y: isBreathing ? -50 : 150)

                        // 💠 Moving Starfield
                        ForEach(0..<40) { i in
                            Circle()
                                .fill(i % 2 == 0 ? Color.white : Color.cyan)
                                .frame(width: CGFloat.random(in: 1...2.5))
                                .position(
                                    x: CGFloat.random(in: 0...geo.size.width),
                                    y: CGFloat.random(in: 0...geo.size.height)
                                )
                                .opacity(Double.random(in: 0.1...0.6))
                                .blur(radius: 0.5)
                        }
                        
                        // Ultra-subtle Scanning Lines
                        Path { path in
                            for i in 0...30 {
                                let y = CGFloat(i) * geo.size.height / 30
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: geo.size.width, y: y))
                            }
                        }
                        .stroke(Color.cyan.opacity(0.05), lineWidth: 0.3)
                    }
                }
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // MARK: Top Status
                    HStack(spacing: 12) {
                        ZStack {
                            Circle().fill(Color.green.opacity(0.2)).frame(width: 12, height: 12)
                            Circle().fill(Color.green).frame(width: 6, height: 6)
                        }
                        .shadow(color: .green, radius: 4)
                        
                        Text("QUANTUM ENGINE : ONLINE")
                            .font(.system(size: 10, weight: .black, design: .monospaced))
                            .tracking(3)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.5))
                            .overlay(Capsule().stroke(Color.cyan.opacity(0.3), lineWidth: 0.5))
                    )
                    .padding(.top, 20)
                    .opacity(mainOpacity)
                    .offset(y: mainOpacity == 1 ? 0 : -30)

                    Spacer()

                    // MARK: 🌀 HEAVY MULTI-LAYERED ORBITAL CORE
                    ZStack {
                        // 1. Outer Massive Glow Ring
                        Circle()
                            .stroke(Color.blue.opacity(0.1), lineWidth: 40)
                            .frame(width: 340, height: 340)
                            .blur(radius: 20)
                        
                        // 2. Slow Heavy Dashed Ring
                        Circle()
                            .stroke(
                                LinearGradient(colors: [.cyan.opacity(0.4), .clear], startPoint: .top, endPoint: .bottom),
                                style: StrokeStyle(lineWidth: 1, dash: [80, 40])
                            )
                            .frame(width: 360, height: 360)
                            .rotationEffect(.degrees(ringRotation * 0.4))
                        
                        // 3. Middle Data Ring (Dashed)
                        Circle()
                            .stroke(
                                Color.blue.opacity(0.3),
                                style: StrokeStyle(lineWidth: 2, dash: [2, 10])
                            )
                            .frame(width: 320, height: 320)
                            .rotationEffect(.degrees(-ringRotation * 1.2))
                        
                        // 4. Energy Pulse Ring
                        Circle()
                            .stroke(
                                AngularGradient(colors: [.cyan, .clear, .blue, .clear], center: .center),
                                style: StrokeStyle(lineWidth: 4, lineCap: .round)
                            )
                            .frame(width: 285, height: 285)
                            .rotationEffect(.degrees(ringRotation * 2.5))
                            .blur(radius: 0.5)
                            .shadow(color: .cyan.opacity(0.8), radius: 10)

                        // 5. Tech Bits & Datapoints
                        ForEach(0..<12) { i in
                            Rectangle()
                                .fill(i % 3 == 0 ? Color.cyan : Color.white.opacity(0.6))
                                .frame(width: 10, height: 1)
                                .offset(x: 155)
                                .rotationEffect(.degrees(Double(i) * 30 + (ringRotation * 2)))
                            
                            Circle()
                                .fill(Color.cyan)
                                .frame(width: 5, height: 5)
                                .shadow(color: .cyan, radius: 8)
                                .offset(x: 185)
                                .rotationEffect(.degrees(Double(i) * 30 + ringRotation))
                        }

                        // 6. THE CORE RECEPTACLE
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(colors: [Color(hex: "#0A0F14"), .black], center: .center, startRadius: 0, endRadius: 120)
                                )
                                .frame(width: 250, height: 250)
                                .overlay(Circle().stroke(Color.cyan.opacity(0.5), lineWidth: 1.5))
                                .shadow(color: .cyan.opacity(0.4), radius: 30)
                            
                            Image("tooth_ai") 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 235, height: 235)
                                .clipShape(Circle())
                                .scaleEffect(isBreathing ? 1.05 : 1.0)
                            
                            // Holographic Scanner Overlay
                            Circle()
                                .stroke(
                                    LinearGradient(colors: [.clear, .cyan.opacity(0.5), .white, .cyan.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom),
                                    lineWidth: 2
                                )
                                .frame(width: 240, height: 240)
                                .offset(y: isBreathing ? 120 : -120)
                                .mask(Circle().frame(width: 250, height: 250))
                        }
                    }
                    .opacity(mainOpacity)

                    // MARK: High-Tech Branding
                    VStack(spacing: 12) {
                        Text("DENTAPLAN AI")
                            .font(.system(size: 42, weight: .black))
                            .foregroundColor(.white)
                            .tracking(4)
                            .shadow(color: .cyan.opacity(0.5), radius: 15)
                        
                        HStack(spacing: 15) {
                            Rectangle().fill(Color.cyan.opacity(0.5)).frame(width: 40, height: 1)
                            Text("BEYOND HUMAN PRECISION")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.cyan)
                                .tracking(5)
                            Rectangle().fill(Color.cyan.opacity(0.5)).frame(width: 40, height: 1)
                        }
                    }
                    .padding(.top, 70)
                    .opacity(mainOpacity)
                    .offset(y: titleOffset)

                    Spacer()

                    // MARK: Real-time Analytics Boot Sequence
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("SYSTEM CALIBRATION")
                                    .font(.system(size: 10, weight: .black, design: .monospaced))
                                    .foregroundColor(.cyan)
                                Text("PROCESS::\(Int(progress * 100))%")
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("LOCATING::ORAL_MESH_V4")
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        
                        // Pulse Loading Bar
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 1)
                                .fill(Color.white.opacity(0.05))
                                .frame(height: 3)
                            
                            RoundedRectangle(cornerRadius: 1)
                                .fill(
                                    LinearGradient(colors: [.cyan, .blue, .purple], startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(width: 320 * progress, height: 3)
                                .shadow(color: .cyan, radius: 6)
                        }
                        .frame(width: 320)
                        
                        // Animated Tech Footer bits
                        HStack {
                            Text("HIPAA SECURE")
                                .font(.system(size: 8, design: .monospaced))
                                .padding(4)
                                .border(Color.white.opacity(0.2))
                            Spacer()
                            Text("M_LEARNING_ACTIVE")
                                .font(.system(size: 8, design: .monospaced))
                        }
                        .foregroundColor(.white.opacity(0.3))
                    }
                    .padding(.bottom, 60)
                    .opacity(mainOpacity)
                    .offset(y: mainOpacity == 1 ? 0 : 40)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    mainOpacity = 1.0
                    imageScale = 1.0
                    titleOffset = 0
                }
                
                withAnimation(.linear(duration: 12.0).repeatForever(autoreverses: false)) {
                    ringRotation = 360
                }
                
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    isBreathing = true
                }
                
                withAnimation(.easeInOut(duration: 4.5)) {
                    progress = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                    goToSplash1 = true
                }
            }
            .navigationDestination(isPresented: $goToSplash1) {
                SplashOneView()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    IntroView()
}
