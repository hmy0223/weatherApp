import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let URL_SAMPLE = "api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}"
    let URL_API_KEY = "89575d3c850c4fe09a01e9aedf6aec9e"
    var URL_CITY_NAME = "London"
    var URL_GET_ONE_CALL = ""
    let URL_BASE = "https://api.openweathermap.org/data/2.5"
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String {
        URL_GET_ONE_CALL = "/weather?q=" + URL_CITY_NAME + "&appid=" + URL_API_KEY
        print(URL_BASE + URL_GET_ONE_CALL)
        return URL_BASE + URL_GET_ONE_CALL
    }
    
    func setCityName(_ cityName: String) {
        URL_CITY_NAME = cityName
    }
    
    func setCityName(_ cityName: Double) {
        setCityName(String(cityName))
    }
    
    func getWeather(onSuccess: @escaping (Current) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: buildURL()) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Current.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
}
