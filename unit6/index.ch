〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 6〉 
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

    〈h1 〈 def〉〉

    〈ul
      〈li So far, we always used 〈 val〉 to define functions
      〈pre
val triple = (x: Double) => 3 * x〉〉
      〈li It is more common to use def:
        〈pre
def triple(x: Double) = 3 * x〉
       〉
      〈li Caution: If 〈 def〉 isn't followed by 〈 =〉, you are defining a function returning 〈 ()〉
      〈pre
def triple(x: Double) { 3 * x } // Returns ()!
〉〉
      〈li With recursive functions, must specify return type
      〈pre
def fac(n: Int)〈b :Int〉 = ...〉〉
    〉
    
    〈h1 Laziness〉 
    〈p.sideimage 〈img src=couch-potato.jpg alt=''〉〉 
    〈ul  
      〈li Laziness = only doing what is necessary, at the latest possible moment〉
      〈li Example: “short-circuit evaluation” of 〈 &&〉, 〈 ||〉
      〈pre
if (i < s.length && s(i) == '.')〉〉
      〈li Can we write such an operation?
      〈pre
def and(a: Boolean, b: Boolean) = if (!a) false else b〉〉
      〈li No, that doesn't work:
      〈pre
val s = "Hello"
val i = 5
if (and(i < s.length, 〈b s(i) == '.'〉))
  // Throws IndexOutOfBoundsException〉〉
    〉

    〈h1 By-Name Parameters〉

    〈ul
      〈li When a parameter of a function (declared with 〈 def〉) is prefixed by 〈 =>〉, it is not evaluated when the function is called.
      〈pre
def and(a: 〈b => 〉Boolean, b: 〈b => 〉Boolean) = if (!a) false else b〉〉
      〈li When calling
      〈pre
and(〈b i < s.length〉, 〈b s(i) == '.'〉)〉
      〈 and〉 receives two functions 〈 () => { i < s.length }〉, 〈 () => { s(i) == '.' }〉〉
      〈li When the parameters 〈 a〉 and 〈 b〉 are evaluated, the functions are called
      〈pre
if (!〈b a〉) ... // Calls () => { i < s.length }〉〉
    〉

    〈h1 Let's define if/else〉
    〈p Which of these will work? We want to call
    〈pre
ifElse(i < 5, println("Hi"), println("Bye"))〉〉
    〈ol.clicker
      〈li
      〈pre
def ifElse(c: Boolean, a: Unit, b: Unit) {
  c && { a; true } || { b; true } }〉〉
      〈li       〈pre
def ifElse(c: Boolean, a: => Unit, b: => Unit) {
  c && { a; true } || { b; true } }〉〉
      〈li 
      〈pre
def ifElse(c: => Boolean, a: => Unit, b: => Unit) {
  c && { a; true } || { b; true } }〉〉
      〈li None of these will work〉
    〉
    〈h1 〈 lazy val〉〉
    〈ul
      〈li When a 〈 val〉 is declared 〈 lazy〉, its initialization is deferred until the first time it is used.
      〈pre
lazy val words = scala.io.Source.fromFile("/usr/share/dict/words").mkString
  // Evaluated the first time words is used
〉〉
      〈li If 〈 words〉 is never used, the file is not opened.〉
      〈li Halfway between 〈 val〉 and 〈 def〉:
      〈pre
val words = scala.io.Source.fromFile("/usr/share/dict/words").mkString
  // Evaluated as soon as words is defined
def words = scala.io.Source.fromFile("/usr/share/dict/words").mkString
  // Evaluated every time words is used
〉〉
      〈li Implemented with hidden flag that is tested whenever 〈 words〉 is used〉
    〉

    〈h1 Streams〉

    〈ul
      〈li A stream is an immutable list whose tail is computed lazily.
      〈pre
def numsFrom(n: Int): Stream[Int] = Stream.cons(n, numsFrom(n + 1))
val ns = numsFrom(10) // Stream(10, ?)〉〉
      〈li Already computed values are cached:
      〈pre
ns(3) // 13
ns // Stream(10, 11, 12, ?)〉〉
      〈li 〈 map〉 is lazy—can apply to infinite stream
      〈pre
val squares = numsFrom(0).map(x => x * x) // Stream(0, ?)
squares(1000) // 1000000
〉〉
      〈li Can get a stream for a file—only reads the lines that are needed:
      〈pre
val words = Source.fromFile("/usr/share/dict/words").getLines.toStream
words.find(s => s.length >= 5 && s == s.reverse) // civic
〉〉
    〉

    〈h1 What Does This Stream Produce?〉
    〈pre
lazy val mystery: Stream[String] = Stream.cons("*", mystery.map(_ + "*"))〉
    〈ol.clicker
      〈li 〈 * * * * ...〉〉
      〈li 〈 * ** *** **** ...〉〉
      〈li 〈 * ** * ** * ** ...〉〉
      〈li Something else (syntax error, other result, ...)〉
    〉

    〈h1 Lazy Views〉

    〈ul
      〈li The 〈 view〉 method makes any sequence lazy—subsequent operations are only executed as needed.
      〈pre
