import Foundation

// Лабораторная работа №2
// Типы данных, let/var, typealias


//  A. let vs var 
let username = "Анна"           // не меняется
var score = 0                   // меняется
let pi = 3.14159                // не меняется
var currentDate = "2026-02-14"  // меняется
let maxAttempts = 3             // не меняется

// Попытка изменить let-константу → ошибка компиляции:
// username = "Мария"
// error: cannot assign to value: 'username' is a 'let' constant

score = 10
currentDate = "2026-02-15"

// B. Вывод типов
let a = 42
let b = 3.14
let c = "Hello"
let d = true
let e = 2 + 3.0

print(type(of: a))  // Int
print(type(of: b))  // Double
print(type(of: c))  // String
print(type(of: d))  // Bool
print(type(of: e))  // Double (2 — Int, 3.0 — Double, результат — Double)

//  C. Преобразование типов 
let x: Int = 17
let y: Double = 3.0

print("Double-деление: \(Double(x) / y)")
print("Int-деление: \(x / Int(y))")
// print(x / y) // error: binary operator '/' cannot be applied to operands of type 'Int' and 'Double'

//  D. Безопасное преобразование строк 
let inputs = ["42", "3.14", "hello", "100", ""]
for input in inputs {
    if let number = Int(input) {
        print("'\(input)' → Int: \(number)")
    } else if let number = Double(input) {
        print("'\(input)' → Double: \(number)")
    } else {
        print("'\(input)' → невозможно преобразовать")
    }
}

// E. Строки 
let fullName = "Иван Петров"
print("Количество символов: \(fullName.count)")
print("Первый символ: \(fullName.first!)")
print("Последний символ: \(fullName.last!)")
print("Верхний регистр: \(fullName.uppercased())")
print("Содержит 'ван': \(fullName.contains("ван"))")

let parts = fullName.split(separator: " ")
print("Имя: \(parts[0]), Фамилия: \(parts[1])")
print("Задом наперёд: \(String(fullName.reversed()))")
print("Начинается с 'Ив': \(fullName.hasPrefix("Ив"))")
print("Заканчивается на 'ов': \(fullName.hasSuffix("ов"))")// --- F. Unicode ---
let emoji = "👨‍👩‍👧‍👦"
let cafe = "café"
let simple = "hello"
print("emoji.count = \(emoji.count)")   // 1 (графемный кластер)
print("cafe.count = \(cafe.count)")     // 4
print("simple.count = \(simple.count)") // 5
print("cafe.utf8.count = \(cafe.utf8.count)")   // 5
print("cafe.utf16.count = \(cafe.utf16.count)") // 4

//  G. Кортежи
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var minVal = array[0], maxVal = array[0]
    for value in array {
        if value < minVal { minVal = value }
        if value > maxVal { maxVal = value }
    }
    return (minVal, maxVal)
}
let mm = minMax(array: [3, 1, 7, -2, 5])
print("Мин: \(mm.min), макс: \(mm.max)")

func stats(array: [Int]) -> (min: Int, max: Int, sum: Int, avg: Double) {
    let mn = array.min()!, mx = array.max()!
    let s = array.reduce(0, +)
    return (mn, mx, s, Double(s) / Double(array.count))
}
let s = stats(array: [10, 20, 30, 40, 50])
print("Мин: \(s.min), макс: \(s.max), сумма: \(s.sum), среднее: \(s.avg)")

let point = (x: 3.5, y: 7.2, label: "A")
let (px, py, label) = point
print("Точка \(label): (\(px), \(py))")
let (px2, py2, _) = point
print("Координаты: (\(px2), \(py2))")

let points = [(1.0, 1.0, "A"), (2.0, 2.0, "B"), (3.0, 3.0, "C")]
for (x, y, l) in points {
    print("Точка \(l): (\(x), \(y))")
}

// H. Typealias и студенты
typealias Student = (name: String, age: Int, grade: Double)

let students: [Student] = [
    ("Анна Иванова", 20, 4.80),
    ("Пётр Сидоров", 21, 3.90),
    ("Вера Кузнецова", 19, 4.50),
    ("Глеб Орлов", 22, 3.20),
    ("Дарья Смирнова", 20, 4.70)
]

func averageGrade(students: [Student]) -> Double {
    return students.map { $0.grade }.reduce(0, +) / Double(students.count)
}

func bestStudent(students: [Student]) -> Student? {
    return students.max { $0.grade < $1.grade }
}

func printReport(students: [Student]) {
    print("Имя              Возраст  Балл")
    print("──────────────────────────────")
    for s in students {
        print("\(s.name)     \(s.age)       \(s.grade)")
    }
    print("──────────────────────────────")
    print("Средний балл: \(averageGrade(students: students))")
    if let best = bestStudent(students: students) {
        print("Лучший студент: \(best.name) (\(best.grade))")
    }
}
printReport(students: students)

// I. Конвертер 
typealias Conversion = (value: Double, fromUnit: String, toUnit: String, result: Double)
let kmToMiles = 0.621371
let kgToPounds = 2.20462

var conversions: [Conversion] = []
conversions.append((100.0, "км", "миль", 100.0 * kmToMiles))
conversions.append((36.6, "°C", "°F", 36.6 * 9.0 / 5.0 + 32.0))
conversions.append((75.0, "кг", "фунтов", 75.0 * kgToPounds))
conversions.append((1024.0, "байт", "КБ", 1024.0 / 1024.0))

for c in conversions {
    print("\(c.value) \(c.fromUnit) = \(String(format: "%.2f", c.result)) \(c.toUnit)")
}