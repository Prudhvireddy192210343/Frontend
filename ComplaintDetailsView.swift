import SwiftUI

struct ComplaintDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var additionalDetails = ""
    
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
                
                Text("Additional Details")
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
                VStack(alignment: .leading, spacing: 20) {
                    Text("Describe your symptoms in detail.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(red: 76/255, green: 102/255, blue: 154/255))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TextEditor(text: $additionalDetails)
                            .frame(height: 150)
                            .padding(12)
                            .background(Color(red: 242/255, green: 244/255, blue: 248/255))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 207/255, green: 215/255, blue: 231/255), lineWidth: 1)
                            )
                    }
                }
                .padding(16)
            }
            .onChange(of: additionalDetails) { newValue in
                CaseRepository.shared.draftAdditionalDetails = newValue
            }
            
            Spacer()
            
            // MARK: - Navigation Button
            NavigationLink(destination: PatientInfoView()) {
                Text("Continue to Patient Information")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(red: 0/255, green: 122/255, blue: 255/255))
                    )
            }
            .padding(16)
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}
