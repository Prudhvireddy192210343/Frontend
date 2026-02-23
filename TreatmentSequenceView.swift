import SwiftUI

struct TreatmentSequenceView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    
    let sequences = [
        TreatmentPhase(title: "Disease Control", status: "Required", isLocked: true),
        TreatmentPhase(title: "Occlusal Stabilization", status: "Required", isLocked: true),
        TreatmentPhase(title: "Diagnostic Phase", status: "Required", isLocked: true),
        TreatmentPhase(title: "Provisional Phase", status: "Required", isLocked: true),
        TreatmentPhase(title: "Definitive Rehabilitation", status: "Required", isLocked: true)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        .frame(width: 44, height: 44, alignment: .leading)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Treatment Sequence")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<sequences.count, id: \.self) { index in
                        HStack(alignment: .top, spacing: 16) {
                            // Timeline Icon & Line
                            VStack(spacing: 0) {
                                Image(systemName: "lock")
                                    .font(.system(size: 22, weight: .regular))
                                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                                    .frame(width: 44, height: 44)
                                
                                if index < sequences.count - 1 {
                                    Rectangle()
                                        .fill(Color(red: 231/255, green: 235/255, blue: 243/255))
                                        .frame(width: 2, height: 30)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(sequences[index].title)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                                
                                Text(sequences[index].status)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color(red: 102/255, green: 130/255, blue: 180/255))
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.vertical, 40)
            }
            
            Spacer()
            
            // MARK: - Next Button
            NavigationLink(destination: ConstraintBasedPlanningView(caseItem: caseItem)) {
                Text("Next")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                    )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            

        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

struct TreatmentPhase {
    let title: String
    let status: String
    let isLocked: Bool
}

private struct TabItem: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: isSelected ? .bold : .regular))
                .foregroundColor(isSelected 
                                 ? Color(red: 37/255, green: 99/255, blue: 235/255) 
                                 : Color(red: 76/255, green: 102/255, blue: 154/255))

            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected 
                                 ? Color(red: 37/255, green: 99/255, blue: 235/255) 
                                 : Color(red: 76/255, green: 102/255, blue: 154/255))
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    TreatmentSequenceView(caseItem: Case.sampleCases[0])
}
