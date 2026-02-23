import SwiftUI

struct SignUpView: View {

    enum Role: String {
        case doctor = "Doctor"
    }

    @State private var selectedRole: Role = .doctor
    @State private var fullName = ""
    @State private var email = ""
    @State private var mobile = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var goToLogin = false
    @State private var showSuccessMessage = false

    private var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // MARK: - Role (Doctor only)
                        HStack {
                            Text("Doctor Registration")
                                .font(.headline)
                                .foregroundColor(.appPrimaryText)
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                        }

                        // MARK: - Input Fields
                        inputField(
                            title: "Full Name",
                            placeholder: "Enter your full name",
                            text: $fullName
                        )

                        inputField(
                            title: "Email Address",
                            placeholder: "Enter your email",
                            text: $email,
                            keyboard: .emailAddress
                        )

                        inputField(
                            title: "Mobile Number",
                            placeholder: "Enter your mobile number",
                            text: $mobile,
                            keyboard: .numberPad
                        )

                        // MARK: - Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.appPrimaryText)

                            SecureField("Create a password", text: $password)
                                .padding()
                                .frame(height: 56)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                .foregroundColor(.appPrimaryText)
                        }

                        // MARK: - Re-enter Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Re-enter Password")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.appPrimaryText)

                            SecureField("Confirm your password", text: $confirmPassword)
                                .padding()
                                .frame(height: 56)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                .foregroundColor(.appPrimaryText)

                            if !confirmPassword.isEmpty && !passwordsMatch {
                                Text("Passwords do not match")
                                    .font(.system(size: 13))
                                    .foregroundColor(.red)
                            }
                        }

                        // MARK: - Create Account
                        Button(action: createAccount) {
                            Text("Create Account")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, minHeight: 55)
                                .background(passwordsMatch ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .disabled(!passwordsMatch)
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $goToLogin) {
                ClinicianLoginView()
            }
            .overlay(
                Group {
                    if showSuccessMessage {
                        ZStack {
                            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                            VStack(spacing: 16) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.green)
                                
                                Text("Registered Successfully")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(40)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(24)
                        }
                    }
                }
            )
        }
    }

    // MARK: - Reusable Input Field
    private func inputField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)

            TextField(placeholder, text: text)
                .keyboardType(keyboard)
                .textInputAutocapitalization(.none)
                .padding()
                .frame(height: 56)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .foregroundColor(.appPrimaryText)
        }
    }

    // MARK: - Create Account Action
    private func createAccount() {
        showSuccessMessage = true
        
        // Delay navigation to show success message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            goToLogin = true
        }
    }
}

// Extension to add success overlay (simulated since I can't easily wrap the whole body in a ZStack without changing indentation of everything)
// Actually, I should just change the body to include the overlay.
// But replace_file_content works on chunks. I'll use multi_replace.


#Preview {
    SignUpView()
}
