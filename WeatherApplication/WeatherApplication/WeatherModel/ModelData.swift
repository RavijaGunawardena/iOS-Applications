import Foundation

class ModelData: ObservableObject {
    
    @Published var forecast: Forecast?
    @Published  var userLocation: String = ""
    @Published  var airPollution: AirModelData?
    
    init() {
        self.forecast = load("london.json")
    }
    

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=3864a49da795d3aa174034e60ca4e6a1")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
    
    //
    func loadAirData() async throws {
        
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("Couldn't find lat and long in forecast data")
        }
        let loc = await getLocFromLatLong(lat: lat, lon: lon)
        DispatchQueue.main.async {
            self.userLocation = loc
        }
        
        print("\(lon)")
        print("\(lat)")
        let url = URL(string:"https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=3864a49da795d3aa174034e60ca4e6a1")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        print(data)
        do {
            
            let pollutionData = try JSONDecoder().decode(AirModelData.self, from: data)
            DispatchQueue.main.async {
                self.airPollution = pollutionData
            }
            //print("data : \(pollutionData.list[0])")
            print("AQI : \(pollutionData.list[0].main.aqi)")
            print("CO : \(pollutionData.list[0].components.co)")
           
        } catch {
            throw error
        }
    }
}
