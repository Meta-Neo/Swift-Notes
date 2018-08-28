//: Playground - noun: a place where people can play

import UIKit

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


