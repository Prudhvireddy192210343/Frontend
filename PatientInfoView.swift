import SwiftUI

struct PatientInfoView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case?
    
    @State private var patientName: String
    @State private var patientAge: String
    @State private var patientGender: String
    let genderOptions = ["Male", "Female", "Other"]
    
    init(caseItem: Case? = nil) {
        self.caseItem = caseItem
        
        if let caseItem = caseItem {
            _patientName = State(initialValue: caseItem.patientName)
            
            // Try to parse Age/Gender from medicalHistory which is formatted as "Age: X, Gender: Y"
            let parsed = parseMedicalHistory(caseItem.medicalHistory)
            _patientAge = State(initialValue: parsed.age)
            _patientGender = State(initialValue: parsed.gender)
        } else {
            _patientName = State(initialValue: CaseRepository.shared.draftPatientName)
            _patientAge = State(initialValue: CaseRepository.shared.draftPatientAge)
            _patientGender = State(initialValue: CaseRepository.shared.draftPatientGender)
        }
    }
    
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
                
                Text("Patient Information")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            Divider()
                .background(Color.appBorder)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    Text("Enter the patient's basic details to start the case analysis.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.appSecondaryText)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Patient Name")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.appPrimaryText)
                            
                            TextField("Enter patient name", text: $patientName)
                                .padding(16)
                                .background(Color.appCardBackground)
                                .cornerRadius(12)
                                .foregroundColor(.appPrimaryText)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.appBorder, lineWidth: 1)
                                )
                        }
                        
                        // MARK: - Age & Gender
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Age")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.appPrimaryText)
                                
                                TextField("Age", text: $patientAge)
                                    .keyboardType(.numberPad)
                                    .padding(16)
                                    .background(Color.appCardBackground)
                                    .cornerRadius(12)
                                    .foregroundColor(.appPrimaryText)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.appBorder, lineWidth: 1)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Gender")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.appPrimaryText)
                                
                                Menu {
                                    ForEach(genderOptions, id: \.self) { gender in
                                        Button(gender) {
                                            patientGender = gender
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(patientGender)
                                            .foregroundColor(.appPrimaryText)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 12))
                                            .foregroundColor(.appSecondaryText)
                                    }
                                    .padding(16)
                                    .background(Color.appCardBackground)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.appBorder, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .onChange(of: patientName) { newValue in
                            if caseItem != nil {
                                updateCase(name: newValue)
                            } else {
                                CaseRepository.shared.draftPatientName = newValue
                            }
                        }
                        .onChange(of: patientAge) { newValue in
                            if caseItem != nil {
                                updateCase(age: newValue)
                            } else {
                                CaseRepository.shared.draftPatientAge = newValue
                            }
                        }
                        .onChange(of: patientGender) { newValue in
                            if caseItem != nil {
                                updateCase(gender: newValue)
                            } else {
                                CaseRepository.shared.draftPatientGender = newValue
                            }
                        }
                    }
                }
                .padding(16)
            }
            
            Spacer()
            
            // MARK: - Navigation Button
            if caseItem != nil {
                Button {
                    dismiss()
                } label: {
                    Text("Save & Close")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.blue)
                        )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            } else {
                NavigationLink(destination: MedicalDentalHistoryView()) {
                    Text("Continue to Medical History")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.blue)
                        )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
    
    private func updateCase(name: String? = nil, age: String? = nil, gender: String? = nil) {
        guard let originalCase = caseItem,
              let index = CaseRepository.shared.cases.firstIndex(where: { $0.id == originalCase.id }) else { return }
        
        var updatedCase = CaseRepository.shared.cases[index]
        if let name = name { updatedCase.patientName = name }
        
        // Handle age/gender update in medicalHistory string
        let currentInfo = parseMedicalHistory(updatedCase.medicalHistory)
        let newAge = age ?? currentInfo.age
        let newGender = gender ?? currentInfo.gender
        updatedCase.medicalHistory = "Age: \(newAge), Gender: \(newGender)"
        
        CaseRepository.shared.cases[index] = updatedCase
        CaseRepository.shared.saveCases()
    }
    
    private func parseMedicalHistory(_ raw: String) -> (age: String, gender: String) {
        var age = "N/A"
        var gender = "Male"
        
        if let ageRange = raw.range(of: "Age: "),
           let commaRange = raw.range(of: ",", range: ageRange.upperBound..<raw.endIndex) {
            age = String(raw[ageRange.upperBound..<commaRange.lowerBound]).trimmingCharacters(in: .whitespaces)
        }
        
        if let genderRange = raw.range(of: "Gender: ") {
            gender = String(raw[genderRange.upperBound...]).trimmingCharacters(in: .whitespaces)
        }
        
        return (age, gender)
    }
}
