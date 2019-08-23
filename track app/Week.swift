

import Foundation

enum WeekDay:Int {
    case Sunday=1,Monday=2,Tuesday=3,Wednesday=4,Thursday=5,Friday=6,Saturday=7
}

class Week {
    
    var weekDay = WeekDay.Sunday
    var weekArray = Array(repeating: Array(repeating: "", count: 48), count: 7)
    
    
    

    
    let times = [ "12:00 AM","12:30 AM","1:00 AM","1:30 AM","2:00 AM","2:30 AM","3:00 AM","3:30 AM","4:00 AM","4:30 AM","5:00 AM","5:30 AM","6:00 AM","6:30 AM","7:00 AM","7:30 AM","8:00 AM","8:30 AM","9:00 AM","9:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","1:00 PM","1:30 PM","2:00 PM","2:30 PM","3:00 PM","3:30 PM","4:00 PM","4:30 PM","5:00 PM","5:30 PM","6:00 PM","6:30 PM","7:00 PM","7:30 PM","8:00 PM","8:30 PM","9:00 PM","9:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM"]
    
    func delete(){
        self.weekArray.removeAll()
        defaults.removeObject(forKey: "SavedWeekArray")
        self.weekArray = Array(repeating: Array(repeating: "", count: 48), count: 7)
    }
   
    
    
   

}

