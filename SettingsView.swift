import SwiftUI

// MARK: - Settings Screen
struct SettingsView: View {

    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("selectedLanguageName") private var selectedLanguageName = "English"
    @State private var isLoggedOut = false

    var body: some View {
        VStack(spacing: 0) {
            
            // Logged Out Navigation
            NavigationLink(destination: ClinicianLoginView().navigationBarBackButtonHidden(true), isActive: $isLoggedOut) {
                EmptyView()
            }

            // MARK: - Header
            HStack {
                Text("Settings")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 20)
            .background(Color.appCardBackground)

            List {
                Section {
                    NavigationLink(destination: DoctorProfileView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                                .frame(width: 32)
                            Text("Profile")
                                .font(.system(size: 18))
                        }
                    }
                    
                    NavigationLink(destination: CreateNewPasswordView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                                .frame(width: 32)
                            Text("Password & Security")
                                .font(.system(size: 18))
                        }
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.orange)
                                .frame(width: 32)
                            Text("Notifications")
                                .font(.system(size: 18))
                        }
                    }

                    // Moved Language from top card to here
                    NavigationLink(destination: LanguagesView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "globe")
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                                .frame(width: 32)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Language")
                                    .font(.system(size: 18))
                                Text(selectedLanguageName)
                                    .font(.system(size: 14))
                                    .foregroundColor(.appSecondaryText)
                            }
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $isDarkMode) {
                        HStack(spacing: 16) {
                            Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                                .font(.system(size: 24))
                                .foregroundColor(isDarkMode ? .purple : .orange)
                                .frame(width: 32)
                            Text("Dark Mode")
                                .font(.system(size: 18))
                        }
                    }
                }
                
                Section {
                    Button(role: .destructive) {
                        isLoggedOut = true
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 24))
                                .frame(width: 32)
                            Text("Log Out")
                                .font(.system(size: 18))
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .background(Color.appBackground.ignoresSafeArea())
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

