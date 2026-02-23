import SwiftUI

struct IntraoralUploadsListView: View {
    @Environment(\.dismiss) var dismiss
    let category: String
    
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
                
                Text("Intraoral Uploads")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            Divider()
                .background(Color.appBorder)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Capture and upload intraoral photos to document the patient's treatment journey. Ensure clear, well-lit images for accurate assessment.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.appSecondaryText)
                    
                    VStack(spacing: 30) {
                        if category == "Frontal" {
                            UploadListRow(status: "Not Started", title: "Frontal View", description: "Capture the patient's teeth from the front, ensuring the midline is centered.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg")
                            UploadListRow(status: "Uploaded", title: "Frontal Smile", description: "Capture the frontal view while the patient is smiling naturally.", imageUrl: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop")
                        } else if category == "Occlusal" {
                            UploadListRow(status: "Uploaded", title: "Upper Arch", description: "Capture the upper arch from an occlusal view, showing all teeth clearly.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Upper_occlusal_view_of_teeth.jpg/800px-Upper_occlusal_view_of_teeth.jpg")
                            UploadListRow(status: "Not Started", title: "Lower Arch", description: "Capture the lower arch from an occlusal view, showing all teeth clearly.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg")
                        } else {
                            UploadListRow(status: "Not Started", title: "Right Buccal", description: "View of the right posterior teeth in occlusion.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg")
                            UploadListRow(status: "Uploaded", title: "Left Buccal", description: "View of the left posterior teeth in occlusion.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg")
                        }
                    }
                }
                .padding(16)
            }
            
            Spacer()
            
            // MARK: - Navigation Button
            Button {
                dismiss() // Return to the map page
            } label: {
                Text("Save and Continue")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.blue))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40) // Increased bottom padding to move it down
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

private struct UploadListRow: View {
    let status: String
    let title: String
    let description: String
    let imageUrl: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(status)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appSecondaryText)
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.appSecondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            
            AsyncImage(url: URL(string: imageUrl)) { image in 
                image.resizable().scaledToFill() 
            } placeholder: { 
                Color.appBorder.opacity(0.1) 
            }
            .frame(width: 120, height: 100)
            .cornerRadius(12)
            .clipped()
        }
    }
}

#Preview {
    NavigationStack {
        IntraoralUploadsListView(category: "Frontal")
    }
}
