//
//  ContentView.swift
//  123Bagy
//
//  Created by Oliver Hartmann on 03.09.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            // Logo + Title
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Colors.titlecolor)
                Text("123Pack")
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(Colors.titlecolor)
            }
            
            // trip 1
            
            HStack(spacing: 16) {
                
                // placeholder for image
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Colors.boxcolor.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(Colors.primarycolor)
                    }
                
                // placeholder information about the trip
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Mein Urlaub 1")
                        .font(.title2.bold())
                    
                    HStack {
                        Image(systemName: "calendar")
                        
                        Text("10.09.2026 – 20.09.2026")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "suitcase")
                        
                        Text("Packliste vorhanden")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(.background)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .shadow(radius: 2)
            
            // trip 2
            
            HStack(spacing: 16) {
                
                // placeholder for image
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Colors.boxcolor.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(Colors.primarycolor)
                    }
                
                // placeholder information about the trip
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Mein Urlaub 2")
                        .font(.title2.bold())
                    
                    HStack {
                        Image(systemName: "calendar")
                        
                        Text("10.09.2026 – 20.09.2026")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "suitcase")
                        
                        Text("Packliste vorhanden")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(.background)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .shadow(radius: 2)
            
            // add new trip
            
            Button {
                
                // button to add a new trip
                
            } label: {
                HStack {
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Colors.boxcolor.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .font(.largeTitle)
                                .foregroundStyle(Colors.boxcolor)
                        }
       
                    
                    Text("Trip hinzufügen")
                        .font(.headline)
                        .foregroundStyle(Colors.primarycolor)
                    
                    Spacer()
                }
                .padding()
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
        }
        
    }
}

#Preview {
    ContentView()
}
