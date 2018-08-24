//: Playground - noun: a place where people can play

import UIKit

// MARK: 函数

// 1.无参无返回值
func test() -> Void {
    print("https://github.com/OmegaGo2014/Swift-notes")
}
test()

// 2.有参无返回值
func test1 (name : String) {
    print(name)
}
test1(name: "Javis")

// 3.无参有返回值
func test2() -> String {
    return "吃饭了吗?"
}
print(test2())

// 4.有参有返回值
func sum(num1 : Int, num2 : Int) -> Int {
    return num1 + num2
}
print(sum(num1: 2, num2: 3))

// 5.默认参数，参数带有默认值
func buyCoffee(brand : String = "拿铁") -> String {
    return "买了一杯\(brand)咖啡"
}
buyCoffee()
buyCoffee(brand: "雀巢")

// 6.可变参数
func sum(nums : Int...) -> Int {
    var result = 0
    for num in nums {
        result += num
    }
    return result
}
sum(nums: 1, 2, 3, 4)
sum(nums: 1, 2, 3, 4, 5, 6)

// 7.函数的重载
/**
 函数名称相同，参数不同(1.参数的类型不同 2.参数的个数不同)
 */
func sum(num1 : Float, num2 : Float, num3 : Float) -> Float {
    return num1 + num2 + num3
}

// MARK: 类
class Person : NSObject {
    // 类中所有的属性在对象初始化时,必须有初始化值
    var name : String?
    var age : Int = 0
    var height : Double = 0.0
}
let p = Person()
// 注意:赋值不是调用set方法,直接拿到属性给属性赋值
p.name = "Javis"
p.age = 28
p.height = 1.83
print(p)
