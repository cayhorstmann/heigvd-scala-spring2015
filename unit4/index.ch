〈!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"〉

〈html xmlns='http://www.w3.org/1999/xhtml'  
  〈head  
    〈meta content='text/html; charset=utf-8' http-equiv='content-type'〉 
    〈title Borran/Fatemi/Horstmann Scala Unit 4〉 
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
    〈h1 Writing a Higher-Order Function〉

    〈ul
      〈li Let's write a function that checks whether all elements of a 〈 Seq[Int]〉 fulfill a condition.〉
      〈li 〈pre val forall = (s: Seq[Int], p: 〈strong Int => Boolean〉) => ...〉〉
      〈li 〈 p〉 is a function parameter〉
      〈li 〈 forall(1.to(10), _ > 0)〉 should return 〈 true〉〉
      〈li 〈 forall(1.to(10), _ % 2 == 0)〉 should return 〈 false〉〉
      〈li We don't yet know how to do this efficiently, but we'll soldier on anyway:
        〈pre
... => s.map(p) ...〉
        is a sequence of 〈 true〉 or 〈 false〉〉
      〈li We don't want any of them to be 〈 false〉:
        〈pre
....filter(_ == false).length == 0〉〉
      〈li All together:
        〈pre
val forall = (s: Seq[Int], p: Int => Boolean) =>
  s.map(p).filter(_ == false).length == 0〉〉
    〉

    〈h1 What Does This Function Do?〉

    〈pre
val mystery = (s: Seq[Int], p: Int => Boolean) =>
  s.map(p).filter(_ != false).length > 0〉

    〈ol.clicker
      〈li It returns 〈 true〉 if all elements of 〈 s〉 fulfill the predicate 〈 p〉 〉
      〈li It returns 〈 true〉 if somel elements of 〈 s〉 fulfill the predicate 〈 p〉 〉
      〈li It returns 〈 true〉 if no elements of 〈 s〉 fulfill the predicate 〈 p〉 〉
      〈li Something else (none of the above, syntax error, etc.)〉
    〉
    
    
    〈h1 Background: Comparison Functions〉

    〈ul
      〈li  To sort by a general criterion, specify how to compare elements〉
      〈li In Scala, use a function 〈 comp(s, t)〉 that returns 〈 true〉 if 〈 s〉 should come before 〈 t〉〉
      〈li Different from C/Java (where a comparison function returns a value < 0, 0, > 0)〉
      〈li 〈pre val words = "Maria had a little lamb".split(" ")
words.sortWith(〈strong _ < _〉) // Maria, a, had, lamb, little
words.sortWith(〈strong (s, t) => s.length < t.length〉) // a, had, lamb, Maria, little
〉〉
      〈li What if we want to sort by the number of vowels?
        〈pre
val isVowel = (c: Char) => "aeiouAEUOU".contains(c)
val vowels = (s: String) => s.filter(isVowel).length〉〉
      〈li No problem:
        〈pre
words.sortWith(〈strong (s, t) => vowels(s) < vowels(t)〉)〉〉
      〈li That looks so similar to sorting by length. Can one avoid the repetition?〉
    〉

    〈h1 Returning a Function〉

      〈ul
        〈li Define a function that generates a comparator from a measurement (length, number of vowels, ...)
        〈pre
val compareBy = (measure: String => Int) => ...〉
      〉
      〈li Need to return a function 〈 (s: String, t: String) => ...〉〉
      〈li ...that checks that 〈 measure(s) < measure(t)〉〉
      〈li All together:
        〈pre
val compareBy = (measure: String => Int) =>
  (s: String, t: String) => measure(s) < measure(t)
〉〉
      〈li 〈pre
words.sortWith(〈strong compareBy(vowels)〉)
  // had, a, lamb, little, Maria〉〉
      〈li 〈pre
words.sortWith(〈strong compareBy(_.length)〉)〉〉
      〈li 〈 compareBy〉 consumes a function and produces a function〉
    〉

    〈h1 What Does 〈 mystery〉 Do?〉

    〈pre
val mystery = (
    comp1: (String, String) => Boolean,
    comp2: (String, String) => Boolean) =>
  (s: String, t: String) =>
    if (comp1(s, t)) true else
    if (comp1(t, s)) false
    else comp2(s, t)

