//
//  FetchWeatherJSON.swift
//  A2_Dhruvilkumar_Patel
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import Foundation

/// Fetch's data from open weather map
class FetchWeatherJSON {
    
    /// method which will fetch data by using JSON Decoder
    /// - Parameters:
    ///   - url: API url of custom weather by city name
    ///   - completion: completion handler which return WeatherResponse if there isn't ant error
    func getData(from url: String, completion: @escaping(WeatherResponse) -> Void){
        
        var result: WeatherResponse?
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                
                guard let data = data, error == nil else{
                    print("\(String(describing: error?.localizedDescription))")
                    return
                }
                do{
                    result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                }
                catch{
                    print("Error \(error.localizedDescription)")
                }
                
                guard let json = result else{ return }
                
                completion(json)

            }
            task.resume()
        }
        
    }
}
