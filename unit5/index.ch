〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 5〉 
    〈link type='text/css' rel='stylesheet' media='screen, projection, print' href='http://www.w3.org/Talks/Tools/Slidy2/styles/slidy.css'〉 
    〈link type='text/css' rel='stylesheet' media='screen, projection, print' href='../MySlidy/style.css'〉 
    〈script src='http://www.w3.org/Talks/Tools/Slidy2/scripts/slidy.js.gz' charset='utf-8' type='text/javascript'〉 
    〈script src='https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full' type='text/javascript'〉
  〉 
  〈body  
    〈h1 Programmation appliquée en Scala〉
    〈p.fullimage 〈img src='../images/cheseaux.jpg'〉〉
    〈div.license  
      〈p Copyright © Cay S. Horstmann 2014 〈a href='http://creativecommons.org/licenses/by/4.0/' rel='license'  〈img src='https://i.creativecommons.org/l/by/4.0/88x31.png' style='border-width:0' alt='Creative Commons License'〉〉〈br〉This work is licensed under a 〈a href='http://creativecommons.org/licenses/by/4.0/' rel='license'  Creative Commons Attribution 4.0 International License〉
      〉
    〉

    〈h1 Currying〉 
    〈p.sideimage 〈img src=haskell-curry.jpg alt=''〉〉 
    〈ul  
      〈li Currying = Turning a function that takes two arguments into a function that takes one argument. That function returns a function that consumes the second argument. (Named after the logician Haskell Brooks Curry)〉 
      〈li Huh?〉 
      〈li Simple example: 
        〈pre
def mul(x : Int, y : Int) = x * y
mul(3, 4) is 12
def mul2(x : Int)(y : Int) = x * y
mul2(3)(4) is 12〉 
      〉 
      〈li What is 〈 mul2(3)〉? 〉 
      〈li A function that is capable of eating 4, thus yielding 12〉 
      〈li 〈 y : Int => 3 * y〉〉 
    〉 

    〈h1 What Is ...〉
    〈pre
(1 to 10).map(mul2(5))〉
    〈ol.clicker
      〈li A syntax error—the argument to 〈 map〉 must be a function〉
      〈li A 〈 Range〉 containing 〈 5 10 15 20 ... 50〉〉
      〈li A 〈 Vector〉 containing 〈 5 10 15 20 ... 50〉〉
      〈li A 〈 Vector〉 containing 〈 10 20 30 40 ... 100〉〉
    〉

    〈h1 Application of Currying: Type Inference〉

    〈ul
      〈li 〈 Seq[A].corresponds(t: Seq[B])(p: (A, B) => Boolean)〉 checks whether two sequences have “corresponding” elements, as defined by 〈 p〉〉
      〈li For example,
      〈pre
val s = "Mary had a little lamb".split(" ")
val t = Array(4, 3, 1, 6, 4)
s.corresponds(t)((a: String, b: Int) => a.length == b)
〉〉
      〈li Or more concisely
      〈pre
s.corresponds(t)(_.length == _)〉〉
      〈li Why the currying
      〈pre
s.corresponds(t)〈strong (_.length == _)〉〉〉
      〈li Otherwise, type inference wouldn't work. The type of 〈 t〉 is needed to infer the type 〈 B〉〉
    〉

    〈h1 Folding〉 
    〈ul  
      〈li The product of the elements in 〈 Vector(a, b, c)〉 is 
        〈p 〈 a * b * c = 1 * a * b * c = ((1 * a) * b) * c〉〉 
      〉 
      〈li Use 〈 foldLeft〉:
        〈pre
def prod(lst: Vector[Int]) = lst.foldLeft(1) (_ * _)〉 
        〈pre
      *
     / \
    *   c
   / \
  *   b
 / \
1   a〉 
      〉 
      〈li The first argument of the folding function is the partial answer; the second is the new list value to be considered〉 
      〈li The 〈 foldRight〉 operator works right-to-left: 〈 a * (b * (c * 1))〉
      〈ul
        〈li That's useful for right-associative operators (e.g. list construction)〉
      〉〉 
    〉 

    〈h1 What Is ...〉
    〈pre
(1 to 10).foldLeft("")(_ + _)〉

    〈ol.clicker
      〈li 〈 "12345678910"〉〉
      〈li 〈 "10987654321"〉〉
      〈li 55〉
      〈li Something else (syntax error, other result, ...)〉
    〉
    
    〈h1 More about Folding〉

    〈ul
      〈li We could have computed a sum with 〈 reduce〉〉
      〈li But 〈 reduce〉 only works with operators 〈 (A, A) => A〉〉
      〈li 〈 foldLeft〉 works with any operator 〈 (B, A) => B〉〉
      〈li Remember this from the last lab?
      〈pre
augment(augment(augment(〈strong Vector(Vector("1"))〉, '2'), '3'), '4')〉〉
      〈li We couldn't use 〈 reduce〉 because 〈 augment〉 takes arguments of different types
      〈pre
val augment = (a: Vector[Vector[String]], t: Char) => ...〉〉
      〈li It's easy with 〈 foldLeft〉—see lab〉
    〉
    〈h1 Folding and Recursive Functions〉
    〈ul
      〈li 〈em Any〉 recursive definition of the form
        〈p `f(n) = {(s , if n = 0),(t(f(n - 1), n) , if n > 0):}`〉
      can be computed with a fold.
      〈pre
