import Foundation

public class Statement {
    public var customerName: String
    private var rentals: [Rental] = []
    private(set) var totalAmount: Double = 0
    private(set) var frequentRenterPoints: Int = 0
    
    public init(customerName: String) {
        self.customerName = customerName
    }
    
    public func add(rental: Rental) {
        rentals.append(rental)
    }
    
    private func resetAmount() {
        totalAmount = 0
        frequentRenterPoints = 0
    }
    
    private var header: String {
        "Rental Record for \(customerName)\n"
    }
    
    private func rentalLine(_ rental: Rental) -> String {
        let rentalAmount = rental.determineAmount()
        frequentRenterPoints += rental.determineFrequentRenterPoints()
        totalAmount += rentalAmount
        
        return formatRentalLine(rental, rentalAmount: rentalAmount)
    }
    
    func formatRentalLine(_ rental: Rental, rentalAmount: Double) -> String {
        "\t\(rental.movie.title)\t\(rentalAmount)\n"
    }
    
    var rentalLines: String {
        var rentalText = ""
        for rental in rentals {
            rentalText += rentalLine(rental)
        }
        
        return rentalText
    }
    
    private var footer: String {
        """
        Amount owed is \(totalAmount)
        You earned \(frequentRenterPoints) frequent renter points\n
        """
    }
    
    public func generate() -> String {
        resetAmount()
        var statementText = header
        statementText += rentalLines
        statementText += footer
        return statementText
    }
}
