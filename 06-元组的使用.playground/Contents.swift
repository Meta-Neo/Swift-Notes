//: Playground - noun: a place where people can play

import UIKit

// 元组和数组字典最明显的区别就是中小括号()而不是[]
// 数组
let arr : [Any] = ["Javis", 28, 1.83, ("Javis", 28, 1.83)]
arr[3]
// 字典
let dict : [String : Any] = ["name":"Javis", "age":18, "height":1.88, "tuple":("Javis", 28, 1.83)]
dict["tuple"]
// 元组
let tuple : (String, Int, Float, Any) = ("Javis", 28, 1.83, ("Javis", 28, 1.83))
tuple.3

// 带别名的元组，别名可以理解为变量的名称
let tuple1 = (name:"Javis", age:28, height:1.83, tuple:("Javis", 28, 1.83))
tuple1.name
tuple1.age
tuple1.height
tuple1.tuple

let (name, age, height, tuple3) = ("Javis", 28, 1.83, ("Javis", 28, 1.83))
name
age
height
tuple3.0
