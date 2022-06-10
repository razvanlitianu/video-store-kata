import XCTest
@testable import VideoStore

class CustomerTests: XCTestCase {
    private var statement: Statement!
    private var newRelease1: Movie!
    private var newRelease2: Movie!
    private var childrens1: Movie!
    private var childrens2: Movie!
    private var regular1: Movie!
    private var regular2: Movie!
    private var regular3: Movie!
    
    private var delta = 0.001

    public override func setUp() {
        super.setUp()
        statement = Statement(customerName: "Customer Name")
        newRelease1 = NewReleaseMovie(title: "New Release 1")
        newRelease2 = NewReleaseMovie(title: "New Release 2")
        childrens1 = ChildrenMovie(title: "Childrens 1")
        childrens2 = ChildrenMovie(title: "Childrens 2")
        regular1 = RegularMovie(title: "Regular 1")
        regular2 = RegularMovie(title: "Regular 2")
        regular3 = RegularMovie(title: "Regular 3")
    }

    public func testSingleNewReleaseStatementTotals() {
        statement.add(rental: Rental(movie: newRelease1, daysRented: 3))
        _ = statement.generate()
        XCTAssertEqual(9.0, statement.totalAmount, accuracy: delta)
        XCTAssertEqual(2, statement.frequentRenterPoints)
    }

    public func testMultipleNewReleaseStatementTotals() {
        statement.add(rental: Rental(movie: newRelease1, daysRented: 1))
        statement.add(rental: Rental(movie: newRelease2, daysRented: 3))
        _ = statement.generate()
        XCTAssertEqual(12.0, statement.totalAmount, accuracy: delta)
        XCTAssertEqual(3, statement.frequentRenterPoints)
    }

    public func testSingleChildrensStatementTotals() {
        statement.add(rental: Rental(movie: childrens1, daysRented: 3))
        _ = statement.generate()
        XCTAssertEqual(1.5, statement.totalAmount, accuracy: delta)
        XCTAssertEqual(1, statement.frequentRenterPoints)
    }

    public func testMultipleChildrensStatementTotals() {
        statement.add(rental: Rental(movie: childrens1, daysRented: 3))
        statement.add(rental: Rental(movie: childrens2, daysRented: 4))
        _ = statement.generate()
        XCTAssertEqual(4.5, statement.totalAmount, accuracy: delta)
        XCTAssertEqual(2, statement.frequentRenterPoints)
    }
    
    public func testMultipleRegularStatementTotals() {
        statement.add(rental: Rental(movie: regular1, daysRented: 1))
        statement.add(rental: Rental(movie: regular2, daysRented: 2))
        statement.add(rental: Rental(movie: regular3, daysRented: 3))
        _ = statement.generate()
        XCTAssertEqual(7.5, statement.totalAmount, accuracy: delta)
        XCTAssertEqual(3, statement.frequentRenterPoints)
    }

    public func testMultipleRegularStatementFormat() {
        statement.add(rental: Rental(movie: regular1, daysRented: 1))
        statement.add(rental: Rental(movie: regular2, daysRented: 2))
        statement.add(rental: Rental(movie: regular3, daysRented: 3))

        XCTAssertEqual(
            "Rental Record for Customer Name\n" +
                "\tRegular 1\t2.0\n" +
                "\tRegular 2\t2.0\n" +
                "\tRegular 3\t3.5\n" +
                "Amount owed is 7.5\n" +
            "You earned 3 frequent renter points\n",
            statement.generate()
        )
    }
}
