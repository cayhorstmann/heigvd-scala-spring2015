〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 1〉 
    〈link type='text/css' rel='stylesheet' media='screen, projection, print' href='http://www.w3.org/Talks/Tools/Slidy2/styles/slidy.css'〉 
    〈link type='text/css' rel='stylesheet' media='screen, projection, print' href='../MySlidy/style.css'〉 
    〈script src='http://www.w3.org/Talks/Tools/Slidy2/scripts/slidy.js.gz' charset='utf-8' type='text/javascript'〉 
  〉 
  〈body  

    〈h1 Programmation appliquée en Scala〉
    〈p.fullimage 〈img src='../images/cheseaux.jpg'〉〉
    〈div.license  
      〈p Copyright © Cay S. Horstmann 2014 〈a href='http://creativecommons.org/licenses/by/4.0/' rel='license'  〈img src='https://i.creativecommons.org/l/by/4.0/88x31.png' style='border-width:0' alt='Creative Commons License'〉〉〈br〉This work is licensed under a 〈a href='http://creativecommons.org/licenses/by/4.0/' rel='license'  Creative Commons Attribution 4.0 International License〉
      〉
    〉 

    
    〈h1 Why Scala?〉 
    〈p.sideimage 〈img src='scala_logo.png' alt=''〉〉 
    〈ul  
      〈li Multi-paradigm language〉
      〈li Object-oriented and functional〉
      〈li Statically typed〉
      〈li Scalable from simple scripts to sophisticated (but still easy-to-use) libraries〉
      〈li Invented by Martin Odersky at EPFL〉 
      〈li Works with Java VM tools/libraries/infrastructure〉
      〈li Used for big-iron projects in industry〉
      〈li Pragmatic choice as successor to Java (whose evolution has slowed to a crawl)〉
      〈li Expands your mind and makes you think differently about programming in any language〉
    〉

    〈h1 About the Course〉

    〈ul
      〈li Meets Monday 13:00 - 16:25〉
      〈li Lecture/Lab/Break/Lecture/Lab〉
      〈li Short lectures/long labs〉
      〈li You can ask questions/write reports in English or French〉
      〈li Course/exams: 40%, labs/homeworks: 30%, project: 30%〉
    〉

    〈h1 What is the Most Important Skill...〉
    〈p ...that HEIG-VD computer science graduates wish they had learned better in college?〉
    〈ol.clicker
      〈li Object-Oriented Programming〉
      〈li Functional Programming〉
      〈li Programming Projects〉
      〈li Giving Presentations in English〉
    〉
    
    〈h1 Do You Already Know Some Scala?    〉
      〈ol.clicker
        〈li No〉
        〈li Just a little〉
        〈li I am reasonably fluent〉
        〈li I am an expert〉
      〉

    〈h1 Scala Basics〉 
    〈ul  
      〈li Types 〈 Int〉, 〈 Double〉, 〈 Boolean〉, 〈 String〉〉 
      〈li Arithmetic like in C++/Java: 〈 + - * / %〉〉 
      〈li Variable type is inferred: 
        〈pre
val luckyNumber = 13 // luckyNumber is an 〈strong Int〉〉 
      〉 
      〈li Function types: 
        〈pre
val square = (x: Int) => x * x // square is an 〈strong Int => Int〉〉 
      〉 
      〈li Semicolons at the end of a line are optional 
        〈pre
val x = 1
val y = 2 + // end line with operator to indicate that there is more to come
3〉 
      〉 
      〈li Everything is an object 
        〈pre
1.〈strong to〉(10) // Apply 〈strong to〉 method to 1, returns Range(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)〉 
      〉
    〉

    〈h1 Map〉
    〈ul
      〈li 〈 1.to(10)〉 yields a 〈 Range〉〉
      〈li Collections 〈 List〉, 〈 Vector〉 (similar to C++), 〈 Range〉, many more〉 
      〈li 〈 map〉 works on any collection 
        〈pre
val square = (x: Int) => x * x 
1.to(9).map(square)
  // Yields 1 4 9 16 25 ... 81〉〉
      〈li Applies function to all elements and yields collection of results〉
      〈li 〈a href='http://mathworld.wolfram.com/QuadraticResidue.html' What is〉
        〈pre
1.to(9).map(square).map(x => x % 10).distinct〉〉
      〈li No 〈 ()〉 behind 〈 distinct〉. Rule of thumb: no args and not mutating ⇒ no 〈 ()〉〉
      〈li How many lines of code would this take in C++?〉
    〉 

    〈h1 Functional Programming〉 
    〈ul  
      〈li Functional programming: Functions are values〉 
      〈li In C++, values are 
        〈ul  
          〈li Primitive types 〈 int〉, 〈 double〉, etc.〉 
          〈li Structure/class values〉 
          〈li Pointers〉 
        〉 
      〉 
      〈li A function is not a “first class” value in C++ 
        〈ul  
          〈li Cannot create new functions in a running program〉 
        〉 
      〉 
      〈li In a functional programming language, functions are first-class values 
        〈ul  
          〈li Can have variables that hold functions〉 
          〈li Can create new functions〉 
        〉 
      〉 
    〉 

    〈h1 Functional Programming in Scala〉 
    〈ul  
      〈li Functions can be values 
        〈pre
val num = 3.14
val fun = math.ceil _
fun(num) // prints 4〉 
      〉 
      〈li Functions can be anonymous... 
        〈pre
(x: Int) => x * x〉 
      〉 
      〈li ...just like numbers 
        〈pre
3.14〉 
      〉 
      〈li Of course, can put function values into variables and then use them 
        〈pre
val square = 〈strong (x: Int) => x * x〉
square(10) // prints 100〉 
      〉 
      〈li ...again, just like numbers 
        〈pre
