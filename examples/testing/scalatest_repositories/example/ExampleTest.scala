package examples.testing.scalatest_repositories.example

import org.scalatest.{FlatSpec, MustMatchers}

class ExampleTest extends FlatSpec with MustMatchers {
  "Exmaple" should "pass" in {
    println("test1")
    val byteBuffer = java.nio.ByteBuffer.allocate(2)
    byteBuffer.putChar('a')
    byteBuffer.flip()
    1 must be(0)
  }
}
