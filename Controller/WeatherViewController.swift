import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherStateImg: UIImageView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var wC = WeatherController()
    
    override func viewDidLoad() {
        
        wC.delegate = self
        super.viewDidLoad()
        searchTxtField.delegate = self
        
    }
    
}
//MARK: -
extension WeatherViewController : UITextFieldDelegate{
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        searchTxtField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTxtField.text{
            wC.realUrl(cityName: city)
        }
        searchTxtField.text = ""
        
        
    }
}
//MARK: -
extension WeatherViewController : weatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel){
        
        print(weather.temp - 279.1)
        print(weather.name)
        print(weather.weatherCondition)
        print(weather.id)
        print(weather)
        DispatchQueue.main.async {
            self.temperatureLabel?.text = String(format:"%.1f" ,(weather.temp - 273.15))
            self.cityLabel.text = weather.name
            self.weatherStateImg?.image = UIImage(systemName: weather.weatherCondition)
            
        }
        
        
    }
}
