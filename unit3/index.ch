〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 3〉 
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
    〈h1 Higher-Order Functions〉
    〈ul
      〈li In Scala, functions are values:
        〈pre
val triple = (x: Int) => 3 * x〉〉
      〈li The type of 〈 triple〉 is 〈 Int => Int〉〉
      〈li You can pass 〈 triple〉 to another function/method:
〈pre 1.to(10).map(〈strong triple〉)
  // yields 3 6 9 12 ... 30〉〉
        〈li 〈 map〉 is a 〈em higher-order function〉—it consumes a function〉
        〈li Another useful higher-order function is 〈 filter〉. It consumes a function 〈 T => Boolean〉
          〈pre
1.to(10).filter(〈strong (x: Int) => x % 2 == 0〉)
  // yields 2 4 6 8 10〉〉
      〈li Note that there was no need to store the function in a variable〉
      〈li We will soon see other higher-order functions that 〈em produce〉 functions〉        
      〉

    〈h1 Parameter Type Inference〉
    〈ul
    〈li When you define a function, you normally need to specify the parameter types:
      〈pre
val triple = (x 〈strong : Int〉) => 3 * x〉〉
      〈li The return type is inferred. The type is 〈 Int => 〈strong Int〉〉〉
      〈li The parameter type can often be inferred as well:
        〈pre
1.to(10).map((x) => 3 * x)
〉〉
      〈li Since 〈 1.to(10)〉 is a 〈 Seq[〈strong Int〉]〉, the type of 〈 x〉 is inferred to be 〈 Int〉〉
      〈li Bonus: You can drop the 〈 ()〉
        〈pre
1.to(10).map(x => 3 * x)〉〉
      〈li Super bonus: Since 〈 x〉 occurs exactly once, can drop 〈 x =>〉 and use 〈 _〉:
        〈pre
1.to(10).map(3 * _)〉〉
    〉

    〈h1 〈 reduce〉〉

    〈ul
      〈li 〈 s.reduce(f)〉 computes 〈 f(...f(f(s(0), s(1)), s(2))..., s(n-1))〉〉
      〈li Note that 〈 f〉 is a function with two arguments〉
      〈li 〈 1.to(100).reduce(〈strong _ + _〉)〉 is 1 + 2 + 3 + 4 + ... + 100 = 5050〉
      〈li 〈 s.reduce(〈strong (a, b) => if (a > b) a else b〉)〉 computes the maximum〉
    〉
    〈h1 What is the Value Of ...〉

      〈pre 1.to(100).map(_.toString).reduce(_ + _)
〉
      〈ol.clicker
        〈li The string 〈 "5050"〉〉
        〈li The string 〈 "1 2 3 ... 98 99 100"〉〉
        〈li A string of length 192〉
        〈li Something else (syntax error, other value, etc.)〉      
      〉

      〈h1 〈 flatMap〉〉

      〈li Given integer sequence 〈 s〉, easy to form all pairs (x, 0):
        〈pre
s.map(x => (x, 0))
    // Vector((1, 0), (2, 0), (3, 0), (4, 0))〉
      〉
      〈li What if we want to have all pairs (x, y) where x, y are elements of s?〉
      〈li Try it by calling 〈 map〉 twice:
        〈pre
s.map(y => 〈strong s.map(x => (x, y))〉)
  // Vector(Vector((1,1), (2,1), (3,1), (4,1)),
  //        Vector((1,2), (2,2), (3,2), (4,2)),
  //        Vector((1,3), (2,3), (3,3), (4,3)),
  //        Vector((1,4), (2,4), (3,4), (4,4)))〉〉
      〈li Close, but not quite. To “flatten out” the result, use 〈 flatMap〉 instead:
        〈pre
s.〈strong flatMap〉(y => s.map(x => (x, y)))
  // Vector((1, 1), (1, 2), (1, 3), (1, 4), (2, 1), (2, 2), ..., (4, 4)) 〉〉
    

    〈h1 Capturing the Enclosing Environment〉 
    〈ul  
      〈li Consider this function: 
        〈pre
val n = 3
val fun = (x : Int) => n * x
// What is fun(2)?〉 
      〉 
      〈li 〈 n〉 is not defined in the scope of 〈 fun〉, but that is ok. In the body of a function, you can use any variable from the enclosing scope.〉 
      〈li Doesn't seem a big deal—〈 n〉 is immutable, so it will always be 3. But consider this: 
        〈pre
def mulBy(n : Int) = (x : Int) => n * x〉 
      〉 
      〈li Huh? Let's call it: 
        〈pre
val quadruple = mulBy(4) // the function (x : Int) => 4 * x〉 
      〉 
      〈li And let's call 〈em that〉: 
        〈pre
