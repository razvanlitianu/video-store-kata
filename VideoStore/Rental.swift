import Foundation

public class Rental {
    public private(set) var movie: Movie
    public var daysRented: Int
    
    public init(movie: Movie, daysRented: Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    func determineAmount() -> Double {
        movie.determineAmount(daysRented: daysRented)
    }
    
    func determineFrequentRenterPoints() -> Int {
        movie.determineFrequentRenterPoints(daysRented: daysRented)
    }
}
