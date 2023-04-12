//
//  WeatherView.swift
//  MinimalisticWeather
//
//  Created by Biagio Ricci on 12/04/23.
//

import SwiftUI

struct WeatherView: View {
    @State private var weather: WeatherData?
    let lat: Double
    let lon: Double
    var body: some View {
        VStack {
            if let weather = weather {
                Text("\(weather.name)")
                    .font(.title2)
                
                Text("\(Int(weather.main.temp - 273.15))°C")
                    .font(.system(size: 50))
                
                Text("\(weather.weather[0].main): \(weather.weather[0].description)")
                    .font(.headline)
                Text("Feels like: \(Int(weather.main.feels_like - 273.15))°C")
                Text("Humidity: \(weather.main.humidity)%")
                    .font(.subheadline)
            } else {
                Text("Loading weather data...")
            }
        }
        .onAppear {
            fetchWeatherData()
        }
    }
    
    func fetchWeatherData() {
        let apiKey = ""
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weather = weatherData
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

/*struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}*/
