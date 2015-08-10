import java.io.*;
import java.nio.*;

public class StdLibBufferTest {
  private static Integer SIZE_OF_BUFFER = 42424242;

  public static void main(String[] args) throws Exception {
    ByteBuffer buffer = ByteBuffer.allocateDirect(SIZE_OF_BUFFER);
    //ByteBuffer buffer = ByteBuffer.allocate(SIZE_OF_BUFFER);
    while (true) {
      Thread.sleep(2000);

      //buffer = null;
      //System.gc();
    }
  }
}
