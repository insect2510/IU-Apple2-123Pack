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
                    .foregroundStyle(.tint)
                Text("123Pack")
                    .font(Font.largeTitle.bold())
            }
            
            // trip 1
            
            HStack(spacing: 16) {
                
                // placeholder for image
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                    }
                
                // placeholder information about the trip
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Mein Urlaub")
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
                    .fill(.gray.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                    }
                
                // placeholder information about the trip
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Mein Urlaub")
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
                        .fill(.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
       
                    
                    Text("Trip hinzufügen")
                        .font(.headline)
                    
                    Spacer()
                }
                .padding()
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            .background(.gray.opacity(0.1))
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
        }
        
    }
}

#Preview {
    ContentView()
}
