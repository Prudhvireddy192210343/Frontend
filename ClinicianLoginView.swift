import SwiftUI

struct ClinicianLoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    // ✅ Navigation trigger
    @State private var goToHome = false

    // ✅ optional error text
    @State private var errorText: String? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                // ✅ Hidden NavigationLink to MainTabView
                NavigationLink(destination: MainTabView().navigationBarBackButtonHidden(true),
                               isActive: $goToHome) {
                    EmptyView()
                }
                .hidden()

                // Title
                Text("Clinician Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                // Logo Card
                ZStack {
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.18, blue: 0.25),
                            Color(red: 0.02, green: 0.10, blue: 0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140)
                }
                .frame(height: 200)
                .cornerRadius(18)
                .padding(.horizontal)

                // Welcome
                VStack(spacing: 6) {
                    Text("Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.appPrimaryText)

                    Text("Sign in to access rehabilitation plans")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                }

                // ✅ error message
                if let errorText {
                    Text(errorText)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Email
                HStack {
                    TextField("Enter professional email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Image(systemName: "envelope")
                        .foregroundColor(.appSecondaryText)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)

                // Password
                HStack {
                    if showPassword {
                        TextField("Enter your password", text: $password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    } else {
                        SecureField("Enter your password", text: $password)
                    }

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.appSecondaryText)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)

                // Forgot Password → Navigate to ForgotPasswordView
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.blue)
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)

                // ✅ Login → DoctorHomeView
                Button {
                    errorText = nil

                    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

                    guard !trimmedEmail.isEmpty else {
                        errorText = "Please enter your email."
                        return
                    }

                    guard !trimmedPassword.isEmpty else {
                        errorText = "Please enter your password."
                        return
                    }

                    // ✅ If login success (replace with API call later)
                    goToHome = true

                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(16)
                }
                .buttonStyle(.plain)

                Text("OR")
                    .foregroundColor(.appSecondaryText)
                    .font(.footnote.bold())

                // Sign Up → SignUpView
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        Image(systemName: "person")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(Color(.systemGray6))
                    .foregroundColor(.appPrimaryText)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)

                // Footer
                VStack(spacing: 8) {
                    Text("Terms of Service | Privacy Policy")
                        .font(.footnote)
                        .foregroundColor(.appSecondaryText)

                    Text("Secure HIPAA Compliance")
                        .font(.footnote)
                        .foregroundColor(.appSecondaryText)
                }
            }
            .padding()
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        ClinicianLoginView()
    }
}
