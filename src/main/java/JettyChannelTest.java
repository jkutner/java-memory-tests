import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.nio.SelectChannelConnector;

import org.eclipse.jetty.http.MimeTypes;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;

public class JettyChannelTest  {

  public static void main(String[] args) throws Exception
  {
    int port = 8080;

    Server server = new Server();

    Connector connector = new SelectChannelConnector();
    connector.setPort(port);
    server.addConnector(connector);

    server.start();

    while (true) {
      Thread.sleep(2000);
      System.out.println("sleeping...");
    }
  }
}
