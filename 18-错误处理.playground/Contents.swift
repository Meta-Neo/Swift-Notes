//: Playground - noun: a place where people can play

import UIKit


// MARK: - 表示并抛出错误
/*
 在 Swift 中，错误用符合Error协议的类型的值来表示。
 这个空协议表明该类型可以用于错误处理
 */
enum SandwichError: Error {
    case outOfCleanDishes       // 没有洗盘子
    case missingIngredients(ingredients: String)    // 缺少作料
    case outOfBread     // 没有面包
}
/*
 Swift 中有4种处理错误的方式：
 1.你可以把函数抛出的错误传递给调用此函数的代码
 2.用do-catch语句处理错误
 3.将错误作为可选类型处理
 4.或者断言此错误根本不会发生
 */
/*
 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。
 一个标有throws关键字的函数被称作throwing 函数。
 如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。
 只有 throwing 函数可以传递错误，任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
 */
// MARK: - 用do-catch语句处理错误
func makeASandwich() throws {
    print("制作三明治")
    /*
     抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行。
     抛出错误使用throw关键字。
     */
    throw SandwichError.missingIngredients(ingredients: "糖")
}
do {
    try makeASandwich()
    print("然后吃三明治")
} catch SandwichError.outOfCleanDishes {
    print("但是要先洗盘子")
} catch SandwichError.missingIngredients(let ingredients) {
    print("但是缺少作料\(ingredients)")
} catch SandwichError.outOfBread {
    print("但是没有面包片")
}

// MARK: - 将错误转换成可选值
/*
 可以使用 try? 通过将错误转换成一个可选值来处理错误。
 如果在评估 try? 表达式时一个错误被抛出，那么表达式的值就是nil
 */

func fetchDataFromDisk() throws -> Int {
    return 1
}
func fetchDataFromServer() throws -> Int {
    return 2
}
func fetchData() -> Int? {
    if let num = try? fetchDataFromDisk() { return num }
    if let num = try? fetchDataFromServer() { return num }
    return nil
}
if let result = fetchData() {
    print("\(result)")
}

// MARK: - 禁用错误传递
/*
 有时明确知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。
 如果真的抛出了错误，你会得到一个运行时错误。
 */

let res = try! fetchDataFromDisk()

// MARK: - 指定清理操作
/*
 可以使用defer语句在即将离开当前代码块时执行一系列语句。
 该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如return、break的语句。
 例如，你可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
 
 defer语句将代码的执行延迟到当前的作用域退出之前。
 该语句由defer关键字和要被延迟执行的语句组成。
 延迟执行的语句不能包含任何控制转移语句，例如break、return语句，或是抛出一个错误。
 延迟执行的操作会按照它们声明的顺序从后往前执行——也就是说，第一条defer语句中的代码最后才执行，第二条defer语句中的代码倒数第二个执行，以此类推。最后一条语句会第一个执行
 */
