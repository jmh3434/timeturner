//
//  ViewController.swift
//  track app
//
//  Created by James Hunt on 4/10/19.
//  Copyright © 2019 James Hunt. All rights reserved.
//

import UIKit



class WeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var weekTableView: UITableView!
    
    
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    var monthDay = Array(repeating: "", count: 15)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let calendar = Calendar.current
        var tenDaysfromNow: Date {
            return (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])!
        }
        
        print("start of week ",Date().startOfWeek)
        
        //
        //var date = Date().startOfWeek
        var date = yesterday()// first date
        
        let endDate = tenDaysfromNow // last date
        
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "EE dd"
        
        var count = 0
        while date <= endDate {
            print("all",fmt.string(from: date))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
            monthDay[count] = fmt.string(from: date)+":  "
            count+=1
        }
        
        
        

        
        
        navItem.rightBarButtonItem = rightBarButton
        
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(WeekViewController.handleSwipe(gesture:)))
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
        
        

        
        if let savedArray = defaults.array(forKey: "SavedWeekArray") as? [[String]] {
            weekDays.weekArray = savedArray
        }
        
        
        let date2 = Date()
        let calendar2 = Calendar.current
        
        let minutes = calendar2.component(.minute, from: date2)
        let minNum = Int(minutes)
        let hour = getTFHour()
        print("minnum",minNum)
        print("hour2",hour)
        
        var scrollNum = hour
        
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
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func yesterday() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day) // -1 day
        
        let now = Date().startOfWeek
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) // Add the DateComponents
        
        return yesterday!
    }
    func getTFHour()->Int{
        let hour = Calendar.current.component(.hour, from: Date())
        
        return hour
        
    }
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
            
        case UISwipeGestureRecognizer.Direction.right:
            
            performSegue(withIdentifier: "back", sender: nil)
        
        default:
            print("error")
            
        }
    }
    func scrollTo(animated: Bool,hour:Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.weekTableView.numberOfSections
            let numberOfRows = hour
            
            
            let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
            
            self.weekTableView.scrollToRow(at: indexPath, at: .top, animated: animated)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var newStatus = ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! TBCellWeek
       
        cell.timeLabel.text = " \(weekDays.times[indexPath.row])"
        
    
        
        
        
        
        
        
        let sunday = weekDays.weekArray[0][indexPath.row]
        newStatus += monthDay[0]+sunday+"\n"
        let monday = weekDays.weekArray[1][indexPath.row]
            newStatus += monthDay[1]+monday+"\n"
        
        let tuesday = weekDays.weekArray[2][indexPath.row]
            newStatus += monthDay[2]+tuesday+"\n"
        
        let wednesday = weekDays.weekArray[3][indexPath.row]
            newStatus += monthDay[3]+wednesday+"\n"
        
        let thursday = weekDays.weekArray[4][indexPath.row]
            newStatus += monthDay[4]+thursday+"\n"
        
        let friday = weekDays.weekArray[5][indexPath.row]
            newStatus += monthDay[5]+friday+"\n"
        
        let saturday = weekDays.weekArray[6][indexPath.row]
            newStatus += monthDay[6]+saturday
        
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        var range = (newStatus as NSString).range(of: monthDay[weekday-1])
        
        var attributedString = NSMutableAttributedString(string:newStatus)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        
        
        //
     
        
        
        
        //
        
        //cell.statusLabels.text = newStatus
        
        
       
        cell.statusLabels.attributedText = attributedString
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48 // your number of cell here
    }
    
    
    
    @IBAction func valueChanged(_ sender: Any) {
        
        
        
    }
    
    
    
    

    
    
    @IBAction func rightButtonTapped(_ sender: UIBarButtonItem) {
        
        //create csv
        let weeksToExport = weekDays.weekArray
        
        let fileName = "Tasks.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
        
        var csvText = "Time Turner\n,Sun,Mon,Tue,Wed,Thu,Fri,Sat\n"
        
        
        // csvText.append(newLine)
        // [["","",""],["","",""]]
        
        
       
        var statuses = [String]()
        
        
        
    
        for weeki in weeksToExport {
            
            
            
            for status in weeki {
            
                statuses.append(status)
                
            
            }
            
            
            
            
        }
        
        for index in 0...47 {
            csvText.append("\(weekDays.times[index]),\(weekDays.weekArray[0][index]),\(weekDays.weekArray[1][index]),\(weekDays.weekArray[2][index]),\(weekDays.weekArray[3][index]),\(weekDays.weekArray[4][index]),\(weekDays.weekArray[5][index]),\(weekDays.weekArray[6][index])\n")
            
            
        }
        
        
        
        do {
            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        
        

        let textShare = [ path ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
        
    }
    
    
   
   
    
    

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.50,
                       delay: 0.1,
                       options: .curveLinear,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}
class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.50,
                       delay: 0.1,
                       options: .curveLinear,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}


extension Date {
    var startOfWeek: Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    var endOfWeek: Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }
}

class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
