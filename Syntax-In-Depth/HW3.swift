import Foundation
struct ATM {
    let id: String
    var availableMoney: [String:Double]
    let percentTaxForConversion: Double
}
struct Card {
    let id: String
    let user: String
    var availableMoney: [String:Double]
}
func printMoneyInATMAndCard(
    _ atmMoney: Double,
    _ cardBGN: Double, 
    _ cardEUR: Double, 
    _ cardUSD: Double
) {
    // %.2f не работи
    let atmMoneyFormatted: Double = 
        (atmMoney * 100).rounded() / 100 
    let cardBGNFormatted: Double = 
        (cardBGN * 100).rounded() / 100
    let cardEURFormatted: Double = 
        (cardEUR * 100).rounded() / 100
    let cardUSDFormatted: Double = 
        (cardUSD * 100).rounded() / 100
    print(
        "ATM money:", atmMoneyFormatted, "lv.",
        "\nCard BGN:", cardBGNFormatted, "lv.",
        "\nCard EUR: €", cardEURFormatted,
        "\nCard USD: $", cardUSDFormatted
    )
}
func drawMoney(
    atm: inout ATM,
    card: inout Card,
    amount: Double
) {
    printMoneyInATMAndCard(
        atm.availableMoney["BGN"]!, 
        card.availableMoney["BGN"]!,
        card.availableMoney["EUR"]!,
        card.availableMoney["USD"]!
    )
    print("\nЖелана сума за теглене:", amount, "lv.\n")
    let tax = (100 + atm.percentTaxForConversion) / 100
    var isBGN = false
    var isEUR = false
    let atmAvailableMoney = 
        atm.availableMoney["BGN"]!
    let cardAvailableMoney: Double
    if card.availableMoney["BGN"]! >= amount {
        cardAvailableMoney = 
        card.availableMoney["BGN"]!
        isBGN = true
    } else if card.availableMoney["EUR"]! * 1.956 * tax >= amount {
        cardAvailableMoney = 
        card.availableMoney["EUR"]!
        isEUR = true
    } else {
        cardAvailableMoney = 
        card.availableMoney["USD"]!
    }
    let atmUpdatedMoney = 
        atmAvailableMoney - amount
    let cardUpdatedMoney: Double
    if isBGN {
        cardUpdatedMoney = 
            cardAvailableMoney - amount
    } else if isEUR {
        cardUpdatedMoney = 
            cardAvailableMoney - amount / 1.956 * tax
    } else {
        cardUpdatedMoney = 
            cardAvailableMoney - amount / 1.858 * tax
    }
    if atmUpdatedMoney >= 0 && cardUpdatedMoney >= 0 {
        atm.availableMoney.updateValue(
            atmUpdatedMoney, 
            forKey: "BGN"
        )
        if isBGN {
            card.availableMoney.updateValue(
                cardUpdatedMoney, 
                forKey: "BGN"
            )
        } else if isEUR {
            card.availableMoney.updateValue(
                cardUpdatedMoney, 
                forKey: "EUR"
            )
        } else {
            card.availableMoney.updateValue(
                cardUpdatedMoney, 
                forKey: "USD"
            )
        }
        printMoneyInATMAndCard(
        atm.availableMoney["BGN"]!, 
        card.availableMoney["BGN"]!,
        card.availableMoney["EUR"]!,
        card.availableMoney["USD"]!
    )
    } else if atmUpdatedMoney < 0 {
        print("Недостатъчна наличност в банкомата")
    } else {
        print("Недостатъчна наличност по вашата сметка")
    }
    print("______________________________________")
}
//_________________________________________________________
var atmHaskovo = ATM(
    id: "Ies>|0A0", 
    availableMoney: ["BGN" : 20],
    percentTaxForConversion: 2
)
var myCard = Card(
    id: "wv)eJp",
    user: "myName",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
drawMoney(
    atm: &atmHaskovo, 
    card: &myCard,
    amount: 20
)
//_________________________________________________________
var atmPlovdiv = ATM(
    id: "d10Ap!A", 
    availableMoney: ["BGN" : 100],
    percentTaxForConversion: 2
)
var userFromPlovdivCard = Card(
    id: "nsaJtJ0wd10Ap!A",
    user: "userFromPlovdiv",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
drawMoney(
    atm: &atmPlovdiv, 
    card: &userFromPlovdivCard,
    amount: 80
)
//_________________________________________________________
var atmSofia = ATM(
    id: "S0t!e", 
    availableMoney: ["BGN" : 100],
    percentTaxForConversion: 2
)
var userFromSofiaCard = Card(
    id: "nsaJtJ0wS0t!e",
    user: "userFromSofia",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
drawMoney(
    atm: &atmSofia, 
    card: &userFromSofiaCard,
    amount: 90
)
//_________________________________________________________
var atmVarna = ATM(
    id: "AeJue", 
    availableMoney: ["BGN" : 60],
    percentTaxForConversion: 2
)
var userFromVarnaCard = Card(
    id: "nsaJtJ0wAeJue",
    user: "userFromVarna",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
drawMoney(
    atm: &atmVarna, 
    card: &userFromVarnaCard,
    amount: 90
)
//_________________________________________________________
var atmBurgas = ATM(
    id: "I3nJges", 
    availableMoney: ["BGN" : 100],
    percentTaxForConversion: 2
)
var userFromBurgasCard = Card(
    id: "nsaJtJ0wI3nJges",
    user: "userFromVarna",
    availableMoney: ["BGN" : 80, "EUR" : 60, "USD" : 0]
)
drawMoney(
    atm: &atmBurgas, 
    card: &userFromBurgasCard,
    amount: 100
)
//_________________________________________________________
var atmLocal = ATM(
    id: "L0)e1", 
    availableMoney: ["BGN" : 400],
    percentTaxForConversion: 2
)
var userLocalCard = Card(
    id: "nsaJL0)e1",
    user: "userFromVarna",
    availableMoney: ["BGN" : 80, "EUR" : 60, "USD" : 0]
)
drawMoney(
    atm: &atmLocal, 
    card: &userLocalCard,
    amount: 150
)
//_________________________________________________________
var atm000 = ATM(
    id: "ooo", 
    availableMoney: ["BGN" : 1000],
    percentTaxForConversion: 2
)
var user000 = Card(
    id: "nsaJooo",
    user: "user000",
    availableMoney: ["BGN" : 0, "EUR" : 0, "USD" : 1000000]
)
drawMoney(
    atm: &atm000, 
    card: &user000,
    amount: 666
)
