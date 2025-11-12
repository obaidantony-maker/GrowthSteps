
import SwiftUI

struct StatSection: View {
    let title: String
    let stats: [StatItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 20)
            
            if #available(iOS 16.0, *) {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(stats) { stat in
                            StatItemView(item: stat)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
