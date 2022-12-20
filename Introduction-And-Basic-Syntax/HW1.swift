/*
Task 1
    Write function for calculation of surface of triangle based on side and the height to this side. The inputed parameters must be from type Float. 
    Provide example use of your function and print the result of the surface.
Task 2
    Write function for calculation of surface and perimeter of a circle based on the radius. The inputed parameters must be from type Float. 
    Provide example use of your function and print the result of the surface.
Task 3
    Create a structure Car with parameters : Make(String), Model(String), Horse Power(Double), Torque(Float), Date Of Manufacturing (String). 
    	1. Make a function that accepts Car as parameter and print all the information as coma separated value (CSV) String.
    	2. Make a function that accepts Car as parameter and prints the Power of the car in Watts (not in hps)
*/
import Foundation

func calcTriangleArea(side: Float, height: Float) -> Float {
    let area: Float = (side * height) / 2
    return area
}

let side: Float = 3
let height: Float = 5
let area = calcTriangleArea(side: side, height: height)

print("The surface of a triangle with side:", side, "and height:", height, "is:", area)

//_____________________________________________________________________________________

func calcCircleAreaAndPerimeter(r: Float) {
    let area: Double = Double.pi * pow(Double(r), 2)
    let perimeter: Double = 2 * Double.pi * Double(r)

    print("A circle with radius \(r) has area: \(area) and perimeter: \(perimeter)")
}

calcCircleAreaAndPerimeter(r: 5)

//_____________________________________________________________________________________

struct Car {
    let make: String
    let model: String
    let horsePower: Double
    let torque: Float
    let dateOfManufacturing: String

    func display() {
        print(self.make, self.model, self.horsePower, self.torque, self.dateOfManufacturing, separator: ",")
    }

    func watts() {
        print(self.horsePower * 746)
    }
}

let car1 = Car(make: "Opel", model: "Civic", horsePower: 102, torque: 110.0, dateOfManufacturing: "25/12/2003")
let car2 = Car(make: "Audi", model: "Astra", horsePower: 99,  torque: 121.5, dateOfManufacturing: "2005")
let car3 = Car(make: "BMW",  model: "Focus", horsePower: 184, torque: 198.5, dateOfManufacturing: "2001")

car1.display()
car3.watts()