quadruple(5) // yields 20〉 
      〉 
      〈li Each call to 〈 mulBy〉 yields a different function.〉 
      〈li Each function has a different value of 〈 n〉〉 
      〈li Closure = function + binding of its free variables (i.e the variables that are not defined locally in the function)〉
    〉

    〈h1 Where Did We Already Use Closures?〉

    〈ol.clicker
      〈li In the 〈 reduce〉 slide〉
      〈li In the 〈 flatMap〉 slide〉
      〈li In both〉
      〈li In neither〉
    〉
    
    〈h1 Lab〉

    〈p.sideimage 〈img src='../images/lab.jpg' alt='Scary looking lab'〉〉 
    〈ol  
      〈li You work with a buddy 〉 
      〈li One of you (the coder) writes the code, the other (the scribe) types up answers〉 
      〈li When you get stuck, ask your buddy first!〉 
      〈li Switch coder/scribe roles each lab〉 
      〈li The coder submits the worksheet. Include the scribe's name in the worksheet!〉
      〈li The scribe submits answers. Include the coder's name in the report!〉 
    〉 

    〈h1 Part 1: Life without Loops〉

    〈ol.la
      〈li Make a worksheet 〈 Day3〉. Type in 〈pre val zones = java.util.TimeZone.getAvailableIDs〉. What do you get?〉
      〈li We want to get rid of the continents. Try this:
        〈pre
zones.map(s => s.split("/"))
〉〉
      〈li Ok, halfway there. Add a map that takes an array and yields 〈 a(1)〉. What did you do? What happens?〉
      〈li Hmmm, that's weird. There seem to be arrays of length < 2. How can you find them?〉
      〈li Ok, now get rid of them and try again. What did you do?〉
      〈li That's a lot of values. Can we get every tenth of them? (Hint: 〈 grouped(10)〉)〉
      〉

      〈h1 Part 2: Reductions〉

    〈ol.la
      〈li Evaluate
      〈pre
1.to(10).reduce(_ * _)〉 What do you get?〉
      〈li Write a function that computes n! in this way.〉
      〈li Surely you have written a factorial function before. How did you used to do it? Which approach do you like better?〉
      〈li Now we'd like to compute 2〈sup 〈var n〉〉 with the same trick. How can you get a sequence of 〈 n〉 copies of the number 2? Hint: 〈 map〉.〉
      〈li What is your function that computes 2〈sup 〈var n〉〉?〉
      〈li Given a 〈 Seq[String]〉, how can you use 〈 reduce〉 to concatenate them with spaces in between? Write a function 〈 catSpace〉 that does this. For example, 〈 catSpace(Vector("Mary", "had", "a", "lamb"))〉 should give a string 〈 "Mary had a lamb"〉〉
      〈li What happens when you try 〈 1.to(10).reduce(_ < _)〉? Why?〉
    〉


    〈h1 Part 3: Fun with 〈 flatMap〉 and 〈 reduce〉〉

      〈p.sideimage 〈img src='phonepad.jpg'〉〉
      〈p Martin Odersky, the inventor of Scala (as well as the charming husband of one of your instructors) likes to show off the power of Scala with a solution of the “phone mnemonics” problem. Given a phone number, what word or word sequence spells it on a touch-tone pad? For example, given the phone number 435 569 6753, one should come up with the sequence 〈 HELLO WORLD〉 (and maybe others).〉
      〈p We can do better than what he did in his presentations. We'll solve this problem with our very restricted subset of Scala.〉
    〈ol
      〈li What interesting word can you make from the number 72252?〉
      〈li Declare a map that maps 〈 '2'〉 to 〈 "ABC"〉, 〈 '3'〉 to 〈 "DEF"〉, and so on. How do you do that? Pay attention that the keys should be characters and the values should be strings.〉
        〈li Actually, we want '2' to map to a 〈 Vector〉 with three elements, 〈 "A"〉, 〈 "B"〉, 〈 "C"〉. But we don't want to type all that by hand. Transform your map by adding
          〈pre
.map(e => (e._1, e._2.map(c => c.toString)))
〉
          Call the result 〈 letters〉—we'll need it in the next step.〉
        〈li Now it's trivial to find out the words that one can make with one digit. It's just 〈 letters(d)〉. Let's move on to two digits. Write a function that given two digits produces the set of all words (whether or not they make sense) that you can make with both.
          〈pre
val wordsFor = (a: Char, b: Char) => ...〉
          For example, 〈 wordsFor('5', '9')〉 contains "JW", "JX", "JY", "KW", "KX", "KY", "LW", "LX", "LY". Hint: 〈 flatMap〉〉
    〉
  〉
〉
