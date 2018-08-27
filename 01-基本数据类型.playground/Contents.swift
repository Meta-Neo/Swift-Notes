//: Playnround - noun: a place where people can play

import UIKit

// MARK: 数据基本类型
/**
 swimt的标识符必须指定是一个常量(let)还是一个变量(var) 一般格式为：let/var 标识符 : 标识符类型 = 初始化值
 语句结束后可以不跟冒号，但是前提是一行只能一条语句，如果有多条语句，其间就需要用冒号分割
 */
var a : Int = 10;
a = 29;
/**
 Double表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。
 Float表示32位浮点数。精度要求不高的话可以使用此类型。
 Double精确度很高，至少有15位数字，而Float只有6位数字。
 选择哪个类型取决于你的代码需要处理的值的范围
 在两种类型都匹配的情况下，将优先选择 Double。
 */
let b : Double = 3.123456789012345;
let c : Float = 0.30000123;
print(a, b, c, "hello world")
/*
 当推断浮点数的类型时，Swift 总是会选择 Double 而不是Float。
 */
let d = 0.34

/**
 在开发中优先使用常量,只有在需要修改时,在修改成var
 常量本质:保存的内存地址不可以修改,但是可以通过内存地址拿到对象,之后修改对象内部的属性
 见下例
 */
let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))  // 创建UIView对象并且制定mrame
view.backgroundColor = UIColor.cyan // 设置属性
let  button : UIButton = UIButton(type: .custom);   // 实例化一个button对象
button.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width/2, height: view.bounds.size.height/2)
button.center = view.center;
view.addSubview(button) // 添加到view上

// MARK: 数据的类型推导
/**
 这里并没有明显的类型标注，但是Swift可以推断出该变量是什么类型
 可以通过:option + 鼠标左键,查看一个标识符的类型
 */
var m = 30
let n = 3.14

// MARK: 数据的基本运算
/**
 Swift中没有隐式转化,不会将整形自动转成浮点型
 错误写法：let result = m + n
 */
let result1 = Double(m) + n // 将整型转成浮点型
let result2 = m + Int(n)    // 将浮点型转成整型
