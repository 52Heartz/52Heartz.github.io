---
title: Java对象与类
date: 2018-12-27 23:46:55
categories:
- 技术
tags:
- Java
---

# 面向对象的一些基本概念

对象中的数据称为 `实例域（instance field）`

## 类之间的关系

在类之间，最常见的关系有

- 依赖（Dependency）：“uses-a”
- 聚合（Aggregation）：“has-a”
- 继承（Inheritance）：“is-a”

# 使用Java语言提供的预定义类

`new` 操作符返回的是一个引用。

## 对象和对象变量的区别

对象变量只是一个变量。对象是类的一个示例。一个对象变量引用一个对象。

可以显式地将对象变量设置为 `null`，表示对象变量没有引用任何对象。注意，如果只定义局部变量而不显式地初始化，那么局部变量是不会自动初始化为 `null`的。所以如果想设置对象变量为不引用任何对象，一定要显式地设置为 `null` 。

<!-- more -->

## Java类库中的 `LocalDate` 类

## `Date` 类和 `LocalDate` 类的区别

`Date` 类的对象有一个状态，也就是一个特定的精确到毫秒的时间点。

`LocalDate` 则只精确到日。

对于很多常用的情况，像日历的应用，只需要精确到日就可以了，这个时候使用 `LocalDate` 更加方便一些。



## `LocalDate` 的使用

不要使用构造器来构造 `LocalDate` 类的对象，应该使用 `静态工厂方法（factory method）` 来代替构造器。

调用 `LocalDate.now()` 会构造一个新对象，表示构造这个对象时的日期。

使用示例：

```java
LocalDate newYearsEve = LocalDate.of(1999,12,31); // 构造一个表示特定日期的对象

// 获取年月日的值
int year = newYearsEve.getYear();
int month = newYearsEve.getMonthValue();
int day = newYearsEve.getDayOfMonth();

LocalDate aThousandDaysLater = newYearsEve.plusDays(1000); // 计算机1000天后的日期
```



## 更改器方法与访问器方法

上一节的 `newYearsEve.plusDays(1000)` 调用，`newYearsEve` 本身不发生变化，`plusDays()` 方法会生成一个新的 `LocalDate` 对象作为返回值。`String` 类的 `toUpperCase()` 方法也不会对对象本身进行更改而是返回一个将字符串大写的新字符串。这种只访问对象不修改对象的方法叫做 `访问器方法（accessor method）`。

一个对象调用了自己的一个方法之后，如果对象本身发生改变，那么称这种方法为 `更改器方法（mutator method）`。



# 用户自定义类

一个Java源文件的文件名必须与 `public` 类的名字相同，在一个源文件中，只能有一个公有类，但可以有任意数目的非公有类。如果文件中没有 `public` 类，文件命名不受约束。

## 构造器

- 构造器与类同名
- 一个类可以有多个构造器
- 构造器没有返回值
- 对于一个对象而言，只能在创建对象的时候使用 `new` 操作符调用一次构造器，对象创建完成之后就不能再调用构造器了。

## 隐式参数和显式参数

假设有一个方法调用为：

```java
employee1.raiseSalary(5);
```

这里，我们看到括号中只有一个参数，这种括号中的参数叫做 `显式参数（explicit parameter）`。其实调用这个方法的对象本身也作为方法的一个参数，这个对象叫做方法的 `隐式参数（implicit parameter）` 。

在一个方法定义的内部，可以使用 `this` 关键字来指代 `隐式参数`。

## 封装

注意不要编写返回引用可变对象的访问器方法。

考虑以下代码：

```java
class Employee{
    private Date hireDay;
    ...
    public Date getHireDay()
    {
        return hireDay;
    }
}
```

`hireDay` 是一个私有属性，而且 `Date` 类型的对象还是可变的。在一个方法中直接把一个私有属性的引用作为返回值，会导致外部通过这个引用可以直接修改对象的私有属性，违反了封装的要求。

如果想要返回一个私有的可变对象，应该首先对其进行 `克隆（clone）`。

示例代码：

```java
class Employee
{
    ...
    public Date getHireDay()
    {
        return (Date) hireDay.clone(); // 调用clone()方法
    }
    ...
}
```

## 基于类的访问权限

根据前边的知识我们知道一个方法如果被调用的话可以访问它的隐式参数的私有数据。但实际上，一个方法对它所属类的所有对象的私有数据都有访问权限。

考虑这个方法调用 `harry.equals(boss)`。`equals()` 方法不仅访问了 `harry` 的私有方法，同时也访问了 `boss` 的私有方法，就是因为一个方法它所在类的任何一个对象的私有域。

## `final` 实例域

可以将实例域定义为 `final`，同时，必须保证构造器在构造对象的时候必须对 `final` 实例域进行赋值，且在后面的操作中不能再对 `final` 的实例域进行修改。

`final` 修饰符大都应用于 `基本（primitive）` 类型，或 `不可变（immutable）` 类的域。



# 静态域与静态方法

## 静态域

可以通过 `static` 修饰符将一个域标记为 `静态域`，一个静态域属于一个类，不属于某一个具体的对象，即使这个类没有一个对象，这个静态域也存在。这个类的所有对象共享这个 `静态域`。

