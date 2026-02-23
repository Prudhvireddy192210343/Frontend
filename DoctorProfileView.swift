import SwiftUI

struct DoctorProfileView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var selectedSpecialty = "Select specialty"
    @State private var yearsOfExperience = ""
    @State private var clinicName = ""
    @State private var showPhotoPicker = false
    @State private var showUpdateSuccess = false

    private let specialties = [
        "Select specialty",
        "Prosthodontist",
        "Orthodontist",
        "Periodontist",
        "Endodontist",
        "Oral Surgeon",
        "General Dentist"
    ]

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Top Bar
            HStack {
                Button { dismiss() } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.appPrimaryText)
                    .frame(height: 44)
                }
                .buttonStyle(.plain)

                Text("Doctor Profile")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                    .frame(maxWidth: .infinity)

                // Right spacing
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(Color.appCardBackground)

            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // MARK: - Avatar + Text
                        VStack(spacing: 14) {
                            Button {
                                // Action to change photo
                                showPhotoPicker = true
                            } label: {
                                ZStack(alignment: .bottomTrailing) {
                                    AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuAIBCLjd2d9Qz3kGT0Y0XMWR5jheo3V3IVd9ZMO3GU0xp9QPDdtOXZB3b24lsDYOX0qOVnBrF96PHGkxopMvPoXfh9ZT9KKjhFHr8iUHf2kMd_aU7mLnLRlxeNMRq2goWUzdA3a5BPpf9uFSYG5LW8JN3FnNT_WvyZ40C7yDncRheXAAp6gZArDihfZG5r7sTADi9k_vTaTnuwF9vUl3vI2SJT60Q2aUvq5vpjbw8IJXG_qQdzlWMejiLyU-0Yl_ICnJ-eX4MBFaIQ")) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.15)
                                    }
                                    .frame(width: 128, height: 128)
                                    .clipShape(Circle())
                                    
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .offset(x: -4, y: -4)
                                }
                            }
                            .buttonStyle(.plain)
                            .alert("Change Profile Photo", isPresented: $showPhotoPicker) {
                                Button("Choose from Library") { }
                                Button("Take Photo") { }
                                Button("Cancel", role: .cancel) { }
                            }

                            VStack(spacing: 6) {
                                Text("Set up your clinical profile")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.appPrimaryText)
                                    .multilineTextAlignment(.center)

                                Text("Complete your details for personalized AI-assisted planning")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.appSecondaryText)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 16)

                        // MARK: - Fields
                        fieldText(title: "Full Name", placeholder: "Dr. Amelia Hayes", text: $fullName)

                        specialtyPicker()

                        fieldText(title: "Years of Experience", placeholder: "e.g. 10", text: $yearsOfExperience, keyboard: .numberPad)

                        fieldText(title: "Clinic Name", placeholder: "Bright Smile Clinic", text: $clinicName)

                        // MARK: - Update Button
                        Button {
                            withAnimation {
                                showUpdateSuccess = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showUpdateSuccess = false
                                }
                            }
                        } label: {
                            Text("Update")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.blue)
                                .cornerRadius(12)
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                    }
                }
                
                if showUpdateSuccess {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Text("Profile Updated Successfully")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(Color.green))
                        .padding(.bottom, 40)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
                }
            }
            .background(Color.appBackground)
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }

    // MARK: - Reusable Field
    private func fieldText(title: String,
                           placeholder: String,
                           text: Binding<String>,
                           keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)

            TextField("", text: text, prompt: Text(placeholder).foregroundColor(.appSecondaryText.opacity(0.5)))
                .keyboardType(keyboard)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled(true)
                .foregroundColor(.appPrimaryText)
                .padding(.horizontal, 15)
                .frame(height: 56)
                .background(Color.appCardBackground)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    // MARK: - Specialty Picker (looks like dropdown)
    private func specialtyPicker() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Specialty")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)

            Menu {
                ForEach(specialties, id: \.self) { item in
                    Button(item) { selectedSpecialty = item }
                }
            } label: {
                HStack {
                    Text(selectedSpecialty)
                        .foregroundColor(selectedSpecialty == "Select specialty"
                                         ? .appSecondaryText.opacity(0.5)
                                         : .appPrimaryText)
                        .font(.system(size: 16, weight: .regular))

                    Spacer()

                    Image(systemName: "chevron.down")
                        .foregroundColor(.appSecondaryText)
                        .font(.system(size: 14, weight: .semibold))
                }
                .padding(.horizontal, 15)
                .frame(height: 56)
                .background(Color.appCardBackground)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationStack {
        DoctorProfileView()
    }
}


