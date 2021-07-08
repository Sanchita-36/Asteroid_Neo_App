//
//  ViewController.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 07/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    
    let datepicker = UIDatePicker()
    var startDateString = String()
    var endDateString = String()
    var dateDay: Int = 0
    var dateMonth: Int = 0
    var dateYear: Int = 0
    var requiredStartDateString = String()
    var requiredEndDateString = String()
    
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
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        NeoService.neoInstance.fetchNeoAPI(startDate: requiredStartDateString, endDate: requiredEndDateString, api_key: "jlIZzCjlIIx0GAihWQftRrJi1Llm9shMSNOJaFTO")
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
    
    
}

