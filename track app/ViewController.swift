//
//  ViewController.swift
//  track app
//
//  Created by James Hunt on 4/10/19.
//  Copyright © 2019 James Hunt. All rights reserved.
//

import UIKit


var weekDays = Week()
var scrollNum = Int()



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    let dv = Draw()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func WeekView(_ sender: UIButton) {
        /* implement later*/
    }
    
    var timer: Timer?
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "E, d MMM"
        return tmpFormatter
    }()
    let tfformatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "HH"
        return tmpFormatter
    }()
    let minFormatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "mm"
        return tmpFormatter
    }()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
       //let customFont = UIFont(name: "SFProDisplay-Regular", size: 12)
       // timeLabel.font = customFont
       //label.adjustsFontForContentSizeCategory = true
       //timeLabel.font = UIFont(name: "SFProDisplay-Regular", size: 9)
       // retrieve user defaults
        
        
    
        weekDays.weekDay = getCurrentDay()
        
        if let savedArray = defaults.array(forKey: "SavedWeekArray") as? [[String]] {
            weekDays.weekArray = savedArray
            myTableView.reloadData()
            myTableView.reloadInputViews()
        }
        
        
        
        
        
    
        
        
       self.picker.selectRow(getCurrentDay()-1, inComponent: 0, animated: false)
        //timer
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.getTimeOfDate), userInfo: nil, repeats: true)
        //rise keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
         myTableView.keyboardDismissMode = .onDrag
        // swipe
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(WeekViewController.handleSwipe(gesture:)))
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
        

        
        
        
        
        
        
        
        
        
       
       
        // return keyboard
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        
        
        
        
        
        getTimeOfDate()
    
        
        
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let minNum = Int(minutes)
        let hour = getTFHour()
        
        print("hour is",hour)
        print("minnum1",minNum)
        scrollNum = hour
    
        scrollNum = (scrollNum * 2)+1
       
        if(minNum>30){scrollNum+=1}
        
//        switch scrollNum {
//        case let x where x<=9:
//            scrollNum = scrollNum + 39
//        case let x where x>9:
//            scrollNum = scrollNum - 9
//        default:
//            scrollNum = 0
//            
//        }
        

        scrollTo(animated: true, hour: scrollNum)
        
        
    } //rise keyboard
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func getTimeOfDate() {
        
        
        //timeLabel.text = formatter.string(from: curDate)
        
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
        
        
        
    }

    func getTFHour()->Int{
        let hour = Calendar.current.component(.hour, from: Date())
        
        return hour
    
    }
   
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            myTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height+34, right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            myTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //gesture
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {

        case UISwipeGestureRecognizer.Direction.left:
            
            self.view.endEditing(true)
            performSegue(withIdentifier: "forward", sender: nil)
            
            
            
        default:
            print("error")
            
        }
    }
    
    func scrollTo(animated: Bool,hour:Int) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            let numberOfSections = self.myTableView.numberOfSections
            let numberOfRows = hour
            
            
            let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
            
    
            
            self.myTableView.scrollToRow(at: indexPath, at: .top, animated: animated)
            
        }
        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! TableViewCell

        cell.timeLabel.text = weekDays.times[indexPath.row]
        
        cell.myTextField.text = weekDays.weekArray[weekDays.weekDay-1][indexPath.row]
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48
    }
    
    
    @IBAction func addNewDay(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Start New Week?", message: "Choose to start a new week and remove data from the previous one", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Go Back", style: .destructive, handler: { action in
            
            self.scrollTo(animated: true, hour: scrollNum)
            
        }))
        alert.addAction(UIAlertAction(title: "Add New Week", style: .default, handler: { action in
            self.addNewWeek()
        }))
        
        self.present(alert, animated: true)
        
        // Delay the dismissal by 5 seconds
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
   
    func addNewWeek(){
        let alert = UIAlertController(title: "Delete Week?", message: "It's recommended you export data and start a new week Saturday night before deleting", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            
            
            weekDays.delete()
            self.myTableView.reloadData()
            self.scrollTo(animated: true, hour: scrollNum)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            
        }))
        
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
   // pickerv
    var daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .white
        label.textAlignment = .center
       
        label.font = UIFont(name: "SF Mono", size: 18)
        
        
        
        // where data is an Array of String
        label.text = daysOfWeek[row]
        
        return label
    }

    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfWeek.count
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        weekDays.weekDay = row+1
    
        
        

        scrollTo(animated: true, hour: scrollNum)
        myTableView.reloadData()
        myTableView.reloadInputViews()
        
    }
    func getCurrentDay() -> Int{
        
        let today = Date().dayNumberOfWeek()!
        
        return today
        
    }
    
}

class Draw:UIView {

    var path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
    

}



