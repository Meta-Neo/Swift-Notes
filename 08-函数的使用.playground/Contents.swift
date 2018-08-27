//: Playground - noun: a place where people can play

import UIKit

// MARK: 函数

// 1.无参无返回值
func test() -> Void {
    print("https://github.com/OmegaGo2014/Swift-notes")
}
test()

// 2.有参无返回值，此时返回值可以省略
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

// 7.输入输出参数
/**
 你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。
 当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
 注意：
 输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
 输入输出参数和返回值是不一样的。
 下面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。
 输入输出参数是函数对函数体外产生影响的另一种方式。
 */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var m = 3
var n = 1
swapTwoInts(&m, &n)

// 8.函数类型
/**
 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
 下例定义了两个简单的数学函数：addTwoInts 和 multiplyTwoInts。这两个函数都接受两个 Int 值， 返回一个 Int 值。
 前两个函数的类型为：(Int, Int) -> Int，可以解读为“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。”。
 第三个函数类型为：() -> Void，或者叫“没有参数，并返回 Void 类型的函数”。
 */
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
func printHelloWorld() {
    print("hello, world")
}
// 函数类型的使用
/**
 ”定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。
 */
var mathFunction: (Int, Int) -> Int = addTwoInts
print("\(mathFunction(2, 3))")
/**
 有相同匹配类型的不同函数可以被赋值给同一个变量，就像非函数类型的变量一样：
 */
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(3, 3))")
// 等同于
let a : String = "Edwin Javis"
var b = a
print(b)
/**
 anotherMathFunction 被推断为 (Int, Int) -> Int 类型
 */
let anotherMathFunction = addTwoInts

// 函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// 函数类型作为返回值
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
/**
 返回类型是 (Int) -> Int 类型的函数
 */
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
print("\(chooseStepFunction(backward: currentValue > 0)(3))")

let moveNearerToZero: (Int) -> Int = chooseStepFunction(backward: currentValue > 0)
print("\(moveNearerToZero(3))")

// .函数的重载
/**
 函数名称相同，参数不同(1.参数的类型不同 2.参数的个数不同)
 */
func sum(num1 : Float, num2 : Float, num3 : Float) -> Float {
    return num1 + num2 + num3
}
