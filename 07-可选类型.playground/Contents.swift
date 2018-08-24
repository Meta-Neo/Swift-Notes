//: Playground - noun: a place where people can play

import UIKit

// Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。

class Person : NSObject {
    // 类中所有的属性在对象初始化时,必须有初始化值
    var name : String?  // 被自动设置为 nil
    var view : UIView?
}

/**
 下面这个构造器，作用是将一个 String 值转换成一个 Int 值。然而，并不是所有的字符串都可以转换成一个整数。字符串 "123" 可以被转换成数字 123 ，但是字符串 "hello" 不行。
 ConvertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"
 */
let possibleNumber = "hello"
let convertedNumber = Int(possibleNumber)

// 1.定义可选类型
var name : String?
var name1 : Optional<String>

// 2.从可选类型中取值
// 此时name默认为nil，所以需要给一个默认值
print(name ?? "Edwin Javis")
name = "Javis"
// 3.强制解包
// 此时确定name有值就可以强制解包
print(name!)

/**
 如果可选类型中没有值,那么强制解包程序会崩溃
 强制解包是非常危险的操作:建议在解包前先判断可选类型中是否有值
 */
if name != nil {
    print(name!)
}
// 4.可选绑定
/**
 判断name是否有值,如果没有值,则不执行{}
 如果有值,则对可选类型进行解包,并且将解包后的值赋值给前面的常量
 */
if let temp = name {
    print(temp)
}

let urlString = "https://github.com/OmegaGo2014/Swift-notes"
// 普通写法
let url : NSURL?
url = NSURL(string: urlString)
if url != nil {
    _ = NSURLRequest(url: url! as URL)
}
// 可选绑定
if let url = url {
    _ = NSURLRequest(url: url as URL)
}
// 可选绑定的简介写法
if let url = NSURL(string: urlString) {
    _ = NSURLRequest(url: url as URL)
}
