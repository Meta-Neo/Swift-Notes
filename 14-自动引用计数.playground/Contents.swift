//: Playground - noun: a place where people can play

import UIKit

// MARK: 析构过程
class Bank {
    /** 银行总硬币数量. */
    static var coinsInBank = 10000
    /** 发放硬币. */
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    /** 收回硬币. */
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
class Player {
    /** 钱包总硬币数量. */
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    // playerOne = nil之后调用该析构函数，将硬币还给银行
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
// 玩家是可选类型，因为玩家可以随时离开游戏
var player1: Player? = Player(coins: 100)
print("一个新的玩家加入游戏，钱包里有\(player1!.coinsInPurse)个硬币，银行现在还剩\(Bank.coinsInBank)个硬币")
player1!.win(coins: 2000)
print("玩家赢了2000硬币，现在钱包里有\(player1!.coinsInPurse)个硬币, 银行现在还剩\(Bank.coinsInBank)个硬币")
player1 = nil
print("玩家离开游戏，银行现在有\(Bank.coinsInBank)个硬币")

/**
 析构过程原理
 Swift 会自动释放不再需要的实例以释放资源，Swift 通过自动引用计数（ARC）处理实例的内存管理
 析构器是在实例释放发生前被自动调用。你不能主动调用析构器。
 子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。
 即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
 因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）
 */
/**
 自动引用计数的工作机制
 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你试图访问这个实例，你的应用程序很可能会崩溃。
 为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。
 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
 */
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name)被初始化了")
    }
    deinit {
        print("\(name)已经析构了")
    }
}
var p1: Person? = Person.init(name: "Edwin")
var p2: Person? = Person.init(name: "Javis")
var p3: Person? = Person.init(name: "WangNan")
var p4: Person?
var p5: Person?

p4 = p1
p5 = p1

p1 = nil
p2 = nil
p3 = nil

// 此时p1还没有释放，因为还有p4、p5强引用
p4 = nil
// 此时p1还没有释放，因为还有p5一个强引用
p5 = nil

// MARK: 类实例之间的循环强引用
/**
 有时候可能会写出一个类实例的强引用数永远不能变成0的代码
 如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用
 解决方法：可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题
 */
class Owner {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    
    deinit { print("公寓拥有者\(name)已经析构")
    }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
//    var owner: Owner?
    // 在这里加上weak关键词 即可解决
    weak var owner: Owner?
    deinit {
        print("公寓\(unit)已经析构")
    }
}
var me: Owner? = Owner(name: "Javis")
var unit4A: Apartment? = Apartment(unit: "4A")

// owner实例现在有了一个指向Apartment实例的强引用，而Apartment实例也有了一个指向owner实例的强引用
me!.apartment = unit4A
unit4A!.owner = me

// 当你把这两个变量设为nil时，没有任何一个析构函数被调用。循环强引用会一直阻止Person和Apartment类实例的销毁，这就在你的应用程序中造成了内存泄漏。
me = nil
unit4A = nil


// MARK: 无主引用
// 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。
// 在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("卡拥有者\(name)已经被析构")
    }
}
class CreditCard {
    let number: UInt64
    // 无主引用通常都被期望拥有值
    // 使用无主引用，你必须确保引用始终指向一个未销毁的实例。
    // 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card\(number)已经被析构")
    }
}
var john: Customer? = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

// Customer实例持有对CreditCard实例的强引用，而CreditCard实例持有对Customer实例的无主引用。
// 由于customer的无主引用，当你断开john变量持有的强引用时，再也没有指向Customer实例的强引用了
john = nil


// 无主引用以及隐式解析可选属性
// 场景1：owner和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
// 场景2：Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
// 场景3：然而，如果两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。

class Country {
    let name: String
    var capital: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capital = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "加拿大", capitalName: "渥太华")
print("\(country.name)的首都是：\(country.capital.name)")

/**
 Country的构造函数调用了City的构造函数。然而，只有Country的实例完全初始化后，Country的构造函数才能把self传给City的构造函数。在两段式构造过程中有具体描述。
 
 为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将Country的capital属性声明为隐式解析可选类型的属性。这意味着像其他可选类型一样，capital属性的默认值为nil，但是不需要展开它的值就能访问它
 使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求
 capital属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用
 */

// MARK: 解决闭包引起的循环强引用
/*
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。
 捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。
 跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。
 应当根据代码关系来决定使用弱引用还是无主引用。
 */

// 定义捕获列表
// 捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。

// 如果闭包有参数列表和返回类型，把捕获列表放在它们前面
/*
lazy var closure1: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    "我是测试闭包"
}
lazy var closure2: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // 这里是闭包的函数体
}
 */
/*
 在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用
 相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用
 弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在
 注意：如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用
 */



