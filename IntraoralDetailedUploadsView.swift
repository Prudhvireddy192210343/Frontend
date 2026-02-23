import SwiftUI

struct IntraoralDetailedUploadsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategory: String
    
    // Data structures for different views
    struct UploadItem: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let status: String
        let imageUrl: String
        let isUploaded: Bool
    }
    
    init(category: String = "Frontal") {
        _selectedCategory = State(initialValue: category)
    }
    
    private var items: [UploadItem] {
        switch selectedCategory {
        case "Frontal":
            return [
                UploadItem(
                    title: "Frontal View",
                    description: "Capture the patient's teeth from the front, ensuring the midline is centered.",
                    status: "Not Started",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg",
                    isUploaded: false
                ),
                UploadItem(
                    title: "Frontal Smile",
                    description: "Capture the frontal view while the patient is smiling naturally.",
                    status: "Uploaded",
                    imageUrl: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop",
                    isUploaded: true
                ),
                UploadItem(
                    title: "Overbite View",
                    description: "Close-up view of the incisor relationship from the front.",
                    status: "Not Started",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Human_teeth_open_mouth.jpg/800px-Human_teeth_open_mouth.jpg",
                    isUploaded: false
                )
            ]
        case "Occlusal":
            return [
                UploadItem(
                    title: "Upper Arch",
                    description: "Capture the upper arch from an occlusal view, showing all teeth clearly.",
                    status: "Uploaded",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Upper_occlusal_view_of_teeth.jpg/800px-Upper_occlusal_view_of_teeth.jpg",
                    isUploaded: true
                ),
                UploadItem(
                    title: "Lower Arch",
                    description: "Capture the lower arch from an occlusal view, showing all teeth clearly.",
                    status: "Not Started",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg",
                    isUploaded: false
                ),
                UploadItem(
                    title: "Bite Registration",
                    description: "Occlusal view with bite registration material in place.",
                    status: "Not Started",
                    imageUrl: "https://images.unsplash.com/photo-1629909613654-28a3a7c4ad45?q=80&w=400&auto=format&fit=crop",
                    isUploaded: false
                )
            ]
        case "Buccal":
            return [
                UploadItem(
                    title: "Right Buccal",
                    description: "View of the right posterior teeth in occlusion.",
                    status: "Uploaded",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg",
                    isUploaded: true
                ),
                UploadItem(
                    title: "Left Buccal",
                    description: "View of the left posterior teeth in occlusion.",
                    status: "Not Started",
                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg", // Mirror image or similar
                    isUploaded: false
                ),
                UploadItem(
                    title: "Anterior Buccal",
                    description: "Close-up of the front teeth relationship from the side.",
                    status: "Not Started",
                    imageUrl: "https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=400&auto=format&fit=crop",
                    isUploaded: false
                )
            ]
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.appPrimaryText)
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Intraoral Uploads")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Description Text
                    Text("Capture and upload intraoral photos to document the patient's treatment journey. Ensure clear, well-lit images for accurate assessment.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.appSecondaryText)
                        .lineSpacing(4)
                        .padding(.top, 8)
                    
                    // MARK: - Filter Tabs (to switch between categories)
                    HStack(spacing: 0) {
                        ForEach(["Frontal", "Occlusal", "Buccal"], id: \.self) { cat in
                            Button {
                                withAnimation(.spring()) {
                                    selectedCategory = cat
                                }
                            } label: {
                                Text(cat)
                                    .font(.system(size: 14, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(selectedCategory == cat ? Color.blue : Color.appCardBackground)
                                    .foregroundColor(selectedCategory == cat ? .white : .appSecondaryText)
                                    .cornerRadius(8)
                                    .padding(4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .background(Color.appBorder.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.vertical, 8)
                    
                    // MARK: - Upload List
                    VStack(spacing: 32) {
                        ForEach(items) { item in
                            UploadRow(item: item)
                        }
                    }
                    .padding(.bottom, 60) // Increased padding
                }
                .padding(.horizontal, 20)
            }
            
            // MARK: - Bottom Button
            VStack(spacing: 0) {
                Button {
                    dismiss()
                } label: {
                    Text("Save and Continue")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40) // Increased from 20 to 40
                .background(Color.appCardBackground)
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

// MARK: - Helper Components

private struct UploadRow: View {
    let item: IntraoralDetailedUploadsView.UploadItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.status)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appSecondaryText)
                
                Text(item.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Text(item.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.appSecondaryText)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(2)
            }
            
            Spacer()
            
            // Thumbnail
            ZStack {
                AsyncImage(url: URL(string: item.imageUrl)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.appBorder.opacity(0.1)
                }
                .frame(width: 120, height: 100)
                .cornerRadius(12)
                .clipped()
                
                if item.isUploaded {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .padding(6)
                        }
                    }
                }
            }
            .frame(width: 120, height: 100)
        }
    }
}

#Preview {
    NavigationStack {
        IntraoralDetailedUploadsView()
    }
}
