//
//  TableViewCell.swift
//  track app
//
//  Created by James Hunt on 4/11/19.
//  Copyright © 2019 James Hunt. All rights reserved.
//

import UIKit
import CoreData

let pasteboard = UIPasteboard.general
let defaults = UserDefaults.standard

class TableViewCell: UITableViewCell,UITextFieldDelegate {
    
    var currentRow = Int()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // double tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
        
        
        
        
        
        myTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        self.myTextField.delegate = self
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var count = 0
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        textChanged()
        
        
    }
    func textChanged(){
        count+=1
        
        
        let ip = getIndexPath()!
        let indexPath = ip[1]
        
        print("text changed day.weekday is",weekDays.weekDay)
        
        
        
        weekDays.weekArray[weekDays.weekDay-1][indexPath] = myTextField.text!
        

        
        pasteboard.string = myTextField.text!
        
        defaults.set(weekDays.weekArray, forKey: "SavedWeekArray")
        
        print("text has changed")
    
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 35
    }
   
    @objc func tripleTapped() {
        if let string = pasteboard.string {
            myTextField.text = string
            textChanged()
        }
        
    }
    func getCell() -> UITableViewCell{
        return self
    }
    
    

    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
    var newDay = 0
    
    
}

extension UITableViewCell {
    var tableView: UITableView? {
        var view = self.superview
        while (view != nil && view!.isKind(of: UITableView.self) == false) {
            view = view!.superview
        }
        return view as? UITableView
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
