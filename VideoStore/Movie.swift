import Foundation

public class Movie {
    public private(set) var title:String

    init(title: String) {
        self.title = title
    }
    
    func determineAmount(daysRented: Int) -> Double {
        fatalError("Override in the subclass")
    }
    
    func determineFrequentRenterPoints(daysRented: Int) -> Int {
        fatalError("Override in the subclass")
    }
}

class NewReleaseMovie: Movie {
    
    override func determineAmount(daysRented: Int) -> Double {
        Double(daysRented) * 3
    }
    
    override func determineFrequentRenterPoints(daysRented: Int) -> Int {
        daysRented > 1 ? 2 : 1
    }
}

class ChildrenMovie: Movie {
    
    override func determineAmount(daysRented: Int) -> Double {
        var rentalAmount = 1.5
        if daysRented > 3 {
            rentalAmount += Double(daysRented - 3) * 1.5
        }
        
        return rentalAmount
    }
    
    override func determineFrequentRenterPoints(daysRented: Int) -> Int {
        1
    }
}

class RegularMovie: Movie {
    
    override func determineAmount(daysRented: Int) -> Double {
        var rentalAmount: Double = 2
        if daysRented > 2 {
            rentalAmount += Double(daysRented - 2) * 1.5
        }
        return rentalAmount
    }
    
    override func determineFrequentRenterPoints(daysRented: Int) -> Int {
        1
    }
}
