〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 2〉 
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
    〈h1 Conditional Expressions〉
    〈ul  
      〈li 
        〈pre
if (〈var booleanExpression〉) 〈var expression1〉 else 〈var expression2〉〉 
      〉 
      〈li if/else is an 〈var expression〉, not a statement. Can be used in other expressions: 
        〈pre
val y = (〈strong if (x >= 0) 2 else 0〉) - 1〉 
      〉 
      〈li Like 〈 ? :〉 in C++〉 
      〈li Type is the most specific supertype common to 〈var expression1〉, 〈var expression2〉 
        〈pre
val z = if (condition) 3 else "Hello"
   // type is Any〉 
      〉 
      〈li Omitting the 〈 else〉 yields a value of type 〈 Unit〉 if 〈 condition〉 is 〈 false〉 (like 〈 void〉 in C++)〉 
    〉 

    〈h1 Vectors〉

    〈ul
      〈li Immutable array 〉
      〈li Random access 〈 v(i)〉〉
      〈li 〈 Vector.fill(n)(e)〉 yields a new vector with 〈 n〉 copies of 〈 e〉 〈pre val v = Vector.fill(10)("Bonjour")〉〉
      〈li 〈 v.updated(i, e)〉 yields a new vector with 〈 e〉 at position 〈 i〉〈pre
val v2 = v.updated(9, "Adieu")〉〉
      〈li More common, bulk transformation with 〈 map〉
      〈pre
v2.map(s => s.toLowerCase)〉〉
      〈li Can also pass expression yielding a value to 〈 fill〉
      〈pre
Vector.fill(10)(math.random)〉〉
      〈li 〈 Vector.iterate(s, n)(f)〉 computes the vector with elements 〈 s〉, 〈 f(s)〉, 〈 f(f(s))〉, ...
      〈pre
Vector.iterate("Bonjour", 8)(s => s.drop(1))〉〉
    〉

    〈h1 What is the Value of... 〉
    〈pre
"Fred".toVector.map(c => 'a' <= c && c <= 'z')〉
    〈ol.clicker
      〈li 〈 Vector('F', 'r', 'e', 'd')〉〉
      〈li 〈 Vector('r', 'e', 'd')〉〉
      〈li 〈 Vector(false, true, true, true)〉〉
      〈li Something else (other value, syntax error, ...)〉
    〉

    〈h1 Maps〉
    〈p.sideimage 〈img src='desert-island.jpg'〉〉

    〈ul
      〈li 〈em If I were stranded on a desert island and could only take one data structure with me, it would be the hash table.〉 — Peter van der Linden〉
      〈li Construct a map 〈pre val scores = Map("Alice" -> 10, "Bob" -> 3, "Cindy" -> 8)〉〉
      〈li Access element
      〈pre
val alicesScore = scores("Alice")
   // They don't call it a map for nothing
val fredsScore = scores.getOrElse("Fred", 0)〉〉
      〈li Update map (i.e. get new map with updates)
〈pre
val newScores = scores + ("Bob" -> 10, "Fred" -> 7)
val newerScores = newScores - "Alice" // Remove key and value〉
      〉
    〉
   
    〈h1 Tuples〉


    〈ul
      〈li Heterogeneous sequence of elements
      〈pre
val myFirstTuple = (1, 3.14, "Fred")〉〉
      〈li Tuple type 〈 (Int, Double, String)〉〉
      〈li Access components with methods 〈 _1〉 (!), 〈 _2〉, 〈 _3〉
      〈pre
val second = myFirstTuple._2〉〉
      〈li Or with destructuring
      〈pre
val (first, second, _) = myFirstTuple〉〉
      〈li 〈 ->〉 operator makes pairs. 〈 "Alice" -> 10〉 is the same as 〈 ("Alice", 10)〉〉
      〈li A map is a collection of pairs.
      〈pre
scores.map(p => (p._2, p._1))
scores.map(p => { val (x, y) = p; (y, x) })
   // Can't destructure parameter directly
〉〉
      
    〉

    〈h1 What is 〈 result〉...〉
    〈p ...where〉
    〈pre
val words = "Mary had a little lamb".split(" ").toVector
val result = words.map(w => w -> w.length).toMap〉
    〈ol.clicker
      〈li A 〈 Vector[(String, Int)]〉〉
      〈li A 〈 Vector[String => Int]〉〉      
      〈li A 〈 Map[String, Int]〉〉
      〈li Something else (other type, syntax error, ...)〉
    〉

    〈h1 Scaladoc〉
    〈p.fullimage 〈img src='scaladoc.png'〉〉

    〈h1 Scaladoc Tips〉

    〈ul
      〈li At 〈a href='http://www.scala-lang.org/api/2.11.4/' http://www.scala-lang.org/api/2.11.4/〉〉
      〈li Tip: Download the docs from 〈a href='http://scala-lang.org/download/2.11.4.html' the bottom of this site〉 and install on your laptop〉
      〈li Use the search filter in the top left corner〉
      〈li Whoa! So many methods!!! Just skip the ones that don't make sense〉
      〈li C = class (instance methods), O = object (like Java/C++ “static” methods)〉
      〈li Operators are at the top of each page. Exception: 〈 apply〉 is the 〈 ()〉 operator, 〈 unary_-〉 is what you think it is.〉
      〈li 〈 GenSeq〉? 〈 TraversableLike〉? 〈 FilterMonadic〉??? Just think “some stuff for collections” and move on.〉
      〈li 〈 implicit〉 means there is an automatic conversion. Ignore.〉
      〈li Also look into 〈 RichInt〉, 〈 RichDouble〉, 〈 StringOps〉 for numbers and strings〉
      〈li Math functions are in the 〈em package〉 〈 scala.math〉〉
    〉

    
    〈h1 Lab〉 
    〈p.sideimage 〈img src='../images/lab.jpg' alt='Scary looking lab'〉〉 
    〈ul  
      〈li Format of classes: approx. 20 minutes lecture, 40 minutes lab, 15 minute wrap-up 〉 
      〈li You work with a buddy 〉 
      〈li One of you (the coder) writes the code, the other (the scribe) types up answers〉 
      〈li When you get stuck, ask your buddy first!〉 
      〈li Switch coder/scribe roles each lab〉 
      〈li The coder submits worksheet to Fatemeh.Borran@heig-vd.ch. Include the scribe's name in the worksheet!〉
      〈li The scribe submits answers to Fatemeh.Borran@heig-vd.ch. Include the coder's name in the report!〉 
    〉 

    〈h1 Part 1: If Expressions〉

    〈ol
      〈li Make a worksheet 〈 Day2〉. Paste in
      〈pre
