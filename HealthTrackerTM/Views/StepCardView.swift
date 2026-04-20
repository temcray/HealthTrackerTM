//
//  StepCardView.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/14/26.
//

import SwiftUI

struct StepCardView: View {
    
    let goal: Int = 10000
       let steps: Int
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15){
                   HStack{
                       Image(systemName: "figure.walk.circle.fill")
                           .font(.title2)
                           .foregroundColor(Color.red)
                       
                       Text("Steps Today").font(.headline)
                       
                       Spacer()
                       
                    }
                   HStack(alignment: .firstTextBaseline){
                       Text("\(steps)")
                           .font(.system(size: 48,weight: .bold))
                           .foregroundColor(Color.primary)
                       
                       Text("steps").font(.title3)
                           .foregroundColor(.gray)
                           
                   }
                   
                   ProgressView(value: Double(steps), total:Double(goal))
                       .tint(.red)
                   
                   Text("Goal \(goal.formatted()) steps")
                       .font(.caption)
                       .foregroundColor(Color(.gray))
               }
               .padding()
               .background(Color(.systemGray6))
               .cornerRadius(15)
           }
       }


#Preview {
StepCardView(steps: 1551)
.padding()
}
        