words.sortWith(mystery((s, t) => s.length < t.length, _ < _))
〉
    
    〈ol.clicker
      〈li It yields a comparison function that uses 〈 comp2〉 to break ties if 〈 comp1〉 doesn't distinguish between 〈 s〉 and 〈 t〉〉
      〈li It yields a comparison function that considers 〈 s〉 less than 〈 t〉 if both 〈 comp1〉 and 〈 comp2〉 do〉
      〈li It yields a comparison function that considers 〈 s〉 less than 〈 t〉 if either 〈 comp1〉 or 〈 comp2〉 do〉      
      〈li Something else (none of the above, syntax error, etc.)〉
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

      〈h1 Part 1: Defining Higher-Order Functions〉

      〈ol.la
        〈li Look up the Scaladoc for the 〈 partition〉 method of 〈 Seq〉. You should implement an equivalent function that works for 〈 Seq[Int]〉.〉
        〈pre
val partition = (values: Seq[Int], p: Int => Boolean) => ...
〉
        〈li What result do you get for 〈 partition(1.to(10), _ % 3 == 1)〉?〉
        〈li Write a function 〈 rev〉 that reverses a comparator , so that, for example,
          〈pre
words.sortWith(〈strong rev(compareBy(vowels))〉) 〉
          yields the words with the most vowels first: 〈 Maria, little, lamb, had, a〉.
          〈pre