if (math.random > 0.5) "Bonjour" else "Adieu"〉 and save. What do you get?〉
      〈li Paste it in a couple more times. What do you get?〉
      〈li Make a vector with ten results of that call. (Not by pasting it 10 times, of course.)〉
      〈li Given a sequence of integers, produce a sequence of tuples 〈 (n, 0)〉 if 〈 n〉 is positive and 〈 (0, -n)〉 if 〈 n〉 is negative. Test with 〈 -10.to(10)〉.〉
      〈li Write a function that yields 1 if 〈 x > 0〉 , 0 if 〈 x〉 equals 0, and 〈 -1〉 if 〈 x < 0〉. Complete 〈 val sign = ...〉 and then call 〈 -10.to(10).map(sign)〉.〉
      〈li 〈strong Do not use any constructs that weren't covered!〉 For example, don't use 〈 def〉 in the preceding assignment.〉
    〉

    〈h1 Part 2: Strings are Sequences Too〉

    〈ol.la
      〈li What is 〈 "Fred"(2)〉? Why?〉
      〈li How can you turn it into 〈 "Free"〉? That is, what call yields a new string with characters 〈 'F' 'r' 'e' 'e'〉? (Hint: Don't use 〈 substring〉, but look at the title of the slide.)〉
      〈li How can you reverse a string?       〈strong Tip:〉 Don't hesitate to experiment in the worksheet. That's what it's there for. Type 〈 "Bonjour".rev〉 and hit Ctrl Space. What happens?〉
      〈li Does that method work for other sequences too? Experiment with 〈 1.to(10)〉. What happens?〉
      〈li Does 〈 distinct〉 work with strings? What does it do? Give an example.〉
      〈li What about 〈 map〉? Give an example.〉
      〈li How do you remove the last character of a string? Hint: You saw earlier how to drop the first character. Look up the Scaladoc of 〈 StringOps〉.〉
    〉
    
    

    〈h1 Part 3: Fun with Vectors〉

    〈ol.la
      〈li What is
      〈pre
val words = io.Source.fromFile("/usr/share/dict/words").getLines().toVector〉
      (If you get an exception that you don't have 〈 /usr/share/dict/words〉, then first save the contents of 〈a href='https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt' this link〉 somewhere and change the location to something like 〈 "C:\\Users\\Yourname\\Downloads\\words.txt"〉.)〉
      〈li How many words are in it? (Try out the obvious, or look into Scaladoc.)〉
      〈li What is the median entry? Or the two median ones if the length was even.〉
      〈li What are the distinct word lengths? (Go back to lab 1 if you need a hint.)〉
      〈li Which ones have maximum length? (Hint: Check out the Scaladoc for 〈 filter〉.) 〉
      〈li More filtering. Find all palindromes (i.e. strings that equal their reverse). Hint: In Scala, you compare strings with 〈 ==〉.〉
      〉

    
    〈h1 Part 4: Misery with Tuples〉 
    〈ol.la
      〈li What is 〈 1 -> 2 -> 3〉? What is the type of the result?〉 
      〈li Write a function 〈 flatten〉 that takes such a thing and turns it into an 〈 (Int, Int, Int)〉. Use 〈 _1〉, 〈 _2〉〉
      〈li Repeat with destructuring.〉
      〈li What is the result of the following statement, and why?
      〈pre
val x,y,z = (1,2,3)〉〉
    〉
    〈h1 Part 5: If I Had Just One Data Structure... 〉 
    〈ol.la  
      〈li And if I could just take one method, it would be 〈 groupBy〉. What is 〈 words.groupBy(w => w.length)〉?〉
      〈li Make a map so that 〈 myMap('a')〉 yields all words that start with the letter a and so on.〉
      〈li How many words start with a given letter? Hint: 〈 myMap.map(...)〉〉
      〈li Extra credit: Turn this into a list of tuples that is sorted by frequency. Hint: 〈 sorted〉 doesn't work because Scala doesn't know how to sort the tuples. There are two other 〈 sort〉 methods. One of them wants a function that maps into something that Scala does know how to sort—the easy choice for solving this exercise.〉
        〈li Extra credit: Now do it with the other method (and some tuple misery).〉
      〉
      〈h1 Homework〉
      〈p Do this as 〈em individual work〉, not with your partner〉
      〈p When all done, email the signed zip files to Fatemeh.Borran@heig-vd.ch〉
      〈ul
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1a Problem 1〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1b Problem 2〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1c Problem 3〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1d Problem 4〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1e Problem 5〉〉
                〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw1f Problem 6〉〉
      〉
  〉
〉
