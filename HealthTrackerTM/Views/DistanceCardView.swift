//
//  DistanceCardView.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/19/26.
//

import SwiftUI

struct DistanceCardView: View {
    
    let distance: Double
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15){
            HStack{
                Image(systemName: "map.circle.fill")
                    .font(.system(size: 33))
                    .foregroundColor(.red)
                
                
                Text("Distance")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline){
                Text(String(format: "%.2f", distance))
                    .font(.title3)
                    .foregroundColor(Color.primary)
                
                Text("km")
                    .font(.title3)
                    .foregroundColor(Color.primary)
                
            }
            
        }
        
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}


#Preview {
    DistanceCardView(distance: 20.0178)
        .padding()
}
