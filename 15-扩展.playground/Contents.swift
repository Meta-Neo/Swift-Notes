//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
 扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。
 扩展和 Objective-C 中的分类类似，但是Swift的扩展没有名字
 
 Swift 中的扩展可以：
 添加计算型属性和计算型类型属性，扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
 定义实例方法和类型方法
 提供新的构造器
 定义下标
 定义和使用新的嵌套类型
 使一个已有类型符合某个协议
 
 在 Swift 中，甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些功能。
 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
}
let oneKm = 1000.m
let oneMeter = 0.001.km
print("\(oneKm),\(oneMeter)")

// 1.扩展方法
extension Int {
    func repeatition(closure: () -> Void) {
        for _ in 0..<self {
            closure()
        }
    }
}
3.repeatition {
    print("hello")
}
// 2.扩展可变方法
extension Int {
    mutating func square() {
        self = self * self
    }
}
var num = 10
num.square()
print("\(num)")

// 3.扩展一个构造器
// 扩展可以为已有类型添加新的构造器，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项
// 扩展只能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供
// 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect.init(center: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
print("\(centerRect)")

// 4.扩展下标
// 该下标 [n] 返回十进制数字从右向左数的第 n 个数字：
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
print("\(1234567890[2])")

// 5.扩展可以为已有的类、结构体和枚举添加新的嵌套类型
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