val rev = (comp: (String, String) => Boolean) => ...〉
          Hint: This is completely trivial, but it takes some practice to think about it. If the resulting function is 〈 rcomp〉, what is 〈 rcomp(s, t)〉? 〈br〉Still too hard? If 〈 comp(s, t) = s < t〉, what is 〈 rcomp(s, t)〉? (No, its not 〈 s > t〉 or 〈 s >= t〉 because in general, you can't peek into the body of the function.) 〉
          〈li What did you actually get for 〈 words.sortWith(rev(compareBy(vowels)))? 〉 In which order did the strings with one vowel appear? Why didn't their positions get reversed?〉
      〉
          
    
    〈h1 Part 2: Moving On with the Phone Mnemonics〉 
    〈p.sideimage 〈img src='../unit3/phonepad.jpg'〉〉
    〈p We continue the “phone mnemonics” from Unit 3.〉
    〈ol.li
      〈li Have a closer look at the implementation of 〈 wordsFor〉. Inside it, you should have code that solves a more general problem where you have two vectors of strings and get a sequence of all concatenations from both of them. Write a function
        〈pre
val cats = (s: Seq[String], t: Seq[String]) => ...〉 that does this in general.
      〈br〉Test case:
      〈pre
cats(Vector("Hello", "World"), Vector("Mary", "had", "fun"))〉〉
        〈li Now write a function 〈 wordsForDigits〉 that takes a string of digits between '2' and '9' and produces all strings that they can encode.
          〈pre
val wordsForDigits = (digits: String) => ...〉
          Hint: First map to a vector of strings for each digit. Then use reduce.〈br〉
      Test case: 〈 wordsForDigits("72252")〉〉      
        〈li Read in all words from 〈 /usr/share/dict/words〉, as we did before. For efficiency, let's put them into a set though. And remove those that start with an uppercase letter (which include a bunch of junk) as well as those of length 1. And let's make them all uppercase. And let's add in "SCALA" which is weirdly missing.
          〈pre
val words = io.Source.fromFile("/usr/share/dict/words").getLines.filter(w => Character.isLowerCase(w(0)) && w.length > 1).map(_.toUpperCase).toSet + "SCALA"〉
          Then improve the 〈 wordsForDigits〉 function from the preceding step by filtering against the set.〉
        〈li Now when you run 〈 wordsForDigits("72252")〉, what do you get? What do you get for  〈 wordsForDigits("72253")〉?〉
        〉
    〈h1 Part 3: Multiple Words〉
        〈ol.la
          〈li 〈p We've made a lot of progress, but we aren't quite there. The problem is a little harder. Given an arbitrary number like 7225247386, one is supposed to find the words "SCALA", "IS", "FUN" (and whatever other words there might be hidden).〉
            〈p Let's assume we have a particular way of breaking up the numbers, say into 〈 Vector("72252", "47", "386")〉. Using 〈 wordsForDigits〉, we get all the words for 〈 "72252"〉, 〈 "47"〉, and 〈 "386"〉. Now we want to concatenate them into a sentence.〉
            〈p We've 〈em almost〉 solved that problem before, when 〈 wordsForDigits〉 reduced with 〈 cats〉 to glue together words. Give it a try:
              〈pre
val wordsForDigitsSequence = (seq: Vector[String]) =>
  seq.map(e => wordsForDigits(e)).reduce(cats)〉
              〈p What do you get for 〈 wordsForDigitsSequence(Vector("72252", "47", "386"))?〉〉
            〉
          〉
          〈li 〈p It would be easier to read the result if the words were separated by spaces. Make a copy of 〈 cats〉, call it 〈 catsSpaces〉, and make it separate the concatenated words by spaces. Then call 〈 catsSpaces〉 instead of 〈 cats〉 in 〈 wordsForDigitsSequence〉. What do you now get for 〈 wordsForDigitsSequence(Vector("72252", "47", "386"))?〉〉
          〉
          〈li 〈p We are doing good. 〈em If〉 we know how to break up a number (such as 7225247386) into all corresponding sequences (such as 72252 47 386), then we can find the corresponding words for each sequence.〉〉〉

    〈h1 Part 4: Breaking Up Is Hard to Do〉
    〈p.sideimage 〈img src='../unit3/breaking-up.jpg'〉〉
    
    〈ol.la
      〈li        
            〈p Let's find all ways that digits can be broken up into sequences. For example, the digits 1234 have 8 such decompositions: 1234, 12 34, 1 234, 1 2 34, 123 4, 12 3 4, 1 23 4, 1 2 3 4.〉
        〈p That looks pretty random, but it's not so bad. Suppose you knew how to break up 123 (into 123, 12 3, 1 23, 1 2 3). Now you augment that with 4. There are two things you can do:〉
          〈ul
            〈li Add 4 all by itself: 123 〈strong 4〉, 12 3 〈strong 4〉, 1 23 〈strong 4〉, 1 2 3 〈strong 4〉〉
            〈li Add 4 to the last element: 123〈strong 4〉, 12 3〈strong 4〉, 1 23〈strong 4〉, 1 2 3〈strong 4〉〉
          〉
        〈p Let's do the first part. 〉
        〈pre
val augment1 = (a: Vector[Vector[String]], t: Char) => ...〉
        〈p For each sequence 〈 s〉 in 〈 a〉, you concatenate  (with 〈 ++〉) the sequence 〈 Vector(t.toString)〉. 〉
        〈p Test case:〉
        〈pre augment1(Vector(Vector("123"),
  Vector("12", "3"),
  Vector("1", "23"),
  Vector("1", "2", "3")),
  '4')〉〉                
      〈li 〈p On to 〈 augment2〉. There are two inputs: a 〈 Vector[Vector[String]]〉 such as 〈 Vector(Vector("123"), Vector("12", "3"), Vector("1", "23"), Vector("1", "2", "3"))〉, and a character such as 〈 '4'〉 to glue to the last element of each sequence.〉
        〈pre
val augment2 = (a: Vector[Vector[String]], t: Char) => ...〉
        〈p For each sequence 〈 s〉 in 〈 a〉, you concatenate (with 〈 ++〉) all but the last element, followed by a 〈 Vector(s.last + t)〉
          〈p Test case: 〉
          〈pre augment2(Vector(Vector("123"),
  Vector("12", "3"),
  Vector("1", "23"),
  Vector("1", "2", "3")),
  '4')〉〉〉
      〈li 〈p Now define〉
        〈pre
val augment = (a: Vector[Vector[String]], t: Char) => ...〉
        〈p to concatenate 〈 augment1(a, t)〉 and 〈 augment2(a, t)〉 (with 〈 ++〉). 〉
        〈p Test case: 〈pre augment(Vector(Vector("123"),
  Vector("12", "3"),
  Vector("1", "23"),
  Vector("1", "2", "3")),
    '4')〉〉
      〉
      〈li 〈p What is the result of〉 〈pre augment(augment(augment(Vector(Vector("1")), '2'), '3'), '4')〉〉
      〈li 〈p This looks 〈strong so〉 promising. But why can't use use 〈 augment〉 with 〈 reduce〉?〉〉
    〉
    〈p Breaking up is hard to do. You'll have to wait until the next lecture to complete this puzzle.〉

      〈h1 Homework〉
      〈p Do this as 〈em individual work〉, not with your partner〉
      〈p When all done, email the signed zip files to Fatemeh.Borran@heig-vd.ch〉
      〈ul
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw2a Problem 1〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw2b Problem 2〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw2c Problem 3〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw2d Problem 4〉〉
        〈li 〈a href=http://cs14.cs.sjsu.edu:8080/codecheck/files?repo=heigvdcs1&problem=hw2e Problem 5〉〉
      〉    
  〉 
〉
