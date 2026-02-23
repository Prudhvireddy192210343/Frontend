import SwiftUI

struct Language: Identifiable {
    let id: String
    let name: String
    let nativeName: String
}

struct LanguagesView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedLanguageCode") private var selectedLanguageCode = "en"
    @AppStorage("selectedLanguageName") private var selectedLanguageName = "English"
    
    let languages = [
        Language(id: "en", name: "English", nativeName: "English"),
        Language(id: "hi", name: "Hindi", nativeName: "हिन्दी"),
        Language(id: "bn", name: "Bengali", nativeName: "বাংলা"),
        Language(id: "te", name: "Telugu", nativeName: "తెలుగు"),
        Language(id: "mr", name: "Marathi", nativeName: "मराठी"),
        Language(id: "ta", name: "Tamil", nativeName: "தமிழ்"),
        Language(id: "gu", name: "Gujarati", nativeName: "ગુજરાતી"),
        Language(id: "ur", name: "Urdu", nativeName: "اردو"),
        Language(id: "kn", name: "Kannada", nativeName: "ಕನ್ನಡ"),
        Language(id: "ml", name: "Malayalam", nativeName: "മലയാളം"),
        Language(id: "pa", name: "Punjabi", nativeName: "ਪੰਜਾਬੀ")
    ]
    
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
                
                Text("Select Language")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color.appCardBackground)
            
            Divider()
                .background(Color.appBorder)
            
            List {
                ForEach(languages) { language in
                    Button {
                        selectedLanguageCode = language.id
                        selectedLanguageName = language.name
                        // Optional: dismiss() // Auto-dismiss after selection? 
                        // User mentioned "allow access to select any language", maybe they want to see the checkmark first.
                    } label: {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(selectedLanguageCode == language.id ? Color.blue.opacity(0.1) : Color.appBorder.opacity(0.1))
                                    .frame(width: 44, height: 44)
                                Text(language.id.uppercased())
                                    .font(.system(size: 14, weight: .black))
                                    .foregroundColor(selectedLanguageCode == language.id ? .blue : .appSecondaryText)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(language.name)
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.appPrimaryText)
                                Text(language.nativeName)
                                    .font(.system(size: 14))
                                    .foregroundColor(.appSecondaryText)
                            }
                            
                            Spacer()
                            
                            if selectedLanguageCode == language.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 22))
                            }
                        }
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.appCardBackground)
                    .listRowSeparatorTint(Color.appBorder)
                }
            }
            .listStyle(.plain) // Standard list for better density
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        LanguagesView()
    }
}
