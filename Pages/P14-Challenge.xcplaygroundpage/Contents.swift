/*:
 ![Make School Banner](./swift_banner.png)
# Challenge!
To cap things off, here's a challenge that will require you to use many of the concepts you've learned so far. You're going to be creating a simple card game, in which you (the player) draw a card against the computer. The highest card wins! What an exciting game!
*/
/*:
## Card Class
To start we'll make a simple card class. In fact, instead of a class, it might be even better to create a card `struct`. A `struct` is a little bit better for a couple reasons:
 
1. We don't expect to inherit from the card class, so `struct`s lack of inheritance is okay
2. A `struct` will be a little bit more performant, because of the small amount of memory our card will occupy.
 
 If all that seems a little vague or weird, that's okay! Choosing a `struct` instead of a `class` or vice-versa won't actually matter too much in any case.
 
 Our card class will have two properties: `rank` and `suit`. There are 13 ranks: Ace, King, Queen, Jack and Ten through Two. And, of course, the 4 suits are Spades, Clubs, Diamonds and Hearts.
 
 There's a couple of ways we could represent this information. For example, we could use an `Int` to represent the rank, Two would be `2`, Ten would be `10`, Jack would be `11`, etc. Or maybe we could use strings, like: `"Ace"`, `"Queen"`, `"Diamonds"`. But we shouldn't do either of those things - there's a better way! Can you think of what it is?
 */
/*:
Hopefully the answer you came up with is *enumerations*. Go ahead and use the following code to create your enumerations:
 
    enum Rank {
        case Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
     
        static func allValues() -> [Rank] {
            return [Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King]
        }
    }
     
    enum Suit {
        case Spades, Hearts, Diamonds, Clubs
     
        static func allValues() -> [Suit] {
            return [Spades, Hearts, Diamonds, Clubs]
        }
    }
 
Both enumerations come with an `allValues()` function, which returns an array containing each of the enumeration values. This function will be helpful later, when you create your `Deck` class.

 
So now, using the above `enum` code (you'll have to type it out below), create a Card `struct` with `suit` and `rank` properties, and an initializer that accepts `suit` and `rank` parameters.
*/
/* Place your code here! */


enum Rank: Int {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
    
    static func allValues() -> [Rank] {
        return [Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace]
    }
}

enum Suit: Int {
    case Spades = 4, Hearts = 3, Diamonds = 2, Clubs = 1
    
    static func allValues() -> [Suit] {
        return [Spades, Hearts, Diamonds, Clubs]
    }
}

struct Card {
    let rank: Rank
    let suit: Suit
    
    init(rank: Rank, suit: Suit){
        self.rank = rank
        self.suit = suit
    }
}

/*struct Card {
    let s: Suit
    let r: Rank
    
    init(suit: Suit, rank: Rank){
        self.s = suit
        self.r = rank
    }
}*/


/*:
## Deck Class
 
Now that you've created your card class, it's time to create a `Deck` to hold them. A standard 52 card deck has one card of each rank and suit pair. The cards in a deck must also be ordered: can you think of a data structure to hold them?
 
To start, your deck should have an empty initializer. Inside the initializer, create all 52 cards, and place them in the ordered data structure.
*/
/* Place your code here! */


/*import Foundation
class Deck {
    var deck = [Card]()
    
    init() {
        let r = Rank.allValues()
        let s = Suit.allValues()
        for suit in s {for rank in r {deck.append(Card(suit: suit, rank: rank))}}
        
    }
    
    func drawOne() -> Card?{
        if deck.count < 1{
            return nil
        }
        else {
            return deck.removeAtIndex(Int(arc4random_uniform(UInt32(deck.count))))
        }
    }

}*/

import Foundation
class Deck{
    
    var internalDeck: [Card] = []
    
    init(){
        //iterating through all the cards
        for rank in Rank.allValues(){
            for suit in Suit.allValues() {
                let card = Card(rank: rank, suit: suit)
                internalDeck.append(card)
            }
        }
    }
    