val squares = (0 until 1000).view.map(x => x * x)〉〉
      〈li No squares are yet computed〉
      〈li Operations are executed as needed
      〈pre
val n = squares(100) // Now 100 * 100 is executed〉〉
      〈li Unlike streams, views don't cache any results〉
      〈li Can cascade unevaluated operations
      〈pre
val palindromicSquares = (1 to 1000000).view
  .map(x => x * x)
  .filter(x => x.toString == x.toString.reverse)
〉〉
      〈li Nothing is yet computed. Call 〈 force〉 to force evaluation.
      〈pre
palindromicSquares.take(5).force
  // Vector(1, 4, 9, 121, 484)〉〉
    〉
    
    〈h1 Lab〉

    〈p.sideimage 〈img src='../images/lab.jpg' alt='Scary looking lab'〉〉 
    〈ul  
      〈li You work with a buddy 〉 
      〈li One of you (the coder) writes the code, the other (the scribe) types up answers〉 
      〈li When you get stuck, ask your buddy first!〉 
      〈li Switch coder/scribe roles each lab〉 
      〈li The coder submits the worksheet. Include the scribe's name in the worksheet!〉
      〈li The scribe submits answers. Include the coder's name in the report!〉 
    〉

    〈h1 Part 1: Do-It-Yourself 〈 while〉〉

    〈ol.la
      〈li You've seen how to implement an if/else statement in Scala. Now we want to do the same with 〈 while〉. We have two arguments, the condition and the body. For example,
      〈pre
val iter = Source.fromFile("/usr/share/dict/words").getLines.buffered
  // "buffered" gives you an iterator with a "head" method for lookahead
While(〈b iter.head.length < 15〉, 〈b iter.next〉)
val longWord = iter.head // The first word of length >= 15
〉
How do you declare 〈 While〉? (Just the header, not the implementation.)〉
      〈li Now on with the implementation. If the condition is true, execute the body. Then call the function recursively. What do you get when running the code snippet above?〉
      〈li It's a little ugly. Make it so that you can call
      〈pre
While(iter.head.length < 15) { iter.next }〉Hint: Curry〉      
    〉

    〈h1 Part 2: How Lazy Is It?〉

    〈ol
      〈li Contrast
      〈pre
val bad1 = scala.io.Source.fromFile("/bad").mkString
lazy val bad2 = scala.io.Source.fromFile("/bad").mkString
def bad3 = scala.io.Source.fromFile("/bad").mkString
〉 When does an exception occur in each of these three cases? (Assuming that you don't have a file 〈 /bad〉.)〉
      〈li Spy on the 〈 squares〉 stream in the “Streams” slide by using the function
      〈pre
x => { println("Squaring " + x) ; x * x}〉 in the call to 〈 map〉. What happens when you call 〈 squares(10)〉? What happens when you call it again?〉
      〈li Now do the same with the 〈 squares〉 lazy view in the “Lazy Views” slide. What happens when you call 〈 squares(10)〉? What happens when you call it again?〉
      〈li Repeat for the 〈 palindromicSquares〉 view. What happens when calling 〈 palindromicSquares.take(4).force〉? Why?〉
    〉
    
    
    〈h1 Part 3: Lazy Fib〉

    〈ol
      〈li Write a function 〈 sum〉 that computes a stream that is the sum of two 〈 Stream[Int]〉.
      〈pre
def sum(a: Stream[Int], b: Stream[Int]) ...〉〉
      〈li What is 〈 sum(numsFrom(0), numsFrom(1))〉?〉
      
      〈li Of course, you know the Fibonacci series
      〈pre
1 1 2 3 5 8 13 21 ...〉 Now watch this:
      〈pre
  1
    1 1 2 3 5 8 13 21 ...
+     1 1 2 3 5  8 13 ...
  =====================
  1 1 2 3 5 8 13 21 34 ... 
〉
      So, you can make a sequence fibs that starts with 1 1 and then yield the sum of fibs.tail and fibs. Do this with a stream:
      〈pre
lazy val fibs: Stream[Int] = Stream.cons(1, Stream.cons(..., ...))〉
      What is 〈 fibs(46)〉?
      〉
      〈li Now consider the more traditional definition
      〈pre
def fib(n: Int): Int = if (n <= 2) 1 else fib(n - 1) + fib(n - 2)〉
      What is 〈 fib(46)〉?〉
      〈li This function gives the time for executing a function call:
      〈pre
def time(t: => Unit) = { val start = System.nanoTime(); t; System.nanoTime() - start }〉
        What exactly does the 〈 time〉 function do?〉
      〈li What are
      〈pre
time(fib(46))   
time(fibs(46))〉
      Why is one of them a lot slower?〉
    〉
    〈h1 Homework〉
      〈p Do this as 〈em individual work〉, not with your partner〉
      〈p When all done, email the signed zip files to Fatemeh.Borran@heig-vd.ch〉
      〈ul
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw3a Problem 1〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw3b Problem 2〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw3c Problem 3〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw3d Problem 4〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw3e Problem 5〉〉
    〉
  〉
〉
