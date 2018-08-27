//: Playground - noun: a place where people can play

import UIKit

// MARK: 多行字符串字面量
let quotation = """
"Where shall I begin, please your Majesty?" he asked. \
"Begin at the beginning," the King said gravely, \
"and go on till you come to the end; then stop."
"""
print("\(quotation)")

// 1.初始化空字符串
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法，两个字符串均为空并等价。

// 2.遍历字符串
var str = "Hello"
for c in str {
    print(c)
}
// 3.判断空字符串
if emptyString.isEmpty {
    print("我是一个空字符串")
}
// 4.是否包含
// 判断开头是否包含
if str.hasPrefix("H") {
    print("包含")
}
// 判断结尾是否包含
if str.hasSuffix("o") {
    print("包含")
}
// 5. 字符串的比较
let str1 = "123 213 321"
let str2 = "123 321 213"
if str1 != str2 {
    print("不相等")
}
// MARK: 字符串可变性
// 1.字符串之间的拼接
let str3 = "2017年"
let str4 = "12月18日"
let result = str3 + str4

// 2.字符串和其他标识符之间的拼接
let age = 28
let name = "Javis"
let height = 1.83
// 拼接其他标识符的格式: \(标识符的名称)
let info = "My name is \(name), age is \(age), height is \(height)"

// 3.字符串的格式化
let minute = 3
let second = 04
//let timeStr = "0\(min):0\(second)"
let timeStr = String(format: "%02d:%02d", arguments: [minute, second])

// 4.字符串的截取
let urlString = "I love you llm"
// 将string类型转成NSString类型 string as NSString
let header = (urlString as NSString).substring(to: 4)   // 截到第4位
let middle = (urlString as NSString).substring(with: NSRange(location: 4, length: 5))   // 从第4位开始截，截5个长度
let footer = (urlString as NSString).substring(from: 10)    // 从0截到第10位

// 5.插入和删除
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome 变量现在等于 "hello!"
welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex))
// welcome 变量现在等于 "hello there!"
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome 现在等于 "hello there"
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome 现在等于 "hello

