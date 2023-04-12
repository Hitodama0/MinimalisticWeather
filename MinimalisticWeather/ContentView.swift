//
//  ContentView.swift
//  MinimalisticWeather
//
//  Created by Biagio Ricci on 12/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var search = ""
    @State private var cities = [Search]()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cities, id: \.lat) { city in
                        NavigationLink {
                            WeatherView(lat: city.lat, lon: city.lon)
                        } label: {
                            Text(city.name)
                            Text(city.country)
                        }
                    }
                }
            }
            .searchable(text: $search)
            .onChange(of: search) { newValue in
                searchFunc()
            }
            .navigationTitle("Search for a city")
        }
    }
    
    func searchFunc() {
        let apiKey = ""
        
        guard let url = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(search)&limit=5&appid=\(apiKey)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "No")
                return
            }
            do {
                let cities = try JSONDecoder().decode([Search].self, from: data)
                DispatchQueue.main.async {
                    self.cities = cities
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
