//
//  ActivityStatusCard.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/19/26.
//

import SwiftUI


struct ActivityStatusCard: View {
    
    let activityStatus: String
    let authStatus: String
    let isAuthorized: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "heart.circle.fill")
                    .font(.title2)
                    .foregroundColor(Color.red)
                
                
                Text("Activity Status")
                    .font(.headline)
                Spacer()
                
                
                
                    
            }
            
            HStack {
                Text("Status")
                    .font(.body)
                    .foregroundColor(Color.gray)
                
                
                Text(activityStatus)
                    .font(.body)
                    .foregroundColor(Color.primary)
            }
            
            HStack {
                Text("Authorization Status")
                    .font(.body)
                    .foregroundColor(Color.gray)
                
                
                Text(authStatus)
                    .font(.body)
                    .foregroundColor(isAuthorized ? Color.green : Color.orange)
            }
            
        }
        
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

#Preview {
  VStack {
        ActivityStatusCard(activityStatus: "Active", authStatus: "Authorized", isAuthorized: true)
        ActivityStatusCard(activityStatus: "Sendentary", authStatus: "Not Registered", isAuthorized: false)
  }.padding()
    
}
