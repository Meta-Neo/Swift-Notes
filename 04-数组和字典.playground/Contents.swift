//: Playground - noun: a place where people can play

import UIKit

/// 在swift中无论是数组还是字典都是使用[],但是如果[]中存放的是元素,编译器会认为是一个数组.如果[]中存放的是键值对,编译器会认为是一个字典

// MARK: 数组
/// 不可变数组
let array = ["1", "2", "3", "4", "5", "6", "7"]

/// 可变数组
var arrM = Array<String>()
var arrM1 = [String]()

// MARK: 数组的增删改查
arrM.append("0")
arrM.insert("-1", at: 0)
arrM1.append("9")

arrM.remove(at: 0)

arrM[0] = "-2"

/// 遍历数组
for i in 0..<arrM.count {
    print(arrM[i])
}
for string in arrM {
    print(string)
}
// swift中如果两个数组类型是完全一致的,可以相加进行合并
let resultM = arrM + arrM1


// MARK: 字典
/// 不可变字典
let dict : [String : String] = ["name":"Javis", "age":"28", "height":"1.83"]
let dict1 : [String : Any] = ["name":"Javis", "age":28, "height":1.83]
/// 可变字典
var dictM = Dictionary<String, Int>()
var dictM1 = [String : Any]();

/// 增删改查
dictM["key"] = 1

dictM1["name"] = "Javis"
dictM1["age"] = 28
dictM1["height"] = 1.83

dictM1.removeValue(forKey: "name")

dictM1["age"] = 30

let age : Int =  dictM1["age"] as! Int

/// 字典遍历
/// 1.遍历所有的key
for key in dictM.keys {
    print(key)
}

/// 2.遍历所有的value
for value in dictM.values {
    print(value)
}

/// 3.遍历所有的key/value
for (key, value) in dictM {
    print(key)
    print(value)
}

/// 合并字典：即使类型一直也不能直接+
let tempDict : [String : Any] = ["phoneNum" : "+86 110", "sex" : "男"]

for (key, value) in tempDict {
    dictM1[key] = value
}





