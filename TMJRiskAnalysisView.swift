import SwiftUI

struct TMJRiskAnalysisView: View {
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
                        .foregroundColor(.appPrimaryText)
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("TMJ & Muscle Risk Analysis")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    // MARK: - Patient-reported symptoms
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Patient-reported symptoms")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        VStack(spacing: 16) {
                            SymptomRow(iconName: "cursorarrow.rays", title: "Clicking")
                            SymptomRow(iconName: "hand.raised.fill", title: "Tenderness")
                            SymptomRow(iconName: "arrow.left.and.right", title: "Limited range of motion")
                            SymptomRow(iconName: "heart.fill", title: "Pain")
                        }
                    }
                    
                    // MARK: - AI Inference
                    VStack(alignment: .leading, spacing: 24) {
                        Text("AI Inference")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        // Muscle Risk
                        RiskCard(title: "Muscle Risk", level: "Moderate", percentage: 65, subText: "Muscle Risk", color: .blue)
                        
                        // Joint Risk
                        RiskCard(title: "Joint Risk", level: "High", percentage: 85, subText: "Joint Risk", color: .blue)
                    }
                    
                    // MARK: - Outcome
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Outcome")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.appSecondaryText)
                                
                                Text("Reversible phase enforced (splint/provisional)")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.appPrimaryText)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text("Based on the analysis, a reversible phase is recommended.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.appSecondaryText)
                            }
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg")) { image in
                                image.resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.appBorder.opacity(0.1)
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                            .clipped()
                        }
                    }
                    .padding(16)
                    .background(Color.appCardBackground)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                }
                .padding(16)
                .padding(.bottom, 32)
            }
            
            // MARK: - Save and Continue Button
            NavigationLink(destination: OcclusalStabilityView()) {
                HStack {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .bold))
                    Text("Save and Continue")
                        .font(.system(size: 15, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color.blue)
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 80) // Moved down even further as requested
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(16)
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

private struct SymptomRow: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appBorder.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundColor(.appPrimaryText)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)
            
            Spacer()
        }
    }
}

private struct RiskCard: View {
    let title: String
    let level: String
    let percentage: Int
    let subText: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(level)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                    Text(subText)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appSecondaryText)
                }
                Spacer()
                Text("\(percentage)%")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.appPrimaryText)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.appBorder.opacity(0.2))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: UIScreen.main.bounds.width * 0.8 * (Double(percentage) / 100.0), height: 8)
                }
                
                Text(level)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appSecondaryText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TMJRiskAnalysisView()
    }
}
