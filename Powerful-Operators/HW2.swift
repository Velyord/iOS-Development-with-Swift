import Foundation
func calcAvgFuelConsum(
    litersUsed: Double, 
    kmTravelled: Double
) -> Double {
    let avgFuelConsum: Double = 
        (litersUsed * 100) / kmTravelled
    return avgFuelConsum
}
let avgFuelConsum: Double = 
    calcAvgFuelConsum(
        litersUsed: 8.094, 
        kmTravelled: 213
    )
print(
    "Първа задача: \n",
    "Въведени литри:", 8.094, "\n",
    "Въведени км:", 213, "\n",
    "Литри на 100 км:", avgFuelConsum, "\n",
    "______________________________________________________"
)
// ________________________________________________________
var addedFuel: [(Double, Double, String)] = [(0,0,"")] // наложи се да го инициализирам, за да го ползвам
func addFuel(
    distance: Double,
    amountOfFuel: Double,
    dateOfFueling: String
) {
    addedFuel.append((distance, amountOfFuel, dateOfFueling))
}
addFuel(
    distance: 280, 
    amountOfFuel: 22.68, 
    dateOfFueling: "03-12-22"
)
addFuel(
    distance: 323, 
    amountOfFuel: 24.25, 
    dateOfFueling: "05-12-22"
)
addFuel(
    distance: 181, 
    amountOfFuel: 14.48, 
    dateOfFueling: "07-12-22"
)
addedFuel.removeFirst() // търкам стартовата инициализация
let finalTimeAddedFuel = addedFuel.count - 1
func calcFuelConsumBetweenCurrentAndLastFueling(
    _ addedFuel: [(Double, Double, String)]
) -> Double {
    let avgFuelConsumCurrent: Double = 
        calcAvgFuelConsum(
            litersUsed:
                addedFuel[finalTimeAddedFuel].1, // index of Amount of Fuel
            kmTravelled:
                addedFuel[finalTimeAddedFuel].0  // index of Distance
        )
    let avgFuelConsumLast: Double =
        calcAvgFuelConsum(
            litersUsed:
                addedFuel[finalTimeAddedFuel-1].1, // index of Amount of Fuel
            kmTravelled:
                addedFuel[finalTimeAddedFuel-1].0  // index of Distance
        )
    let avgFuelConsumBetweenCurrentAndLastFueling: Double =
        (avgFuelConsumCurrent + avgFuelConsumLast) / 2
    return avgFuelConsumBetweenCurrentAndLastFueling
}
let avgFuelConsumBetweenCurrentAndLastFueling =
    calcFuelConsumBetweenCurrentAndLastFueling(addedFuel)
let resultFormatted: Double = 
    (avgFuelConsumBetweenCurrentAndLastFueling * 100)
    .rounded() / 100 // До втория знак, защото %.2f не работи
print(
    "Втора задача: \n",
    "Три входа (км, литри, дата): \n", 
    addedFuel, "\n",
    "Средно л/100км за последните две зареждания:",
    resultFormatted, "\n",
    "______________________________________________________"
)
// ________________________________________________________
func convertLPer100KMToMPG(
    _ avgFuelConsum: Double
) -> Double {
    let mpg = avgFuelConsum * 235.215
    return mpg
}
let avgFuelConsumInMPG = 
    convertLPer100KMToMPG(avgFuelConsum)
print(
    "Трета задача: \n",
    "Използвани литри/100км:", avgFuelConsum, "\n",
    "MPG:", avgFuelConsumInMPG, "\n",
    "______________________________________________________"
)
// ________________________________________________________
func calcAvgPricePerKm(
    fuelPricePerLiter: Double,
    avgFuelConsum: Double
) -> Double {
    let avgPricePerKm = 
        avgFuelConsum / 100 * fuelPricePerLiter
    return avgPricePerKm
}
let avgPricePerKm =
    calcAvgPricePerKm(
        fuelPricePerLiter: 3.08,
        avgFuelConsum: 4.2
    )
print(
    "Четвърта задача: \n",
    "Въведена цена на литър:", 3.08, "\n",
    "Въведени литри на 100 км:", 4.2, "\n",
    "Средна цена за км:", avgPricePerKm, "\n",
    "______________________________________________________"
)
// ________________________________________________________
func fuelConsumInfo(
    _ litersUsed: Double, 
    _ kmTravelled: Double, 
    _ dateOfFueling: String, 
    _ fuelPricePerLiter: Double
) {
    addFuel(
        distance: kmTravelled, 
        amountOfFuel: litersUsed, 
        dateOfFueling: dateOfFueling
    )
    let avgFuelConsum: Double = 
        calcAvgFuelConsum(
            litersUsed:
                addedFuel[addedFuel.count-1].1, // index of Amount of Fuel
            kmTravelled:
                addedFuel[addedFuel.count-1].0  // index of Distance
        )
    let avgPricePerKm: Double = 
        calcAvgPricePerKm(
            fuelPricePerLiter: fuelPricePerLiter,
            avgFuelConsum: avgFuelConsum
        )
    print(
        "\tСредно литрии на 100 км:", avgFuelConsum, "\n",
        "\tЦена за 1 км:", avgPricePerKm, "\n",
        "\tЦена за целия път:", 
        avgPricePerKm * kmTravelled, "\n",
        "\tДата на зареждане:", 
        addedFuel[addedFuel.count-1].2 // index of Date of Fueling
    )
}
let litersUsed: Double = 9.196
let kmTravelled: Double = 209
let dateOfFueling: String = "7-12-2022"
let fuelPricePerLiter: Double = 3.08
print(
    "Пета задача: \n",
    "Въведи данни: \n",
    "\tИзползвани литри:", litersUsed, "\n",
    "\tИзминати км:", kmTravelled, "\n",
    "\tЦена на литър:", fuelPricePerLiter, "\n",
    "Информация:"
)
fuelConsumInfo(
    litersUsed, 
    kmTravelled, 
    dateOfFueling, 
    fuelPricePerLiter
)