(1 to n).foldLeft(s)(t)〉〉
      〈li Example: Factorial (`s = 1`, `t = \_ * \_`)
      〈p `n! = {(1 , if n = 0),((n - 1)! * n , if n > 0):}`〉〉
      〈li Example: Subsets of `{ 1 ... n }`
      〈p `S(n) = {({} , if n = 0),(S(n - 1) ∪ { s ∪ {n} | s ∈ S(n - 1) } , if n > 0):}`〉〉
    〉

    〈h1 Folding and Accumulation〉

    〈ul
      〈li Task: Get letter frequencies of a string

      〈ul
        〈li E.g. 〈 "Mississippi"〉 → 〈 Map(M -> 1, i -> 4, s -> 4, p -> 2)〉 〉
      〉〉
      〈li Can update a mutable map of counters—but not with our Scala subset ☺〉
      〈li How about an immutable map? Produce a new map in each step
      〈pre
                .
               .
              .
             op
            / \
           op 's'
          / \
         op 'i'
        / \
empty map 'M'
〉〉
      〈li What is 〈 op〉?
      〈pre
(m, c) => m + (c -> (m.getOrElse(c, 0) + 1))〉〉
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

    〈h1 Part 1: Currying〉 
    〈ol.la
      〈li Here is a function of computing the “maximum” string in a list that works for any ordering. 
        〈pre
def max(lst : Seq[String], less : (String, String) => Boolean) =
  lst.reduce((x, y) => if (less(x, y)) y else x)〉 
        〈p Make a call to 〈 max〉 that yields the longest string in a sequence of strings. 〈em Important: 〉Use 〈 _〉 for the string parameters in your 〈 less〉 function. 〉 
      〉 
      〈li Now we'll make this generic. Don't worry—it won't hurt a bit: 
        〈pre
def max〈b [T]〉(lst : Seq〈b [T]〉, less : (〈b T〉, 〈b T〉) => Boolean) =
    lst.reduce((x, y) => if (less(x, y)) y else x)〉 
        〈p What happens when you call 〈 max(lst, _ < _)?〉〉 
      〉 
      〈li Ok, that didn't work so well. Currying to the rescue. Curry the 〈 max[T]〉 function, exactly like 〈 mul2〉 above. What is the code for your revised function? What happens when you call 〈 max2(lst)(_ < _)〉? 
      〉
      〈li Why does the second approach work with 〈 _〉 parameters?〉
    〉 

    〈h1 Part 2. Known When To Fold〉
    〈ol.la
      〈li How do you compute `n!` with a fold?
      〈pre
val fac = (n: Int) => ...〉〉
      〈li Now on to those subsets where your eyes probably glazed over. We want 〈 subsets(2)〉 to be 〈 Vector(Vector(), Vector(1), Vector(〈b 2〉), Vector(1, 〈b 2〉))〉. How do you get that out of 〈 subsets(1)〉, i.e. 〈 Vector(Vector(), Vector(1))〉?〉
      〈li Ok, what's that in Scala? You are given a vector of vectors 〈 s〉 and an integer 〈 n〉, and you want 〈 s〉 together with the sequence obtained by adding 〈 n〉 to all elements of 〈 s〉. Write a function that does that, and test it.〉
      〈li Now write 〈 subsets〉 by using 〈 foldLeft〉.〉
      〈li Complete and test the 〈 letterFrequencies〉 function from the last slide before the lab. What do you get for 〈 letterFrequencies("Mississippi")〉?〉
    〉
    
    〈h1 Part 3. Finish Phone Mnemonics 〉
    〈p.sideimage 〈img src='../unit3/phonepad.jpg'〉〉

    〈ol.la
      〈li Last time, we got stuck with repeatedly calling 〈 augment〉 to get all ways of breaking up a string into substrings. For example, here are all substrings of 〈 "1234"〉
      〈pre
augment(augment(augment(Vector(Vector("1")), '2'), '3'), '4')〉
      Get last week's worksheet from your buddy and copy over all you need to today's worksheet.〉
      〈li Now we want this to work for arbitrary strings, not just 〈 "1234"〉. Of course, we want to use 〈 foldLeft〉 with 〈 augment〉. What is the seed value? And to what sequence do you apply 〈 foldLeft〉?〉
      〈li Implement 〈 val substrings = (s: String) => ...〉. What is 〈 substrings("2728")〉?〉
      〈li Note that's a vector of 〈 Vector[String]〉. The shining achievement of last week's lab was the function 〈 wordsForDigitSequence〉 that found all words for such a sequence. What do you get when you call
      〈pre
substrings("2728").map(wordsForDigitSequence)〉〉
      〈li Ok, that's not quite what we want. How do you fix it?〉
      〈li Now implement 〈 val phoneMnemonics = (digits: String) => ...〉 that does this for any string of digits, not just 〈 "2728"〉. What is 〈 phoneMnemonics("7225247386")〉? (You can change the cutoff limit of the worksheet in the preferences to see all solutions.)〉
    〉
  〉
〉
