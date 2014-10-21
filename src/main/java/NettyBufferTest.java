import io.netty.buffer.*;

public class NettyBufferTest {

  private static Integer SIZE_OF_BUFFER = 42424242;

  public static void main(String[] args) throws Exception {
    ByteBuf bb = Unpooled.buffer();

    //bb = null;
    System.gc();
    while(true) {
      Thread.sleep(1000);
    }
  }
}