val pi = 3.14
pi * 10 // prints 31.4〉 
      〉 
    〉 

    〈h1 Why Functional Programming?〉 
    〈ul  
      〈li Simpler and clearer programming style〉 
      〈li Often useful to pass functions as parameters 
        〈pre
val numbers = Vector(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
numbers.map(〈strong (x: Int) => x * x〉)
   // Prints Vector(1, 4, 9, 16, 25, 36, 49, 64, 81, 100)〉 
      〉 
      〈li In C++, you can also do this, but there are no anonymous functions. 
        〈pre
vector<int> map(vector<int> values, 〈strong int (*f)(int)〉) {
   vector<int> result;
   for (int i = 0; i < size; i++) result.push_back(f(values[i]));
   return result;
}
int square(int x) { return x * x; }
 ...
res = map(numbers, 〈strong square〉); // Must pass name of function〉 
      〉 
      〈li In Scala, but not in C++, a function can produce a new function〉 
    〉 

    〈h1 Immutability〉 
    〈ul  
      〈li Immutable: Cannot change〉 
      〈li In Java, strings are immutable 
        〈ul  
          〈li 〈 "Hello".toUpper()〉 doesn't change 〈 "Hello"〉 but returns a new string 〈 "HELLO"〉〉 
        〉 
      〉 
      〈li In Scala, 〈 val〉 are immutable 
        〈pre
val num = 3.14
num = 1.42 // Error〉 
      〉 
      〈li Pure functional programming: No mutations〉 
      〈li Don't mutate—always return the result as a new value〉 
      〈li Functions that don't mutate state are inherently parallelizable〉 
      〈li Important consideration in light of the end of 〈a href='http://www.intel.com/technology/mooreslaw/index.htm'  Moore's Law〉〉 
    〉 

    〈h1 Lab〉 
    〈p.sideimage 〈img src='../images/lab.jpg' alt='Scary looking lab'〉〉 
    〈ul  
      〈li Format of classes: approx. 20 minutes lecture, 40 minutes lab, 15 minutes wrap-up 〉 
      〈li You work with a buddy 〉 
      〈li One of you (the coder) writes the code, the other (the scribe) types up answers〉 
      〈li When you get stuck, ask your buddy first!〉 
      〈li Switch coder/scribe roles each lab〉
      〈li The coder submits worksheet to Fatemeh.Borran@heig-vd.ch. Include the scribe's name in the worksheet!〉
      〈li The scribe submits answers to Fatemeh.Borran@heig-vd.ch. Include the coder's name in the report!〉 
    〉 

    〈h1 Part 1: The Scala Worksheet〉 
    〈ol.la  
      〈li Start the Scala IDE and make a new Scala project: File -> New -> Scala Project. Give a name 〈 Worksheets〉. Right-click on the project in the Package Explorer, then select New -> Scala Worksheet. Call it 〈 Day1〉.〉 
      〈li Make a new line before the 〈!-- { --〉〈 }〉 . Type 〈 6 * 7〉 and then save (Ctrl+S/⌘+S). What do you get?〉 
      〈li Edit the line to read 〈 val a = 6 * 7〉 and save. What do you get?〉 
      〈li Add 〈 a〉. What do you get? 〉 
      〈li Add 〈 a = 43〉. What do you get? Why?〉 
      〈li Remove that line and add 〈 val b;〉 (This time with a semicolon.) What do you get? Why?〉
      〈li Now remove that line.〉
    〉 

    〈h1 Part 2: Functions are Values〉 
    〈ol.la  
      〈li Add 〈 val triple = (x: Int) => 3 * x〉. What do you get? 〉 
      〈li Add 〈 triple(5)〉. What do you get? 
        〈blockquote  
          〈p Tip: These “What do you get” exercises are a lot more enjoyable and effective when you and your buddy first discuss what you think you'll get before you execute the Save command.〉 
        〉 
      〉 
      〈li Add 〈 triple〉. What do you get?〉 
      〈li What is the type of 〈 triple〉 in Scala?〉 
      〈li What is the type of 〈 5〉 in Scala?〉 
    〉 

    〈h1 Part 3: Functions as Parameters〉 
    〈ol.la  
      〈li Type 〈 1.to(10)〉. What do you get?〉 
      〈li Type 〈 1.to(10).map(triple)〉. What do you get? Why? 〉 
      〈li How do you get the cubes of the numbers from 1 to 10? 〉 
      〈li How do you get the cubes of the numbers from 1 to 10 〈em without using 〉〈 val〉? Hint: Anonymous functions〉
    〉
    〈h1 Part 4: Quadratic Residues (Extra Credit)〉
    〈ol.la
      〈li 〈p Do you remember this?〉
        〈pre
0.to(9).map(square).map(x => x % 10).distinct〉
        〈p Try it out. What did you get?〉       
      〉
      〈li These are called the “quadratic residues modulo 10”—the values that are squares of some value in { 0...9 }.〉
      〈li What are the quadratic residues modulo 11? Modulo 16?〉
      〈li Modulo 〈 n〉? Write a function 〈 val qres = (n: Int) => ... 〉 that produces them. What is your function? What is 〈 qres(20)〉?〉
      〈li For 〈 n〉 going from 2 to 20, how many quadratic residues are there?
        〈p Hint: 〈 2.to(20).map(...)〉 and 〈 map(l -> l.length)〉〉
      〉
      〈li Did you get it right? Check against the table in 〈a href='http://mathworld.wolfram.com/QuadraticResidue.html' this page〉. In that table, 0 is not considered a quadratic residue, so your counts should be one higher.〉
      〈li What would it have taken to do this in C++?〉
    〉
  〉
〉
