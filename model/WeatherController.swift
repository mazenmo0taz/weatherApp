import Foundation
protocol weatherManagerDelegate {
    func didUpdateWeather(weather:WeatherModel )
}
struct WeatherController {
    var delegate : weatherManagerDelegate?
    let actualUrl: String = "https://api.openweathermap.org/data/2.5/weather?&appid=033d192083797e7e8768f7d813274869&q="
    func realUrl(cityName: String){
        let completeUrl : String = "\(actualUrl)\(cityName)"
        performRequest(url: completeUrl)
    }
    
    func performRequest(url : String) {
        if let creatingUrl = URL(string: url){
            
            let creatingSession = URLSession(configuration: .default)
            
            let task = creatingSession.dataTask(with: creatingUrl,completionHandler:  completionHandle(data: response :error: ))
            
            task.resume()
        }
    }
    func completionHandle(data:Data?, response:URLResponse?, error: Error?) {
        if let errorr = error{
            print(errorr)
        }
        if let safeData = data {
            if let weather = translateJson(apidata: safeData){
                self.delegate?.didUpdateWeather(weather: weather)
                
                
            }
        }
    }
    func translateJson(apidata: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: apidata)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherModel = WeatherModel(id: id, name: name, temp: temp)
            return weatherModel
        } catch{
            print(error)
            return nil
        }
    }
    
    
    
}
