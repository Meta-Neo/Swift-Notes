//: Playground - noun: a place where people can play

import UIKit

// 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值，
// north，south，east和west不会被隐式地赋值为0，1，2 和 3，相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
enum CompassPoint {
    case north  // 枚举的成员
    case south
    case east
    case west
}
var direction = CompassPoint.north
// 由于类型推断，可以简写为
direction = .south

// 使用 Switch 语句穷举所有值，如果不需要穷举，则需要加入default分支判断
switch direction {
case .north:
    print("这是北边")
case .south:
    print("这是南边")
case .east:
    print("这是东边")
case .west:
    print("这是西边")
}
// MARK: 关联值
// 定义一个Barcode的枚举，它的一个成员值是具有(Int，Int，Int，Int)类型关联值的upc，另一个成员值是具有String类型关联值的qrCode，这里并没有提供任何Int或String类型的关联值，仅仅是定义
/** 条形码枚举. */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
// 为枚举成员设置一个常量或者变量，并赋值、存储、查看
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
print("\(productBarcode)")

// 在 switch的 case 分支代码中提取每个关联值
switch productBarcode {
case .upc(let num1, let num2, let num3, let num4):
    print("UPC: \(num1), \(num2), \(num3), \(num4).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

// 如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var
switch productBarcode {
case let .upc( num1, num2, num3, num4):
    print("UPC: \(num1), \(num2), \(num3), \(num4).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// MARK: 原始值
// 原始值是关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同
enum directionType : String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}
print(directionType.north)

// 原始值可以被隐式赋值
// 表示每个行星在太阳系中的顺序，Plant.mercury的显式原始值为1，Planet.venus的隐式原始值为2，依次类推。
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
enum directionEnum: String {
    case north, south, east, west
}
// 使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
let earthsOrder = Planet.earth.rawValue
let directionValue = directionEnum.west.rawValue

// 使用原始值初始化枚举实例
// 并非所有Int值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员
let possiblePlanet = Planet(rawValue: 7)

// MARK: 递归枚举
// 枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的
indirect enum ArithmeticExpr {
    case number(Int)
    case addition(ArithmeticExpr, ArithmeticExpr)
    case multiplication(ArithmeticExpr, ArithmeticExpr)
}

let five = ArithmeticExpr.number(5)
let four = ArithmeticExpr.number(4)
let sum = ArithmeticExpr.addition(five, four)
let product = ArithmeticExpr.multiplication(sum, ArithmeticExpr.number(2))

// 要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式
func evaluate(_ expression: ArithmeticExpr) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))

