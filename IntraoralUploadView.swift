import SwiftUI

struct IntraoralUploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab = "Occlusal"
    
    let tabs = ["Frontal", "Occlusal", "Buccal"]
    
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
                
                Text("Intraoral Scan")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Button {
                    // Help action
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .trailing)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Completion Progress
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("COMPLETION PROGRESS")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(red: 55/255, green: 65/255, blue: 81/255))
                            
                            Spacer()
                            
                            Text("3/5 Views")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 55/255, green: 65/255, blue: 81/255))
                        }
                        
                        // Custom Progress Bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 209/255, green: 213/255, blue: 219/255))
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                                    .frame(width: geo.size.width * 0.6, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                    .padding(.top, 8)
                    
                    // MARK: - Select View to Upload
                    Text("Select View to Upload")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                    
                    // MARK: - Dental Arch Map Card
                    VStack(alignment: .leading, spacing: 12) {
                        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1629909613654-28a3a7c4ad45?q=80&w=800&auto=format&fit=crop")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color(red: 20/255, green: 80/255, blue: 80/255)
                                .overlay(ProgressView().tint(.white))
                        }
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .clipped()
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                            }
                        )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dental Arch Map")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                            
                            Text("Tap to navigate")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                        }
                    }
                    
                    // MARK: - Filter Tabs
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button {
                                withAnimation {
                                    selectedTab = tab
                                }
                            } label: {
                                Text(tab)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(selectedTab == tab ? Color.white : Color(red: 237/255, green: 242/255, blue: 249/255))
                                    .foregroundColor(selectedTab == tab ? Color(red: 17/255, green: 24/255, blue: 39/255) : Color(red: 76/255, green: 102/255, blue: 154/255))
                                    .cornerRadius(8)
                                    .padding(4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .background(Color(red: 231/255, green: 235/255, blue: 243/255))
                    .cornerRadius(10)
                    
                    // MARK: - Image Grid
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 20) {
                        ScanGridItem(
                            title: "Upper Occlusal",
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Upper_occlusal_view_of_teeth.jpg/800px-Upper_occlusal_view_of_teeth.jpg",
                            status: .verified,
                            verificationText: "Verified"
                        )
                        
                        ScanGridItem(
                            title: "Frontal View",
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg",
                            status: .warning,
                            verificationText: "Warning",
                            retakeEnabled: true
                        )
                        
                        ScanGridItem(
                            title: "Lower Occlusal",
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg",
                            status: .verified,
                            verificationText: "Verified",
                            subStatus: "Verified - Optimal"
                        )
                        
                        ScanGridItem(
                            title: "Right Buccal",
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg",
                            status: .empty,
                            verificationText: ""
                        )
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 16)
            }
            
            // MARK: - Launch AI Camera Button
            VStack(spacing: 0) {
                Divider()
                    .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
                
                Button {
                    // Camera action
                } label: {
                    Text("Launch AI Camera")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                        )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

// MARK: - Helper Components

private struct ScanGridItem: View {
    enum Status {
        case verified, warning, empty
    }
    
    let title: String
    let imageURL: String
    let status: Status
    let verificationText: String
    var subStatus: String? = nil
    var retakeEnabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                if status == .empty {
                    // Empty state (still showing a placeholder but styled)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 243/255, green: 244/255, blue: 246/255))
                        .frame(height: 160)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 30))
                                .foregroundColor(Color(red: 156/255, green: 163/255, blue: 175/255))
                        )
                } else {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                            .overlay(ProgressView())
                    }
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .clipped()
                }
                
                if status == .verified {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .background(Circle().fill(Color.white))
                                .padding(8)
                        }
                        Spacer()
                    }
                }
            }
            .frame(height: 160)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                
                if !verificationText.isEmpty {
                    Text(verificationText)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(status == .warning ? Color.blue : Color(red: 71/255, green: 85/255, blue: 105/255))
                }
                
                if let subStatus = subStatus {
                    Text(subStatus)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 71/255, green: 85/255, blue: 105/255))
                }
                
                if retakeEnabled {
                    Button {
                        // Retake action
                    } label: {
                        Text("Retake")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(red: 37/255, green: 99/255, blue: 235/255))
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 2)
                }
            }
        }
    }
}

#Preview {
    IntraoralUploadView()
}
