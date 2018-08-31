//: Playground - noun: a place where people can play

import UIKit

// 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型，还有就该属性是可读的还是可读可写的
// 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的
// 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示
// 协议是一种类型，因此协议类型的名称应与其他类型（例如 Int，Double，String）的写法相同，使用大写字母开头的驼峰式写法，例如（FullyNamed 和 RandomNumberGenerator）。
// MARK: - 协议的基本使用
protocol PrintName {
    // 可读可写属性
    var name: String { set get }
    // 定义类方法
    static func printClassName()
    // 定义实例方法
    func printName()
}
protocol PrintGender {
    // 可读属性，如果需要可扩展为可读可写属性
    var gender: String { get }
    func printGender()
}
// 自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔
// 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔
class Person: NSObject, PrintName, PrintGender {
    var name: String
    var gender: String
    init(name: String, gender: String) {
        self.name = name
        self.gender = gender
    }
    static func printClassName() {
        print("\(self)")
    }
    func printName() {
        print("\(self.name)")
    }
    func printGender() {
        print("\(self.gender)")
    }
}
let p = Person.init(name: "Javis", gender: "未知")
p.printName()

Person.printClassName()
p.printGender()

p.gender = "男的"
p.printGender()

// MARK: - 构造器协议
// 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类
protocol InitProtocol {
    init(name: String)
}

class Animals: InitProtocol {
    var name: String!
    // 实现构造器必须加 required
    required init(name: String) {
        self.name = name
    }
}

let dog = Animals.init(name: "🐶")
print("\(dog.name!)")

// MARK: - 协议作为类型
/*
 尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用
 1.作为函数、方法或构造器中的参数类型或返回值类型
 2.作为常量、变量或属性的类型
 3.作为数组、字典或其他容器中的元素类型
 */
class Teacher {
    let name: String!
    let pro: PrintName
    init(name: String, pro: PrintName) {
        self.name = name
        self.pro = pro
    }
    func sayName() {
        pro.printName()
    }
}
let teacher = Teacher.init(name: "无力老师", pro: p)
teacher.sayName()

// MARK: - 委托（代理）模式
protocol RobotDelegate {
    func buyTicketes(counts: Int)
}

class Robot: RobotDelegate {
    func buyTicketes(counts: Int) {
        print("已经抢购了\(counts)张票")
    }
}
class Worker {
    var delegate: RobotDelegate?
    func goHome() {
        if delegate != nil {
            delegate!.buyTicketes(counts: 3)
        }
    }
}
let robot = Robot()
var worker = Worker()

// worker.delegate = robot
worker.goHome()

// MARK: - 通过扩展遵循协议
class Scalper {
    
}

extension Scalper: RobotDelegate {
    func buyTicketes(counts: Int) {
        print("从黄牛这里买了\(counts)张票")
    }
}
let scalper = Scalper()
worker.delegate = scalper
worker.goHome()
// MARK: - 协议的继承
protocol SuperProtocol {
    var name: String? { set get }
    
}
protocol SubProtocol: SuperProtocol {
    func printName()
}
class ClassA: SubProtocol {
    var name: String?
    func printName() {
        if self.name != nil {
            print("\(self.name!)")
        }
    }
}
let a = ClassA()
a.name = "我是a"
a.printName

// MARK: - 类类型专属协议
/*
 通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议。
 class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前
 */
protocol ClassProtocol: class {
    // 这里是类类型专属协议的定义部分
}

// MARK: - 协议合成
// 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
// 函数的参数 celebrator 的类型为 Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可，即遵循了这两个协议的实例
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

// 将协议和类组合
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
// beginConcert(in:)方法接受一个类型为 Location & Named 的参数，这意味着"任何Location的子类，并且遵循Named协议"
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

// MARK: - 检查协议一致性

/*
 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。
 检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
 is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
 as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
 as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */
print("\(seattle is Named)")
print("\(seattle as? Named)")
print("\(seattle as! Named)")

// MARK: - 可选的协议要求
/*
 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。
 在协议中使用 optional 关键字作为前缀来定义可选要求。
 可选要求用在你需要和 Objective-C 打交道的代码中。
 协议和可选要求都必须带上@objc属性。
 标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
 */
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

// MARK: - 协议扩展
/*
 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。
 通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
 */
protocol TestProtocol {
    func test1()
}
extension TestProtocol {
    func test1() {
        print("我是测试的扩展")
    }
}
class ClassB: TestProtocol {
    
}
let b = ClassB()
b.test1()

// MARK: - 提供默认实现
/*
 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。
 如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。
 虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
 如果多个协议扩展都为同一个协议要求提供了默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。
 */

// MARK: - 为协议扩展添加限制条件
/*
 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。
 这些限制条件写在协议名之后，使用 where 子句来描述
 */
//extension Collection where Iterator.Element: ClassB {
//    var textualDescription: String {
//        let itemsAsText = self.map { $0.textualDescription }
//        return "[" + itemsAsText.joined(separator: ", ") + "]"
//    }
//}
