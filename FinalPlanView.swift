import SwiftUI

struct FinalPlanView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    @State private var showDownloadSuccess = false
    
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
                
                Text("Final Plan")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Teeth illustration placeholder
                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.1)
                                .overlay(ProgressView())
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .background(Color.white)
                        .clipped()
                        
                        Text("Export & Presentation")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 16) {
                            Button {
                                exportReport()
                            } label: {
                                ExportRow(icon: "doc.text", title: "Export PDF Report", subtitle: "Generate a comprehensive PDF report for \(caseItem.patientName).")
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 20)
                }
                
                if showDownloadSuccess {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Text("Summary Download successfully")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(Color(red: 7/255, green: 136/255, blue: 59/255)))
                        .padding(.bottom, 40)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
                }
            }
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
    
    private func exportReport() {
        // Simulate download
        withAnimation(.spring()) {
            showDownloadSuccess = true
        }
        
        // Hide after some time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                showDownloadSuccess = false
            }
        }
    }
    
    private func shareLink() {
        let reportLink = "https://fmt-dentaai.com/reports/\(caseItem.patientId)"
        let activityVC = UIActivityViewController(activityItems: [reportLink], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}

private struct ExportRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 231/255, green: 235/255, blue: 243/255))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 16, weight: .bold)).foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                Text(subtitle).font(.system(size: 14)).foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 231/255, green: 235/255, blue: 243/255), lineWidth: 1))
    }
}

#Preview {
    FinalPlanView(caseItem: Case.sampleCases[0])
}