## 静态常量

`Math.PI` 就是一个静态常量

```java
public class Math
{
    ...
    public static final double PI = 3.14159265358979323846;
    ...
}
```

`System.out` 也是一个静态常量。它在 `System` 类中声明：

```java
public class System
{
    ...
    public static final PrintStream out = ...;
    ...
}
```

- 特殊情况：如果查看以下 `System` 类，就会发现有一个 `setOut()` 方法，它可以将`System.out` 设置为不同的流。读者可能会感到奇怪，为什么这个方法可以修改 `final` 变量的值。原因在于，`setOut()` 是一个 `native method` ，不是使用Java语言实现的，`native method` 可以绕过Java语言的存取控制机制。这是一种非常特殊的写法，自己编写程序的时候不要这样做。

## 静态方法

静态方法是一种不能向对象实施操作的方法。例如，`Math` 类的 `pow` 方法就是一个静态方法。也就是说，静态方法没有 `隐式参数`。

静态方法不能访问对象的 `实例域`。但是可以访问类的 `静态变量`。

即可以使用类名调用静态方法，也可以使用对象调用静态方法，但是通常情况下都使用类名调用静态方法，这样不容易使人混淆。

## 工厂方法

静态方法还有另外一个常见的用途，就是作为工厂方法。之前的 `LocalDate.now()` 和 `LocalDate.of()` 就是工厂方法。

另外，`NumberFormat` 类如下使用工厂方法生成不同风格的格式化对象：

```java
// Currency对象和Percent对象都是Decimal类型的对象，都是NumberFormat的子类。
NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();
NumberFormat percentFormatter = NumberFormat.getPercentInstance();
double x = 0.1;
System.out.println(currencyFormatter.format(x)); // prints $0.10
System.out.println(percentFormatter.format(x)); // prints 10%
```

为什么 `NumberFormat` 类不利用构造器完成这些操作呢？这主要有两个原因：

- 构造器只能得到一种类型的对象，但是这里希望得到两种不同的对象

- `NumberFormat` 的工厂方法返回一个 `DecimalFormat` 类型的对象，这个类型是 `NumberFormat` 的子类。



# 方法参数

方法调用主要分为两种类型：`传值调用（Call by value）` 和 `引用调用（Call by reference）`。

Java语言总是采用传值调用方式。也就是说方法得到的是所有参数值的一个拷贝，方法不能修改传递给它的任何参数变量的内容。

我们来看一种情况，对于

```java
class Employee{
    public static void tripleSalary(Employee x) //works
    {
        x.raiseSalary();
    }
}
```

如果调用

```java
harry = new Employee(...);
tripleSalary(harry);
```

这样确实可以改变 `harry` 的状态，这是否意味着Java也有引用调用的情况？

不是这样的，在这种情况下，Java仍然是传值调用，不过传递的是 `对象引用的拷贝`，这个拷贝和原来的对象引用指向相同的对象。



# 对象构造

## 重载 `Overloading`

一个类可以有多个同名的方法，只要这些方法具有不同的 `方法签名` 就可以。也就是说同名的方法只要没有顺序和类型完全相同的 `显式参数` 就可以。

Java允许重载任何方法。

## 默认域初始化

如果在构造器中没有显式地为域赋初值，那么就会被自动地赋为默认值：数值为 `0` ，布尔值为 `false`，对象引用为 `null`。

但非常不建议这么做，这不是一种良好的编程习惯。

## 无参数的构造器

如果在编写一个类的时候没有编写构造器，那么系统就会提供一个无参数构造器，这个构造器将所有的实例域设置为默认值。

但是只要你编写了自己的有参数构造器，系统将不会再提供无参数构造器，此时如果再尝试调用无参数构造器就会报错。

## 显式域初始化

可以在类定义的时候直接为实例域赋值。这样，当调用构造器的时候会先执行这些类定义中的赋值语句。

当一个类的所有构造器都希望把相同的值赋给某个特定的实例域时，这种方法可以起到精简代码的作用。例如：

```java
class Employee
{
    private static int nextId;
    private in id = assignId();
    ...
    private static int assignId()
    {
        int r = nextId;
        nextId++;
        return r;
    }
}
```

## 参数名

把一个方法的参数变量的名字和同样的实例域的名字设置为相同的，这是很常见的操作。这时在方法中使用 `this.xxx` 来引用实例域。

比如，假设 `Employee` 类有 `name` 和 `salary` 两个实例域。则：

```java
public Employee(String name, double salary)
{
    this.name = name;
    this.salary = salary;
}
```

这种形式的代码清晰易懂。

## 调用另一个构造器

在类的一个构造器中可以使用 `this` 关键字来调用另外一个构造器。比如：

```java
public Employee(double s)
{
    //calls Employee(String, double)
    this("Employee #" + nextId, s);
    nextId++;
}
```

当调用 `new Employee(60000)` 时，`Employee(double)` 构造器将调用 `Employee(String, double)`构造器。

采用这种方式使用 `this` 关键字非常有用，这样对公共的构造器代码部分只需编写一次。

## 初始化块

`初始化块` 