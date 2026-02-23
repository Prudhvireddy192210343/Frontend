import SwiftUI

struct ConstraintBasedPlanningView: View {
    @Environment(\.dismiss) var dismiss
    let caseItem: Case
    @State private var phasedToggled = false
    @State private var stagedToggled = false
    
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
                
                Text("Constraint-Based Planning")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // MARK: - Budget Constraint
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Adjusted Budget")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                            
                            Spacer()
                            
                            Text("$10,000")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        }
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(red: 231/255, green: 235/255, blue: 243/255))
                                    .frame(height: 4)
                                
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                                    .frame(width: geo.size.width * 0.4, height: 4)
                            }
                        }
                        .frame(height: 4)
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Timeline Constraint
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Estimated Timeline")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                            
                            Spacer()
                            
                            Text("12 months")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                        }
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(red: 231/255, green: 235/255, blue: 243/255))
                                    .frame(height: 4)
                                
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                                    .frame(width: geo.size.width * 0.4, height: 4)
                            }
                        }
                        .frame(height: 4)
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Approach Cards
                    VStack(spacing: 24) {
                        ApproachCard(
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Teeth_frontal_view.jpg/800px-Teeth_frontal_view.jpg",
                            title: "Phased Rehabilitation",
                            subtitle: phasedToggled ? "Option selected: Comprehensive phased care plan activated." : "Manage biological risk and financial constraints",
                            isToggled: $phasedToggled
                        )
                        
                        ApproachCard(
                            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Human_teeth_-_side_view.jpg/800px-Human_teeth_-_side_view.jpg",
                            title: "Staged Approach",
                            subtitle: stagedToggled ? "Option selected: Focused staged sequence selected." : "Prioritize immediate needs and defer non-essential treatments",
                            isToggled: $stagedToggled
                        )
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
            }
            
            Spacer()
            
            // MARK: - Next Button
            NavigationLink(destination: TreatmentPlanActionsView(caseItem: caseItem)) {
                Text("Next")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 37/255, green: 99/255, blue: 235/255))
                    )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .background(Color(red: 248/255, green: 249/255, blue: 252/255))
        .navigationBarHidden(true)
    }
}

private struct ApproachCard: View {
    let imageURL: String
    let title: String
    let subtitle: String
    @Binding var isToggled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
                    .overlay(ProgressView())
            }
            .frame(height: 220)
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isToggled ? Color(red: 37/255, green: 99/255, blue: 235/255) : Color.clear, lineWidth: 3)
            )
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 13/255, green: 18/255, blue: 27/255))
                    
                    Text(subtitle)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(isToggled ? Color(red: 37/255, green: 99/255, blue: 235/255) : Color(red: 76/255, green: 102/255, blue: 154/255))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                Button {
                    isToggled.toggle()
                } label: {
                    Text(isToggled ? "Selected" : "Toggle")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(isToggled ? Color.green : Color(red: 37/255, green: 99/255, blue: 235/255))
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    ConstraintBasedPlanningView(caseItem: Case.sampleCases[0])
}
