import SwiftUI

struct EstheticAssessmentView: View {
    @Environment(\.dismiss) var dismiss
    
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
                
                Text("Esthetic Assessment")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: - Assessment Hero Image
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1579684385127-1ef15d508118?q=80&w=1000&auto=format&fit=crop")) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.appBorder.opacity(0.1)
                                .overlay(ProgressView())
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 320)
                        .clipped()
                        
                        LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .bottom, endPoint: .top)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("FINAL REVIEW SCAN")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.white.opacity(0.8))
                                .tracking(2)
                            Text("Esthetic Assessment")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(20)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        // MARK: - Clinical Summary
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Clinical Summary")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.appPrimaryText)
                            
                            Text("Detailed analysis of the smile line, incisal display, and gingival harmony suggests a diagnostic wax-up is essential for precision planning.")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.appSecondaryText)
                                .lineSpacing(4)
                        }
                        .padding(.top, 24)
                        
                        // MARK: - Assessment Parameters
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Assessment Parameters")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.appPrimaryText)
                            
                            VStack(spacing: 12) {
                                ParameterRow(title: "Smile Line", status: "High", icon: "arrow.up.and.line.horizontal.and.arrow.down")
                                ParameterRow(title: "Symmetry", status: "Moderate", icon: "chart.bar.xaxis")
                                ParameterRow(title: "Tooth Proportions", status: "Optimal", icon: "square.dashed")
                                ParameterRow(title: "Gingival Display", status: "Excessive", icon: "mouth.fill")
                            }
                        }
                        
                        // MARK: - AI Recommendations
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .foregroundColor(.blue)
                                Text("AI Recommendations")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.appPrimaryText)
                            }
                            
                            Text("• Consider crown lengthening for gingival harmony.\n• Adjust incisal edges for a more youthful smile arc.\n• Diagnostic wax-up recommended for VDO assessment.")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.appSecondaryText)
                                .lineSpacing(6)
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.05))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue.opacity(0.1), lineWidth: 1)
                                )
                        }
                        .padding(.bottom, 120) // Space for bottom button
                    }
                    .padding(.horizontal, 20)
                }
            }
            .overlay(
                VStack {
                    Spacer()
                    // MARK: - Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: ProblemSummaryView()) {
                            Text("Next")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color.blue))
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .buttonStyle(.plain)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .background(
                        LinearGradient(colors: [.appBackground.opacity(0), .appBackground], startPoint: .top, endPoint: .bottom)
                            .frame(height: 120)
                    )
                },
                alignment: .bottom
            )
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

// MARK: - Helper Parameter Row
private struct ParameterRow: View {
    let title: String
    let status: String
    let icon: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)
            
            Spacer()
            
            Text(status)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(status == "Optimal" ? .green : (status == "Moderate" ? .orange : .red))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(status == "Optimal" ? Color.green.opacity(0.1) : (status == "Moderate" ? Color.orange.opacity(0.1) : Color.red.opacity(0.1)))
                )
        }
        .padding(12)
        .background(Color.appCardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder.opacity(0.5), lineWidth: 1)
        )
    }
}
