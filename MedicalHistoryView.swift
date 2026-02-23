import SwiftUI

struct MedicalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    // State for selections
    @State private var selectedPDI: String?
    @State private var selectedSkeletal: String?
    @State private var selectedHorizontalCondylar: String?
    @State private var selectedIncisal: String?
    @State private var selectedWorkingSide: String?
    @State private var selectedNonWorkingSide: String?
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Text("Medical & Dental History")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Divider()
                .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    
                    // MARK: - Preliminary Diagnosis
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Preliminary Diagnosis")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                SelectionChip(title: "PDI Class I", isSelected: selectedPDI == "PDI Class I") {
                                    selectedPDI = "PDI Class I"
                                }
                                SelectionChip(title: "PDI Class II", isSelected: selectedPDI == "PDI Class II") {
                                    selectedPDI = "PDI Class II"
                                }
                                SelectionChip(title: "PDI Class III", isSelected: selectedPDI == "PDI Class III") {
                                    selectedPDI = "PDI Class III"
                                }
                            }
                            
                            SelectionChip(title: "PDI Class IV", isSelected: selectedPDI == "PDI Class IV") {
                                selectedPDI = "PDI Class IV"
                            }
                        }
                    }
                    
                    // MARK: - Skeletal Relation
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            SelectionChip(title: "Skeletal Relation I", isSelected: selectedSkeletal == "Skeletal Relation I") {
                                selectedSkeletal = "Skeletal Relation I"
                            }
                            SelectionChip(title: "Skeletal Relation II", isSelected: selectedSkeletal == "Skeletal Relation II") {
                                selectedSkeletal = "Skeletal Relation II"
                            }
                        }
                        
                        SelectionChip(title: "Skeletal Relation III", isSelected: selectedSkeletal == "Skeletal Relation III") {
                            selectedSkeletal = "Skeletal Relation III"
                        }
                    }
                    
                    // MARK: - Derive Diagnosis Header
                    Text("Derive Diagnosis")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .padding(.top, 8)
                    
                    // MARK: - Horizontal Condylar Guidance
                    Group {
                        SelectionSection(title: "Horizontal Condylar Guidance", options: ["Steep", "Average", "Shallow"], selection: $selectedHorizontalCondylar)
                        
                        SelectionSection(title: "Incisal Guidance", options: ["Steep", "Average", "Shallow"], selection: $selectedIncisal)
                        
                        SelectionSection(title: "Working Side", options: ["Group Function", "Canine Guidance"], selection: $selectedWorkingSide)
                        
                        SelectionSection(title: "Non-Working Side", options: ["Contact", "No Contact"], selection: $selectedNonWorkingSide)
                    }
                }
                .padding(20)
                .padding(.bottom, 20)
            }
            
            // Continue Button (similar to ChiefComplaintView)
            VStack(spacing: 0) {
                Divider()
                    .overlay(Color(red: 231/255, green: 235/255, blue: 243/255))
                
                Button {
                    // Action
                } label: {
                    Text("Continue")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(red: 0/255, green: 122/255, blue: 255/255))
                        )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

// MARK: - Helper Views

private struct SelectionSection: View {
    let title: String
    let options: [String]
    @Binding var selection: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
            
            HStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    SelectionChip(title: option, isSelected: selection == option) {
                        selection = option
                    }
                }
            }
        }
    }
}

private struct SelectionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isSelected ? .white : Color(red: 13/255, green: 18/255, blue: 27/255))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .fixedSize(horizontal: true, vertical: false) // Prevent wrapping
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color(red: 0/255, green: 122/255, blue: 255/255) : Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color(red: 0/255, green: 122/255, blue: 255/255) : Color(red: 231/255, green: 235/255, blue: 243/255), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MedicalHistoryView()
}

