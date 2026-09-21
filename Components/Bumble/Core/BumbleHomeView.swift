import SwiftUI

struct BumbleHomeView: View {
    @State private var options: [String] = ["Everyone", "Trending", "Hello"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        ZStack {
            Color.bumbleBackgroundYellow
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                
                BumbleFilterView(options: options, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
                BumbleCardView()
                Spacer()
            }
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text("bumble")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

#Preview {
    BumbleHomeView()
}
