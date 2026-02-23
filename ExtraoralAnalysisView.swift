import SwiftUI

struct ExtraoralAnalysisView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Extraoral Analysis")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                // Empty view to balance the back button
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Patient Image
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=1000&auto=format&fit=crop")) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                            .overlay(ProgressView())
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 420)
                    .cornerRadius(16)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    // MARK: - AI Tags Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("AI Tags")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        
                        VStack(spacing: 4) {
                            AnalysisRow(title: "Facial Symmetry", status: .success)
                            AnalysisRow(title: "Lower Facial Height", status: .success)
                            AnalysisRow(title: "Smile Line", status: .success)
                            AnalysisRow(title: "Lip Competence", status: .success)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding(16)
            }
            
            // MARK: - Bottom Tab Bar
            VStack(spacing: 0) {
                Divider()
                    .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
                
                HStack(spacing: 0) {
                    TabBarItem(icon: "house", label: "Home", isSelected: false)
                    TabBarItem(icon: "briefcase", label: "Cases", isSelected: true)
                    TabBarItem(icon: "chart.bar.doc.horizontal", label: "Insights", isSelected: false)
                    TabBarItem(icon: "gearshape", label: "Settings", isSelected: false)
                }
                .padding(.top, 12)
                .padding(.bottom, 12) // Adjust for safe area
                .background(Color.white)
            }
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

// MARK: - Helper Components

private struct AnalysisRow: View {
    enum Status {
        case success, Warning, error
    }
    
    let title: String
    let status: Status
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
            
            Spacer()
            
            Circle()
                .fill(Color(red: 23/255, green: 166/255, blue: 96/255)) // Medical green
                .frame(width: 10, height: 10)
        }
        .padding(.vertical, 16)
        .background(Color.clear)
        // Add a subtle line between rows if desired
    }
}

private struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: isSelected ? "\(icon).fill" : icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? Color(red: 54/255, green: 92/255, blue: 178/255) : Color(red: 152/255, green: 162/255, blue: 179/255))
            
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(isSelected ? Color(red: 54/255, green: 92/255, blue: 178/255) : Color(red: 152/255, green: 162/255, blue: 179/255))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ExtraoralAnalysisView()
}
