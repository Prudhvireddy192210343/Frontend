import SwiftUI

struct ForgotPasswordView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var emailOrPhone = ""
    @State private var navigateToVerify = false

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    Image("forgot_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)

                    Text("Forgot Password")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)

                    Text("Enter your email or phone to receive a 6-digit verification code.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)

                    TextField("Email or Mobile Number", text: $emailOrPhone)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding()
                        .frame(height: 55)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)

                    Button {
                        print("Resend tapped")
                    } label: {
                        Text("Didn't receive a code? Resend")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .buttonStyle(.plain)

                    Button {
                        // ✅ move to verify page
                        navigateToVerify = true
                    } label: {
                        Text("Get Verification Code")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .buttonStyle(.plain)

                    Button { dismiss() } label: {
                        Text("Back to Login")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .buttonStyle(.plain)

                    Spacer().frame(height: 30)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)

        // ✅ NEXT PAGE
        .navigationDestination(isPresented: $navigateToVerify) {
            VerifyAccountView()
        }
    }
}
