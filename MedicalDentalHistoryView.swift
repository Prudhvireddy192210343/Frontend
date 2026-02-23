import SwiftUI

struct MedicalDentalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    // Preliminary Diagnosis
    @State private var selectedPDI: String?
    @State private var selectedSkeletal: String?
    
    // Derive Diagnosis
    @State private var selectedHorizontalCondylar: String?
    @State private var selectedIncisal: String?
    @State private var selectedWorkingSide: String?
    @State private var selectedNonWorkingSide: String?
    @State private var selectedProtrusion: String?
    @State private var selectedRetrusion: String?
    @State private var selectedRightLateralMove: String?
    @State private var selectedLeftLateralMove: String?
    @State private var selectedCentricFrontal: String?
    @State private var selectedProtrusionCentre: String?
    @State private var selectedRightLateralCentre: String?
    @State private var selectedLeftLateralCentre: String?
    
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
                
                Spacer()
                
                Text("Medical & Dental History")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    
                    // MARK: - Preliminary Diagnosis
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Preliminary Diagnosis")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                SelectionChip(title: "PDI Class I", isSelected: selectedPDI == "PDI Class I") { selectedPDI = "PDI Class I" }
                                SelectionChip(title: "PDI Class II", isSelected: selectedPDI == "PDI Class II") { selectedPDI = "PDI Class II" }
                                SelectionChip(title: "PDI Class III", isSelected: selectedPDI == "PDI Class III") { selectedPDI = "PDI Class III" }
                            }
                            SelectionChip(title: "PDI Class IV", isSelected: selectedPDI == "PDI Class IV") { selectedPDI = "PDI Class IV" }
                            
                            HStack(spacing: 12) {
                                SelectionChip(title: "Skeletal Relation I", isSelected: selectedSkeletal == "Relation I") { selectedSkeletal = "Relation I" }
                                SelectionChip(title: "Skeletal Relation II", isSelected: selectedSkeletal == "Relation II") { selectedSkeletal = "Relation II" }
                            }
                            SelectionChip(title: "Skeletal Relation III", isSelected: selectedSkeletal == "Relation III") { selectedSkeletal = "Relation III" }
                        }
                    }
                    
                    // MARK: - Derive Diagnosis
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Derive Diagnosis")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                        
                        SelectionSection(title: "Horizontal Condylar Guidance", options: ["Steep", "Average", "Shallow"], selection: $selectedHorizontalCondylar)
                        SelectionSection(title: "Incisal Guidance", options: ["Steep", "Average", "Shallow"], selection: $selectedIncisal)
                        SelectionSection(title: "Working Side", options: ["Group Function", "Canine Guidance"], selection: $selectedWorkingSide)
                        SelectionSection(title: "Non-Working Side", options: ["Contact", "No Contact"], selection: $selectedNonWorkingSide)
                        SelectionSection(title: "Protrusion", options: ["Anterior", "Posterior", "Edge-to-Edge"], selection: $selectedProtrusion)
                        SelectionSection(title: "Retrusion", options: ["Contact", "No Contact"], selection: $selectedRetrusion)
                        SelectionSection(title: "Right Lateral", options: ["Contact", "No Contact", "Crossbite"], selection: $selectedRightLateralMove)
                        SelectionSection(title: "Left Lateral", options: ["Contact", "No Contact", "Crossbite"], selection: $selectedLeftLateralMove)
                        SelectionSection(title: "Centric Frontal", options: ["Midline", "Right Deviation", "Left Deviation"], selection: $selectedCentricFrontal)
                        SelectionSection(title: "Protrusion Centre", options: ["Midline", "Right Deviation", "Left Deviation"], selection: $selectedProtrusionCentre)
                        SelectionSection(title: "Right Lateral", options: ["Midline", "Right Deviation", "Left Deviation"], selection: $selectedRightLateralCentre)
                        SelectionSection(title: "Left Lateral", options: ["Midline", "Right Deviation", "Left Deviation"], selection: $selectedLeftLateralCentre)
                    }
                    .padding(.bottom, 140) // Space for bottom button
                }
                .padding(16)
            }
            .overlay(
                VStack(spacing: 0) {
                    Spacer()
                    // MARK: - Navigation Button
                    NavigationLink(destination: ExtraoralPhotographyView()) {
                        Text("Save & Continue")
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
                    .padding(.bottom, 40) // Moved down
                    .background(
                        LinearGradient(colors: [.appBackground.opacity(0), .appBackground], startPoint: .top, endPoint: .bottom)
                            .frame(height: 120)
                    )
                },
                alignment: .bottom
            )
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

// MARK: - Selection Chip
private struct SelectionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(isSelected ? .white : .appPrimaryText)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.blue : Color.appCardBackground)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.appBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Selection Section
private struct SelectionSection: View {
    let title: String
    let options: [String]
    @Binding var selection: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.appPrimaryText)
            
            ScrollView(.horizontal, showsIndicators: false) {
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
}
