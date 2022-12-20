import Foundation
var counter: Int = 0
struct ATM {
    let id: String
    var availableMoney: [String:Double]
    let percentTaxForConversion: Double
}
struct Card {
    let id: String
    let user: String
    var bankAccount: BankAccount
}
struct BankAccount {
    let user: String
    let IBAN: String
    var availableMoney: [String:Double]
}
func printMoneyInATMAndCard(
    _ atmBGN: Double,
    _ atmEUR: Double,
    _ atmUSD: Double,
    _ cardBGN: Double, 
    _ cardEUR: Double, 
    _ cardUSD: Double
) {
    // %.2f не работи
    let atmBGNFormatted: Double = 
        (atmBGN * 100).rounded() / 100 
    let atmEURFormatted: Double = 
        (atmEUR * 100).rounded() / 100 
    let atmUSDFormatted: Double = 
        (atmUSD * 100).rounded() / 100 
    let cardBGNFormatted: Double = 
        (cardBGN * 100).rounded() / 100
    let cardEURFormatted: Double = 
        (cardEUR * 100).rounded() / 100
    let cardUSDFormatted: Double = 
        (cardUSD * 100).rounded() / 100
    print(
        "ATM BGN:", atmBGNFormatted,
        "\nATM EUR:", atmEURFormatted,
        "\nATM USD:", atmUSDFormatted,
        "\nCard BGN:", cardBGNFormatted,
        "\nCard EUR:", cardEURFormatted,
        "\nCard USD:", cardUSDFormatted
    )
}
func drawMoney(
    atm: inout ATM,
    card: inout Card,
    amount: [String:Double]
) {
    counter = counter + 1
    print("__________________\(counter)____________________")
    printMoneyInATMAndCard(
        atm.availableMoney["BGN"]!, 
        atm.availableMoney["EUR"]!, 
        atm.availableMoney["USD"]!,
        card.bankAccount.availableMoney["BGN"]!,
        card.bankAccount.availableMoney["EUR"]!,
        card.bankAccount.availableMoney["USD"]!
    )
    print("\nЖелана сума за теглене:", amount, "\n")
    let tax = (100 + atm.percentTaxForConversion) / 100
    if amount["BGN"] != nil {
        var isBGN = false
        var isEUR = false
        let atmAvailableBGN = 
            atm.availableMoney["BGN"]!  
        let cardAvailableMoney: Double
        if card.bankAccount.availableMoney["BGN"]! >= amount["BGN"]! {
            cardAvailableMoney = 
            card.bankAccount.availableMoney["BGN"]!
            isBGN = true
        } else if card.bankAccount.availableMoney["EUR"]! * 1.956 * tax >= amount["BGN"]! {
            cardAvailableMoney = 
            card.bankAccount.availableMoney["EUR"]!
            isEUR = true
        } else {
            cardAvailableMoney = 
            card.bankAccount.availableMoney["USD"]!
        }
        let atmUpdatedMoney = 
        atmAvailableBGN - amount["BGN"]!
        let cardUpdatedMoney: Double
        if isBGN {
            cardUpdatedMoney = 
                cardAvailableMoney - amount["BGN"]!
        } else if isEUR {
            cardUpdatedMoney = 
                cardAvailableMoney - amount["BGN"]! / 1.956 * tax
        } else {
            cardUpdatedMoney = 
                cardAvailableMoney - amount["BGN"]! / 1.858 * tax
        }
        if atmUpdatedMoney >= 0 && cardUpdatedMoney >= 0 {
            atm.availableMoney.updateValue(
                atmUpdatedMoney, 
                forKey: "BGN"
            )
            if isBGN {
                card.bankAccount.availableMoney.updateValue(
                    cardUpdatedMoney, 
                    forKey: "BGN"
                )
            } else if isEUR {
                card.bankAccount.availableMoney.updateValue(
                    cardUpdatedMoney, 
                    forKey: "EUR"
                )
            } else {
                card.bankAccount.availableMoney.updateValue(
                    cardUpdatedMoney, 
                    forKey: "USD"
                )
            }
            printMoneyInATMAndCard(
            atm.availableMoney["BGN"]!, 
            atm.availableMoney["EUR"]!, 
            atm.availableMoney["USD"]!, 
            card.bankAccount.availableMoney["BGN"]!,
            card.bankAccount.availableMoney["EUR"]!,
            card.bankAccount.availableMoney["USD"]!
            )
        } else if atmUpdatedMoney < 0 {
            print("Недостатъчна наличност в банкомата")
        } else {
            print("Недостатъчна наличност по вашата сметка")
        }
    } else if amount["EUR"] != nil {
        let atmAvailableEUR = 
            atm.availableMoney["EUR"]! 
        let cardAvailableMoney = 
            card.bankAccount.availableMoney["EUR"]!
        let atmUpdatedMoney = 
            atmAvailableEUR - amount["EUR"]!
        let cardUpdatedMoney = 
            cardAvailableMoney - amount["EUR"]!
        if atmUpdatedMoney >= 0 && cardUpdatedMoney >= 0 {
            atm.availableMoney.updateValue(
                atmUpdatedMoney, 
                forKey: "EUR"
            )
            card.bankAccount.availableMoney.updateValue(
                cardUpdatedMoney, 
                forKey: "EUR"
            )
            printMoneyInATMAndCard(
                atm.availableMoney["BGN"]!, 
                atm.availableMoney["EUR"]!, 
                atm.availableMoney["USD"]!, 
                card.bankAccount.availableMoney["BGN"]!,
                card.bankAccount.availableMoney["EUR"]!,
                card.bankAccount.availableMoney["USD"]!
            )
        } else if atmUpdatedMoney < 0 {
            print("Недостатъчна наличност в банкомата")
        } else {
            print("Недостатъчна наличност по вашата сметка")
        }
    } else {
        let atmAvailableUSD = 
            atm.availableMoney["USD"]! 
        let cardAvailableMoney = 
            card.bankAccount.availableMoney["USD"]!
        let atmUpdatedMoney = 
            atmAvailableUSD - amount["USD"]!
        let cardUpdatedMoney = 
            cardAvailableMoney - amount["USD"]!
        if atmUpdatedMoney >= 0 && cardUpdatedMoney >= 0 {
            atm.availableMoney.updateValue(
                atmUpdatedMoney, 
                forKey: "USD"
            )
            card.bankAccount.availableMoney.updateValue(
                cardUpdatedMoney, 
                forKey: "USD"
            )
            printMoneyInATMAndCard(
                atm.availableMoney["BGN"]!, 
                atm.availableMoney["EUR"]!, 
                atm.availableMoney["USD"]!, 
                card.bankAccount.availableMoney["BGN"]!,
                card.bankAccount.availableMoney["EUR"]!,
                card.bankAccount.availableMoney["USD"]!
            )
        } else if atmUpdatedMoney < 0 {
            print("Недостатъчна наличност в банкомата")
        } else {
            print("Недостатъчна наличност по вашата сметка")
        }
    }
}
//___________________________1______________________________
var atmHaskovo = ATM(
    id: "Ies>|0A0", 
    availableMoney: ["BGN" : 20, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var myBankAccount = BankAccount(
    user: "myName",
    IBAN: "FJKLASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
var myCard = Card(
    id: "wv)eJp",
    user: "myName",
    bankAccount: myBankAccount
)
drawMoney(
    atm: &atmHaskovo, 
    card: &myCard,
    amount: ["BGN" : 20]
)
//___________________________2_______________________________
var atmPlovdiv = ATM(
    id: "d10Ap!A", 
    availableMoney: ["BGN" : 100, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var plovdivBankAccount = BankAccount(
    user: "userFromPlovdiv",
    IBAN: "ASDFADLASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
var userFromPlovdivCard = Card(
    id: "nsaJtJ0wd10Ap!A",
    user: "userFromPlovdiv",
    bankAccount: plovdivBankAccount
)
drawMoney(
    atm: &atmPlovdiv, 
    card: &userFromPlovdivCard,
    amount: ["BGN" : 80]
)
//___________________________3______________________________
var atmSofia = ATM(
    id: "S0t!e", 
    availableMoney: ["BGN" : 100, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var sofiaBankAccount = BankAccount(
    user: "userFromSofia",
    IBAN: "ZXCVZXCASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
var userFromSofiaCard = Card(
    id: "nsaJtJ0wS0t!e",
    user: "userFromSofia",
    bankAccount: sofiaBankAccount
)
drawMoney(
    atm: &atmSofia, 
    card: &userFromSofiaCard,
    amount: ["BGN" : 90]
)
//___________________________4______________________________
var atmVarna = ATM(
    id: "AeJue", 
    availableMoney: ["BGN" : 60, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var varnaBankAccount = BankAccount(
    user: "userFromVarna",
    IBAN: "QWERASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 0, "USD" : 0]
)
var userFromVarnaCard = Card(
    id: "nsaJtJ0wAeJue",
    user: "userFromVarna",
    bankAccount: varnaBankAccount
)
drawMoney(
    atm: &atmVarna, 
    card: &userFromVarnaCard,
    amount: ["BGN" : 90]
)
//___________________________5______________________________
var atmBurgas = ATM(
    id: "I3nJges", 
    availableMoney: ["BGN" : 100, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var burgasBankAccount = BankAccount(
    user: "userFromVarna",
    IBAN: "ZVCLASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 60, "USD" : 0]
)
var userFromBurgasCard = Card(
    id: "nsaJtJ0wI3nJges",
    user: "userFromVarna",
    bankAccount: burgasBankAccount
)
drawMoney(
    atm: &atmBurgas, 
    card: &userFromBurgasCard,
    amount: ["BGN" : 100]
)
//___________________________6______________________________
var atmLocal = ATM(
    id: "L0)e1", 
    availableMoney: ["BGN" : 400, "EUR" : 0, "USD" : 0],
    percentTaxForConversion: 2
)
var localBankAccount = BankAccount(
    user: "userLocal",
    IBAN: "ASVCXZSFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 80, "EUR" : 60, "USD" : 0]
)
var userLocalCard = Card(
    id: "nsaJL0)e1",
    user: "userLocal",
    bankAccount: localBankAccount
)
drawMoney(
    atm: &atmLocal, 
    card: &userLocalCard,
    amount: ["BGN" : 150]
)
//___________________________7______________________________
var atmFromHW4 = ATM(
    id: "tj0wHMb", 
    availableMoney: ["BGN" : 0, "EUR" : 70, "USD" : 20],
    percentTaxForConversion: 2
)
var hw4BankAccount = BankAccount(
    user: "userFromHW4",
    IBAN: "PIOULKAS1438913KFHSA",
    availableMoney: ["BGN" : 120, "EUR" : 20, "USD" : 0]
)
var userFromHW4 = Card(
    id: "nsaJtj0wHMb",
    user: "userFromHW4",
    bankAccount: hw4BankAccount
)
drawMoney(
    atm: &atmFromHW4, 
    card: &userFromHW4,
    amount: ["EUR" : 50]
)
//___________________________8______________________________
var atmFromHW42 = ATM(
    id: "tj0wHMb5", 
    availableMoney: ["BGN" : 0, "EUR" : 70, "USD" : 20],
    percentTaxForConversion: 2
)
var hw42BankAccount = BankAccount(
    user: "userFromHW42",
    IBAN: "LJKHLASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 120, "EUR" : 60, "USD" : 0]
)
var userFromHW42 = Card(
    id: "nsaJtj0wHMb5",
    user: "userFromHW42",
    bankAccount: hw42BankAccount
)
drawMoney(
    atm: &atmFromHW42, 
    card: &userFromHW42,
    amount: ["EUR" : 50]
)
//___________________________9______________________________
var atmFromHW422 = ATM(
    id: "tj0wHMb55", 
    availableMoney: ["BGN" : 0, "EUR" : 20, "USD" : 70],
    percentTaxForConversion: 2
)
var hw422BankAccount = BankAccount(
    user: "userFromHW422",
    IBAN: "MVBASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 120, "EUR" : 0, "USD" : 20]
)
var userFromHW422 = Card(
    id: "nsaJtj0wHMb55",
    user: "userFromHW422",
    bankAccount: hw422BankAccount
)
drawMoney(
    atm: &atmFromHW422, 
    card: &userFromHW422,
    amount: ["USD" : 50]
)
//___________________________10______________________________
var atmFromHW4222 = ATM(
    id: "tj0wHMb555", 
    availableMoney: ["BGN" : 0, "EUR" : 20, "USD" : 70],
    percentTaxForConversion: 2
)
var hw4222BankAccount = BankAccount(
    user: "userFromHW4222",
    IBAN: "IVBASFLKAS1438913KFHSA",
    availableMoney: ["BGN" : 120, "EUR" : 0, "USD" : 60]
)
var userFromHW4222 = Card(
    id: "nsaJtj0wHMb555",
    user: "userFromHW4222",
    bankAccount: hw4222BankAccount
)
drawMoney(
    atm: &atmFromHW4222, 
    card: &userFromHW4222,
    amount: ["USD" : 50]
)
//___________________________11______________________________
var atmTest = ATM(
    id: "JLasf", 
    availableMoney: ["BGN" : 1000, "EUR" : 1000, "USD" : 1000],
    percentTaxForConversion: 2
)
var bankAccountTest = BankAccount(
    user: "userTest",
    IBAN: "TEST1234TEST5678",
    availableMoney: ["BGN" : 750, "EUR" : 500, "USD" : 250]
)
var userTest1 = Card(
    id: "nsaJJLasfJ",
    user: "userTest",
    bankAccount: bankAccountTest
)
var userTest2 = Card(
    id: "nsaJJLasf5",
    user: "userTest",
    bankAccount: bankAccountTest
)
drawMoney(
    atm: &atmTest, 
    card: &userTest1,
    amount: ["BGN" : 666]
)
drawMoney(
    atm: &atmTest, 
    card: &userTest2,
    amount: ["USD" : 1]
)
