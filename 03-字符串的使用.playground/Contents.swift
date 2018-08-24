//: Playground - noun: a place where people can play

import UIKit

// 1.声明一个字符串变量
var str = "Hello, playground"

// MARK: 遍历字符串
for c in str {
    print(c)
}
// MARK: 字符串的拼接
// 1.字符串之间的拼接
let str1 = "2017年"
let str2 = "12月18日"
let result = str1 + str2

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

