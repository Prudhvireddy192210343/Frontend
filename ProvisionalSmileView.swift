import SwiftUI

struct ProvisionalSmileView: View {
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
                    .foregroundColor(.black)
                }
                Spacer()
                Text("Provisional Result")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Color.clear.frame(width: 44)
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1597500085600-0937c0937a09?q=80&w=1000&auto=format&fit=crop")) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding()
                    
                    Text("Provisional Setup")
                        .font(.title2)
                        .bold()
                    
                    Text("This view shows the temporary provisional restorations planned for the interim phase.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}
