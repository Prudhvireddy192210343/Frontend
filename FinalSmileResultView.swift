import SwiftUI

struct FinalSmileResultView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { dismiss() } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                        Text("Back")
                    }
                    .foregroundColor(.appPrimaryText)
                }
                Spacer()
                Text("Final Result")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                Spacer()
                Color.clear.frame(width: 44)
            }
            .padding()
            .background(Color.appCardBackground)
            
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1549480017-d76466a4b7e8?q=80&w=1000&auto=format&fit=crop")) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding()
                    
                    Text("Final Aesthetic Result")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.appPrimaryText)
                    
                    Text("This view demonstrates the expected high-quality final aesthetic outcome after permanent restoration.")
                        .foregroundColor(.appSecondaryText)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        FinalSmileResultView()
    }
}
