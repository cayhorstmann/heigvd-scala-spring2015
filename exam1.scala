object exam1 {

  def divisors(n: Int) = (1 to n).filter(n % _ == 0).toSet
  //> divisors: (n: Int)scala.collection.immutable.Set[Int]

  def divisorsOfAny(numbers: Set[Int]): Set[Int] =
    numbers flatMap divisors //> divisorsOfAny: (numbers: Set[Int])Set[Int]
  divisorsOfAny(Set(10, 12, 18)) //> res0: Set[Int] = Set(5, 10, 1, 6, 9, 2, 12, 3, 18, 4)

  def divisorsOfAll(numbers: Set[Int]): Set[Int] = numbers.tail.map(divisors).foldLeft(divisors(numbers.head))(_ & _)
  //> divisorsOfAll: (numbers: Set[Int])Set[Int]

  abstract class Node {
    def toXML: String = this match {
      case Text(c)    => c
      case Elem(t, c) => s"<$t>${c.map(_.toXML).mkString}</$t>"
    }
    def toXML2: String;
  }

  case class Text(content: String) extends Node {
    def toXML2: String = content
  }

  case class Elem(tag: String, children: List[Node]) extends Node {
    def toXML2: String = s"<$tag>${children.map(_.toXML).mkString}</$tag>"
  }

  val sample1 = Elem("body", List(Text("Hello, World")))
  //> sample1  : exam.Elem = Elem(body,List(Text(Hello, World)))
  sample1.toXML //> res1: String = <body>Hello, World</body>

  sample1.toXML2 //> res2: String = <body>Hello, World</body>

  def doThisAndMaybeThat(f1: String => String, f2: String => Boolean, f3: String => String) =
    (x: String) => { val r = f1(x); if (f2(r)) f3(r) else r }
  //> doThisAndMaybeThat: (f1: String => String, f2: String => Boolean, f3: String
  //|  => String)String => String
  val f = doThisAndMaybeThat(s => s.replace("a", ""), s => s.length <= 5,
    s => s.toUpperCase) //> f  : String => String = <function1>
  f("macadamia") //> res3: String = MCDMI
  f("mustard") //> res4: String = mustrd

  def genericDoThisAndMaybeThat[A, B, C <: B](f1: A => B)(f2: B => Boolean)(f3: B => C) =
    (x: A) => { val r = f1(x); if (f2(r)) f3(r) else r }
  //> genericDoThisAndMaybeThat: [A, B, C <: B](f1: A => B)(f2: B => Boolean)(f3:
  //|  B => C)A => B

  val f5 = genericDoThisAndMaybeThat(
    (s: String) => s.replace("a", ""))(s => s.length <= 5)(s => s.toUpperCase)
  //> f5  : String => String = <function1>
  println(f5("macadamia")) //> MCDMI
  println("Expected: MCDMI") //> Expected: MCDMI
  println(f5("mustard")) //> mustrd
  println("Expected: mustrd") //> Expected: mustrd

  val f3 = genericDoThisAndMaybeThat((x: Int) => Seq(1, x))(p => p(1) == 2)(p => 1 to 2)
  //> f3  : Int => Seq[Int] = <function1>

  println(f3(2)) //> Range(1, 2)
  println("Expected: Range(1, 2)") //> Expected: Range(1, 2)
  println(f3(3)) //> List(1, 3)
  println("Expected: List(1, 3)") //> Expected: List(1, 3)

  case class Student(studentId: Int, name: String, firstname: String)
  case class Grade(studentId: Int, courseId: String, grade: Int)
  val students: Set[Student] = Set(
    Student(1, "Pit", "Brad"),
    Student(2, "Cage", "Nicolas"),
    Student(3, "Winslet", "Kate"),
    Student(4, "Hanks", "Tom"),
    Student(5, "Dicaprio", "Leonardo"),
    Student(6, "Portman", "Nathalie"),
    Student(7, "Kidman", "Nicole")) //> students  : Set[exam.Student] = Set(Student(5,Dicaprio,Leonardo), Student(6
  //| ,Portman,Nathalie), Student(3,Winslet,Kate), Student(2,Cage,Nicolas), Stude
  //| nt(4,Hanks,Tom), Student(1,Pit,Brad), Student(7,Kidman,Nicole))
  val grades: Set[Grade] = Set(
    Grade(1, "SCALA", 5),
    Grade(2, "SCALA", 4),
    Grade(3, "SCALA", 6),
    Grade(4, "SCALA", 3),
    Grade(6, "SCALA", 1),
    Grade(1, "POO", 4),
    Grade(2, "POO", 6),
    Grade(3, "POO", 3),
    Grade(4, "POO", 4),
    Grade(7, "POO", 4)) //> grades  : Set[exam.Grade] = Set(Grade(1,POO,4), Grade(2,SCALA,4), Grade(2,P
  //| OO,6), Grade(6,SCALA,1), Grade(3,POO,3), Grade(4,POO,4), Grade(3,SCALA,6), 
  //| Grade(4,SCALA,3), Grade(7,POO,4), Grade(1,SCALA,5))

  for (s <- students; g <- grades if (s.studentId == g.studentId)) yield (s.name, g.courseId, g.grade)
  //> res5: scala.collection.immutable.Set[(String, String, Int)] = Set((Cage,SCA
  //| LA,4), (Kidman,POO,4), (Portman,SCALA,1), (Cage,POO,6), (Hanks,SCALA,3), (P
  //| it,SCALA,5), (Winslet,POO,3), (Pit,POO,4), (Winslet,SCALA,6), (Hanks,POO,4)
  //| )
  val result = Set(("Cage", "SCALA", 4), ("Kidman", "POO", 4), ("Portman", "SCALA", 1), ("Cage", "POO", 6), ("Hanks", "SCALA", 3), ("Pitt", "SCALA", 5), ("Winslet", "POO", 3), ("Pitt", "POO", 4), ("Winslet", "SCALA", 6), ("Hanks", "POO", 4))
  //> result  : scala.collection.immutable.Set[(String, String, Int)] = Set((Cage
  //| ,SCALA,4), (Kidman,POO,4), (Portman,SCALA,1), (Cage,POO,6), (Pitt,POO,4), (
  //| Hanks,SCALA,3), (Winslet,POO,3), (Pitt,SCALA,5), (Winslet,SCALA,6), (Hanks,
  //| POO,4))

  for ((a, b) <- result.groupBy(_._2)) yield (a, b.map(_._1))
  //> res6: scala.collection.immutable.Map[String,scala.collection.immutable.Set[
  //| String]] = Map(SCALA -> Set(Portman, Winslet, Pitt, Hanks, Cage), POO -> Se
  //| t(Winslet, Kidman, Pitt, Hanks, Cage))
}
