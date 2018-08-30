//: Playground - noun: a place where people can play

import UIKit

// MARK: as、as!、as?的使用
/**
 as
 keyword：Guaranteed conversion、 Upcasting
 有保证的转换，从派生类转换为基类的向上转型
 */
// 将1转成float
let num = 1 as CGFloat
class Animal {}
class Cat: Animal {}
class Dog: Animal {
    var name = "黑子"
}
// dog转换到父类animal
let d = Dog()
d as Animal

/**
 as!
 keyword：Forced conversion、 Downcasting
 理解就是有强项转换，即向下转型，子类（派生类）向父类转换，
 官方解释说这是一个不被保证的转换，可能会因为强转的失败而会导致崩溃。
 同时是一个陷阱的标志，就像⚠️一样，用起来存在一定危险性
 */
let ani: Animal = Dog()
// as不能将a转成Dog，即不能向下转换
// ani as Dog
ani as! Dog   // as！能强行将ani转成Dog -> Bingo

/**
 as?
 keyword：Optional、 Nil
 Swfit代码中大量使用 ？
 预示着如果转换不成功的时候便会返回一个 nil 对象
 成功的话返回可选类型值（optional）
 */
let dog: Dog? = nil

dog?.name   // 选择调用，返回空值nil
// dog!.name   // 强行调用，报错
let animal: Animal = Cat()

animal as? Dog  // 猫转狗失败，返回nil
// animal as! Dog  // 猫强行转狗，失败报错

// MARK: 检查类型
let cat = Cat()
let animals = [dog, cat]

var catCount: Int = 0
var dogCount: Int = 0

for item in animals {
    if item is Cat {
        catCount += 1
    } else if item is Dog {
        dogCount += 1
    }
}
print("猫的数量：\(catCount)，狗的数量：\(dogCount)")

// MARK: Any 和 AnyObject 的类型转换
// Swift 为不确定类型提供了两种特殊的类型别名 Any 和 AnyObject
// Any 可以表示任何类型，包括函数类型
// AnyObject 可以表示任何类类型的实例

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.1415926)
things.append("hello")
things.append((3.0, 5.0))
things.append(d)
things.append({(name: String) -> String in "Hello, \(name)"})

for item in things {
    switch item {
    case 0 as Int:
        print("Int类型")
    case 0 as Double:
        print("Double类型")
    case let someInt as Int:
        print("integer\(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("其它Double类型")
    case let someString as String:
        print("String类型\"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("元组类型：\(x), \(y)")
    case let d as Dog:
        print("猫的名字叫\(d.name)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Javis"))
    default:
        print("其它")
    }
}
// Any类型可以表示所有类型的值，包括可选类型。Swift 会在你用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显式转换为Any
let optionalNumber: Int? = 3
var arrM = [Any]()
arrM.append(optionalNumber) // 警告
arrM.append(optionalNumber as Any)  // 消除警告

