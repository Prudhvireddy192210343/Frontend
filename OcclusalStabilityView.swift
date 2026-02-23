import SwiftUI

struct OcclusalStabilityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var stabilizationRequired = false
    
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
                
                Spacer()
                
                Text("Occlusal Stability")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    // MARK: - Occlusal Contact Visualization
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Occlusal Contact Visualization")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                        
                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Lower_occlusal_view.jpg/800px-Lower_occlusal_view.jpg")) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color(red: 31/255, green: 41/255, blue: 55/255)
                                .overlay(ProgressView().tint(.white))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(12)
                        .clipped()
                        
                        HStack {
                            Text("Posterior Collapse")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 55/255, green: 65/255, blue: 81/255))
                            Spacer()
                            Text("Present")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                        }
                        .padding(.top, 8)
                    }
                    
                    // MARK: - Final Result
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Final Result")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 17/255, green: 24/255, blue: 39/255))
                        
                        HStack {
                            Text("Stabilization Required")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 55/255, green: 65/255, blue: 81/255))
                            Spacer()
                            Toggle("", isOn: $stabilizationRequired)
                                .labelsHidden()
                                .toggleStyle(SwitchToggleStyle())
                                .tint(Color(red: 37/255, green: 99/255, blue: 235/255))

                        }
                    }







                }
                .padding(16)
            }
            
            Spacer()
            
            // MARK: - Next Button
            NavigationLink(destination: EstheticAssessmentView()) {
                Text("Next")
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
            .padding(16)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}
