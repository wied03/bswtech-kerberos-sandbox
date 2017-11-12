import org.apache.http.auth.AuthSchemeProvider
import org.apache.http.auth.AuthScope
import org.apache.http.auth.Credentials
import org.apache.http.client.config.AuthSchemes
import org.apache.http.client.methods.CloseableHttpResponse
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.protocol.HttpClientContext
import org.apache.http.client.utils.URIBuilder
import org.apache.http.config.RegistryBuilder
import org.apache.http.impl.auth.SPNegoSchemeFactory
import org.apache.http.impl.client.BasicCredentialsProvider
import org.apache.http.impl.client.HttpClients
import java.security.Principal
import org.apache.http.util.EntityUtils

class Client {
  static void main(String[] args) {
        def uriBuilder = new URIBuilder(args[0])
        // if the port does not match the Kerberos database entry, skip it during the lookup
        def skipPortAtKerberosDatabaseLookup = true
        def registry = RegistryBuilder.<AuthSchemeProvider> create()
                .register(AuthSchemes.SPNEGO, new SPNegoSchemeFactory(skipPortAtKerberosDatabaseLookup))
                .build()
        def client = HttpClients.custom().setDefaultAuthSchemeRegistry(registry).build()
        def context = HttpClientContext.create()
        def credsProvider = new BasicCredentialsProvider()
        def useJaasCreds = new Credentials() {
            @Override
            Principal getUserPrincipal() {
                return null
            }

            @Override
            String getPassword() {
                return null
            }
        }
        credsProvider.setCredentials(new AuthScope(null, -1, null), useJaasCreds)
        context.credentialsProvider = credsProvider
        def get = new HttpGet(uriBuilder.build())
        def response = client.execute(get, context)
        try {
            println "got status ${response.statusLine}"
            println "got response ${EntityUtils.toString(response.entity)}"
        }
        finally {
            response.close()
        }
  }
}