    // -> means the return value of the function (drawOne() returns a Card)
    func drawOne() -> Card? {
        
        if internalDeck.isEmpty == false {
            let numberOfCardsLeft = internalDeck.count
            let randomIndex = arc4random_uniform(UInt32(numberOfCardsLeft))
            return internalDeck.removeAtIndex(Int(randomIndex))

        }
        else {
            return nil
        }
    }
}

/*:
Now that you have a `Deck` it's time to add some functionality. Create a a function in your `Deck` class above called `drawOne()`. `drawOne()` should return a random card from the deck. Don't forget to remove that card from your internal deck data structure! 
 
 To help draw a random card, you'll probably want to use the built-in `arc4random_uniform()` function. `arc4random_unform(upperBound)` will generate a number from 0 up to but less than `upperBound`. One caveat is that `arc4random_uniform()` only likes to work with unsigned 32-bit integers (`UInt32`). So you'll need to do some casting between `UInt32` and `Int` to make it work. To access `arc4random_uniform()` you'll first need to `import Foundation`.
 
Once you've implemented `drawOne()`, uncomment the following code to test it out! You can show the debug area (⇧⌘Y) to see what's printed.
*/
func printCard(card: Card?) {
    if let card = card {
       print("The random card is the \(card.suit) of \(card.rank)")
    } else {
        print("That's not a card!")
    }
}

let testDeck = Deck()

for _ in 1...55 {
    let card = testDeck.drawOne()
    printCard(card)
}
/*:
- important:
 Does the test code above create an error?  If so, it's likely because you forgot to account for the case where there's no cards left in the deck to draw! Change your `drawOne()` method so that it returns `nil` if there's no cards left to draw.
 */
/*:
## A Simple Game
 Now it's time to make a simple game. Create a deck, and draw one card for you (the player) and one card for the computer. The highest card wins! In this game, a Two is the lowest card and Ace is the highest card. If both players draw the same rank card, then suit is used to determine the winner. Spades is the best suit, followed by Hearts, Diamonds, then Clubs.
 
 You should print out the result of the game like this:
    
>The (_player_ or _computer_) won with the _rank_ of _suit_!
 
 So, an example of the output might be:
 
    The player won with the King of Clubs!
 
 
 Here's some hints:
 
 It's best to make your code reusable. One way to do that is to place it into functions. I suggest you create a function to compare two cards to determine which one is the winner. It would also be good to have a function that prints the result of the game!
 
 You can make comparing the cards easier if you assign _raw values_ to the enumerations. Check out the [enumerations playground](P10-Enumerations) for a refresher on how to do that.
 */
/* Place your code here! */

enum Player {
    case human
    case computer
}

//the return is true if the player won, false if computer won
func compareCards(playerCard: Card, computerCard: Card) -> Player {
    if playerCard.rank.rawValue > computerCard.rank.rawValue {
        //player wins
        return Player.human
        
    }
    else if playerCard.rank.rawValue == computerCard.rank.rawValue {
        if playerCard.suit.rawValue > computerCard.suit.rawValue{
            //player wins
            return Player.human
        }
        else {
            //computer wins
            return Player.computer
        }
    }
    else{
        //computer wins
        return Player.computer
    }
}

func printEndGameMessage(winningPlayer: Player, winningCard: Card){
    var winningPlayerString: String
    
    if winningPlayer == Player.human {
        winningPlayerString = "player"
    }
        
    else{
        winningPlayerString = "computer"
    }
    
    print("The \(winningPlayerString) won with the \(winningCard.rank) of \(winningCard.suit)")
}


let deck = Deck()
let playerCard = deck.drawOne()!
let computerCard = deck.drawOne()!

let winningPlayer = compareCards(playerCard, computerCard: computerCard)

if winningPlayer == Player.human{
    printEndGameMessage(winningPlayer, winningCard: playerCard)
}
else {
    printEndGameMessage(winningPlayer, winningCard: computerCard)
}

/*:
 - important:
 Once you're done, have your instructor check your code!
 */
/*:
[Previous](@previous) | [Table of Contents](P00-Table-of-Contents) | [Advanced Topics](@next)
 */
