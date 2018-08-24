//: Playground - noun: a place where people can play

import UIKit

/**
 集合（Set）是用来存储相同类型、没有确定顺序、且不重复的值。
 也就是说当元素顺序不重要时，或者希望确保每个元素只出现一次时，可以使用集合而不是数组。
 
 Swift 中Array、Set、Dictionariy三种基本的集合类型都是用来存储集合数据的，它们间的区别如下：
 数组（Arrays）是有序数据的集。
 集合（Sets）是无序无重复数据的集。
 字典（Dictionaries）是无序的键值对的集。
 */

// MARK: Set初始化
// 1.创建空集合
var set = Set<String>()
set.insert("Javis")
// 2.创建带初始值的集合
/**
 如果数组中的所有元素类型相同，可以不必写 Set 的具体类型。
 */
var set1 : Set<String> = ["1", "2", "3"]
var set2 = ["1", "2", "3"]

// 3.将数组转为集合
let arr = ["5", "7", "51", "7"]
let set3 = Set(arr)
print(set3)

// MARK: 元素访问与操作：增删改查
for i in 0...5 {
    set.insert("\(i)")
}
print(set)
set.remove("1")

let isContain = set.contains("blue")

let count = set.count
let isEmpty = set.isEmpty
let arr1 = set.sorted()


// MARK: 基本集合操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
/**
 使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
 使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 使用union(_:)方法根据两个集合的值创建一个新的集合。
 使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。
 */
oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
/**
 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
 */
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

// 过滤出以“e”结尾的所有元素
let fruits: Set = ["apple", "pear", "orange"]
let result = fruits.filter({ $0.hasSuffix("e") })
print(result)
