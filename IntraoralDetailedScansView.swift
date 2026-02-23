import SwiftUI

struct IntraoralDetailedScansView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedIntraoralCategory = "Frontal"
    
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
                }
                .buttonStyle(.plain)
                
                Text("Intraoral Scan")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Divider()
                .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Completion Progress
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("COMPLETION PROGRESS")
                                .font(.system(size: 12, weight: .bold))
                            Spacer()
                            Text("3/5 Views")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(Color(red: 55/255, green: 65/255, blue: 81/255))
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4).fill(Color(red: 209/255, green: 213/255, blue: 219/255)).frame(height: 8)
                            RoundedRectangle(cornerRadius: 4).fill(Color(red: 37/255, green: 99/255, blue: 235/255)).frame(width: 180, height: 8)
                        }
                    }
                    .padding(.top, 8)
                    
                    Text("Select View to Upload")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                    
                    // Filter Tabs (Navigation Links)
                    HStack(spacing: 0) {
                        ForEach(["Frontal", "Occlusal", "Buccal"], id: \.self) { cat in
                            NavigationLink(destination: IntraoralUploadsListView(category: cat)) {
                                Text(cat)
                                    .font(.system(size: 14, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(Color.white)
                                    .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                                    .cornerRadius(8)
                                    .padding(4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .background(Color(red: 231/255, green: 235/255, blue: 243/255))
                    .cornerRadius(10)
                    
                    // Dental Arch Map Card
                    NavigationLink(destination: IntraoralUploadsListView(category: "Frontal")) {
                        VStack(alignment: .leading, spacing: 12) {
                            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1629909613654-28a3a7c4ad45?q=80&w=800&auto=format&fit=crop")) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                Color(red: 20/255, green: 80/255, blue: 80/255).overlay(ProgressView().tint(.white))
                            }
                            .frame(height: 180).frame(maxWidth: .infinity).cornerRadius(12).clipped()
                            .overlay(Image(systemName: "plus").font(.system(size: 30)).foregroundColor(.white))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Dental Arch Map").font(.system(size: 18, weight: .bold)).foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                                Text("Tap to navigate").font(.system(size: 14, weight: .medium)).foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 20) {
                        ScanGridItemMini(title: "Upper Occlusal", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Upper_occlusal_view_of_teeth.jpg/800px-Upper_occlusal_view_of_teeth.jpg", status: "Verified", isOptimal: false)
                        ScanGridItemMini(title: "Frontal View", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg", status: "Warning", isOptimal: false, showRetake: true)
                        ScanGridItemMini(title: "Lower Occlusal", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg", status: "Verified", isOptimal: true)
                        ScanGridItemMini(title: "Right Buccal", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg", status: "", isOptimal: false, isEmpty: true)
                    }
                }
                .padding(16)
            }
            
            Spacer()
            
            // MARK: - Navigation Button
            NavigationLink(destination: AIAnalysisProcessingView()) {
                Text("Run AI Analysis")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color(red: 0/255, green: 122/255, blue: 255/255)))
            }
            .padding(16)
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

private struct ScanGridItemMini: View {
    let title: String
    let imageURL: String
    let status: String
    let isOptimal: Bool
    var showRetake: Bool = false
    var isEmpty: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                if isEmpty { RoundedRectangle(cornerRadius: 12).fill(Color(red: 243/255, green: 244/255, blue: 246/255)).frame(height: 120) }
                else {
                    AsyncImage(url: URL(string: imageURL)) { image in image.resizable().scaledToFill() } placeholder: { Color.gray.opacity(0.1).overlay(ProgressView()) }
                    .frame(height: 120).frame(maxWidth: .infinity).background(Color.gray.opacity(0.1)).cornerRadius(12).clipped()
                }
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 14, weight: .bold))
                if !status.isEmpty { Text(status).font(.system(size: 12)).foregroundColor(status == "Warning" ? .red : .blue) }
                if isOptimal { Text("Verified - Optimal").font(.system(size: 10)).foregroundColor(.gray) }
                if showRetake { Text("Retake").font(.system(size: 12, weight: .semibold)).foregroundColor(.blue) }
            }
        }
    }
}
