//
//  HeaderSectionView.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/19/26.
//

import SwiftUI

struct HeaderSectionView: View {
    var body: some View {
       
        VStack(spacing:10){
            Image(systemName: "figure.walk")
                .font(.system(size: 80))
                .foregroundColor(Color.red)
            
            Text("Daily Activity Tracker")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Monitor Health Data")
                .font(.subheadline)
                .foregroundColor(Color.red)
        }
        
        .padding()
    }
}

#Preview {
    HeaderSectionView()
}
