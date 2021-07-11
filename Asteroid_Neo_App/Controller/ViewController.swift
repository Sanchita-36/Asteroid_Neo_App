//
//  ViewController.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 07/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class ViewController: UIViewController, callNeoAPIProtocol  {
    
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    
    @IBOutlet weak var speedIDLbl: UILabel!
    @IBOutlet weak var speedSpeedTLbl: UILabel!
    @IBOutlet weak var distanceIDLbl: UILabel!
    @IBOutlet weak var distanceDistanceLbl: UILabel!
    @IBOutlet weak var averageAsteroidSize: UILabel!
    @IBOutlet weak var showChartsBtn: UIButton!
    
    let datepicker = UIDatePicker()
    var startDateString = String()
    var endDateString = String()
    var dateDay: Int = 0
    var dateMonth: Int = 0
    var dateYear: Int = 0
    var requiredStartDateString = String()
    var requiredEndDateString = String()
    var arrayAsteroidCount: [Int] = []
    var arrayDate: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //datePicker view for startDate
        let dateToolBar_StartDate = UIToolbar()
        dateToolBar_StartDate.sizeToFit()
        let dateDoneBtn_StartDate = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                    action: #selector(dateDone_StartDate))
        dateToolBar_StartDate.items = [dateDoneBtn_StartDate]
        startDateTF.inputAccessoryView = dateToolBar_StartDate
        startDateTF.inputView = datepicker
        datepicker.datePickerMode = .date
        
        //datePicker view for endDate
        let dateToolBar_EndDate = UIToolbar()
        dateToolBar_EndDate.sizeToFit()
        let dateDoneBtn_EndDate = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                  action: #selector(dateDone_EndDate))
        dateToolBar_EndDate.items = [dateDoneBtn_EndDate]
        endDateTF.inputAccessoryView = dateToolBar_EndDate
        endDateTF.inputView = datepicker
        datepicker.datePickerMode = .date
        
        showChartsBtn.isEnabled = false
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        let validation = validateInputs()
        if validation == true {
            NeoService.neoInstance.fetchNeoAPI(startDate: requiredStartDateString, endDate: requiredEndDateString, api_key: "jlIZzCjlIIx0GAihWQftRrJi1Llm9shMSNOJaFTO")
            NeoService.neoInstance.delegateNeo = self
            showChartsBtn.isEnabled = true
            UserDefaults.standard.set(true, forKey: "dataSubmitted")
        }
    }
    
    //done button for startdate picker
    @objc func dateDone_StartDate() {
        if let datePicker = self.startDateTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .short
            self.startDateTF.text = dateformatter.string(from: datePicker.date)
            self.startDateString = self.startDateTF.text!
            let date = datePicker.date
            let endDate = Calendar.current.dateComponents([.day,.month,.year], from: date)
            self.dateDay = endDate.day!
            self.dateMonth = endDate.month!
            self.dateYear = endDate.year!
            self.requiredStartDateString = ("\(dateYear)-\(dateMonth)-\(dateDay)")
        }
        self.startDateTF.resignFirstResponder()
    }
    
    //done button for enddate picker
    @objc func dateDone_EndDate() {
        if let datePicker = self.endDateTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .short
            self.endDateTF.text = dateformatter.string(from: datePicker.date)
            self.endDateString = self.endDateTF.text!
            let date = datePicker.date
            let endDate = Calendar.current.dateComponents([.day,.month,.year], from: date)
            self.dateDay = endDate.day!
            self.dateMonth = endDate.month!
            self.dateYear = endDate.year!
            self.requiredEndDateString = ("\(dateYear)-\(dateMonth)-\(dateDay)")
        }
        self.endDateTF.resignFirstResponder()
    }
    
    func validateInputs() -> Bool {
        var isValid = true
        
        if (startDateTF.text?.isEmpty)!{
            showAlert(title: "Alert", message: "Please select start date")
            isValid = false
        }
        
        if (endDateTF.text?.isEmpty)!{
            showAlert(title: "Alert", message: "Please select end date")
            isValid = false
        }
        return isValid
    }
    
    func fetchNeoDetails(fastestSpeed: String, closestDistance: String, fastestSpeedAsteroidID: String, closestDistanceAsteroidID: String, avgAsteroidSize: Double, dateArray: [String], asteroidCountArray: [Int]) {
        speedIDLbl.text = fastestSpeedAsteroidID
        speedSpeedTLbl.text = fastestSpeed
        distanceIDLbl.text = closestDistanceAsteroidID
        distanceDistanceLbl.text = closestDistance
        averageAsteroidSize.text = String(avgAsteroidSize)
        self.arrayAsteroidCount = asteroidCountArray
        self.arrayDate = dateArray
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showChart(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "dataSubmitted") == true {
           
            let ShowChartVC = self.storyboard?.instantiateViewController(identifier: "ShowChartViewController") as! ShowChartViewController
            ShowChartVC.asteroidCountArray_ShowCharts = self.arrayAsteroidCount
            ShowChartVC.dateArray_ShowCharts = self.arrayDate
            self.navigationController?.pushViewController(ShowChartVC, animated: true)
        }else {
            showAlert(title: "Try Again!", message: "Please Sumbit the data first.")
        }
    }
}

