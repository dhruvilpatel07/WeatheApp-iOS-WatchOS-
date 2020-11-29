//
//  InterfaceController.swift
//  A2_Dhruvilkumar_Patel WatchKit Extension
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {


    @IBOutlet weak var lbl_city_name: WKInterfaceLabel!
    @IBOutlet weak var imgView_weather_status: WKInterfaceImage!
    @IBOutlet weak var lbl_city_temp: WKInterfaceLabel!
    
    var session: WCSession?
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let city = message["city_name"] as! String
        let temp = message["temp"] as! Double
        let img_name = message["weather_img"] as! String
        
        lbl_city_name.setText(city)
        lbl_city_temp.setText(String(format: "%.0f°", temp))
        imgView_weather_status.setImage(UIImage(systemName: img_name))
    }
    

}
