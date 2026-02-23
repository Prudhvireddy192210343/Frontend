import SwiftUI

struct VerifyAccountView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var otp = ""
    @State private var goToCreatePassword = false

    var body: some View {
        VStack(spacing: 20) {

            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Text("Verify Account")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 10)

            Text("Enter the 6-digit code sent to your email/phone.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            TextField("Enter OTP", text: $otp)
                .keyboardType(.numberPad)
                .padding()
                .frame(height: 55)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)

            Button {
                // ✅ Go to create new password
                goToCreatePassword = true
            } label: {
                Text("Verify")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .buttonStyle(.plain)

            Spacer()

        }
        .background(Color.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $goToCreatePassword) {
            CreateNewPasswordView()
        }
    }
}
