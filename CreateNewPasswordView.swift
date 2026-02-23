import SwiftUI

struct CreateNewPasswordView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var newPassword = ""
    @State private var confirmPassword = ""

    @State private var showNewPassword = false
    @State private var showConfirmPassword = false

    // ✅ UI states
    @State private var isUpdatedSuccessfully = false
    @State private var showLogin = false
    @State private var errorText: String? = nil

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Top Bar (Back Button Removed)
            // Back arrow removed as per request
            VStack {
                 Spacer().frame(height: 10)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {

                    Text("Create New Password")
                        .font(.system(size: 22, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)

                    Text("Your new password must be different from previous passwords")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // ✅ Success message
                    if isUpdatedSuccessfully {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                            Text("Password updated successfully")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal)
                        .padding(.top, 6)
                    }

                    // ✅ Error message
                    if let errorText {
                        Text(errorText)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // MARK: - New Password
                    passwordField(
                        title: "New Password",
                        placeholder: "Enter new password",
                        text: $newPassword,
                        isVisible: $showNewPassword,
                        isDisabled: isUpdatedSuccessfully
                    )

                    // MARK: - Confirm Password
                    passwordField(
                        title: "Confirm New Password",
                        placeholder: "Confirm new password",
                        text: $confirmPassword,
                        isVisible: $showConfirmPassword,
                        isDisabled: isUpdatedSuccessfully
                    )

                    Spacer(minLength: 30)
                }
            }

            // MARK: - Bottom Buttons
            VStack(spacing: 12) {

                // ✅ 1) Update button (only before success)
                if !isUpdatedSuccessfully {
                    Button {
                        handleUpdatePassword()
                    } label: {
                        Text("Update Password")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .cornerRadius(10)
                    }
                }

                // ✅ 2) Back to Login button (only after success)
                if isUpdatedSuccessfully {
                    Button {
                        showLogin = true
                    } label: {
                        Text("Back to Login")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.systemGray6))
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color.white)

        // ✅ show login on button click (with NavigationStack)
        .fullScreenCover(isPresented: $showLogin) {
            NavigationStack {
                ClinicianLoginView()
            }
        }
    }

    // MARK: - Update Password Logic
    private func handleUpdatePassword() {
        errorText = nil

        guard !newPassword.isEmpty else {
            errorText = "Please enter a new password."
            return
        }

        guard newPassword == confirmPassword else {
            errorText = "Passwords do not match."
            return
        }

        // ✅ Success (replace this with your API call result later)
        isUpdatedSuccessfully = true
    }

    // MARK: - Reusable Password Field
    private func passwordField(title: String,
                               placeholder: String,
                               text: Binding<String>,
                               isVisible: Binding<Bool>,
                               isDisabled: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))

            HStack {
                if isVisible.wrappedValue {
                    TextField(placeholder, text: text)
                        .disabled(isDisabled)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                } else {
                    SecureField(placeholder, text: text)
                        .disabled(isDisabled)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }

                Button {
                    isVisible.wrappedValue.toggle()
                } label: {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
                .disabled(isDisabled)
            }
            .padding()
            .frame(height: 56)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

