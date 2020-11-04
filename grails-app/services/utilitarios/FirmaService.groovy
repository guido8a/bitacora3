package utilitarios

import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.StampingProperties;
import com.itextpdf.signatures.BouncyCastleDigest;
import com.itextpdf.signatures.ICrlClient;
import com.itextpdf.signatures.DigestAlgorithms;
import com.itextpdf.signatures.IExternalDigest;
import com.itextpdf.signatures.IExternalSignature;
import com.itextpdf.signatures.IOcspClient;
import com.itextpdf.signatures.PdfSignatureAppearance;
import com.itextpdf.signatures.PdfSigner;
import com.itextpdf.signatures.PrivateKeySignature;
import com.itextpdf.signatures.ITSAClient
import com.itextpdf.signatures.CertificateInfo

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Security;
import java.security.cert.Certificate
import java.security.cert.X509Certificate;
import java.util.Collection;
import java.util.Properties;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import java.security.cert.Certificate;


class FirmaService {

    static transactional = false

    def sign(String src, String dest, Certificate[] chain, PrivateKey pk,
             String digestAlgorithm, String provider, PdfSigner.CryptoStandard subfilter,
             String reason, String location, Collection<ICrlClient> crlList,
             IOcspClient ocspClient, ITSAClient tsaClient, int estimatedSize)
            throws GeneralSecurityException, IOException {
        PdfReader reader = new PdfReader(src);
        PdfSigner signer = new PdfSigner(reader, new FileOutputStream(dest), new StampingProperties());
//
        def certificados = chain.size()
        String signedBy = CertificateInfo.getSubjectFields((X509Certificate) chain[certificados -1]).getField("CN");

//         Create the signature appearance
        Rectangle rect = new Rectangle(60, 10, 300, 100);
        PdfSignatureAppearance appearance = signer.getSignatureAppearance();
        appearance
                .setReason(reason)
                .setLocation(location)

        // Specify if the appearance before field is signed will be used
        // as a background for the signed field. The "false" value is the default value.
                .setReuseAppearance(false)
                .setPageRect(rect)
                .setPageNumber(1)
                .setLayer2FontSize(7)
                .setLayer2Text("Firmado por ${signedBy} texto asuministrado para que resulte demodelo de lo que se intenta incluir en la firma:");


        signer.setFieldName("sig");

        println "$pk, $digestAlgorithm, $provider, -->$signedBy"

        IExternalSignature pks = new PrivateKeySignature(pk, digestAlgorithm, provider);
        IExternalDigest digest = new BouncyCastleDigest();

        // Sign the document using the detached mode, CMS or CAdES equivalent.
        signer.signDetached(digest, pks, chain, crlList, ocspClient, tsaClient, estimatedSize, subfilter);
    }

    def haceLaFirma() {
        println "inicia la firma"
        File file = new File("/var/bitacora/firmas");
        file.mkdirs();

        Properties properties = new Properties();

        /* This properties file should contain a CAcert certificate that belongs to the user,
        * according to the original sample purpose. However right now it contains a simple
        * self-signed certificate in p12 format, which serves as a stub.
        */

        // Get path to the p12 file
//        String path = "/var/bitacora/francisco_fabian_paliz_osorio.p12"
        String path = "/var/bitacora/store.p12"
//        char[] pass = "FcoPaliz1959"
        char[] pass = "password"
        def arch_pdf = "/var/bitacora/municipio.pdf"
        def arch_salida = "/var/bitacora/firmas/salida.pdf"
        println "prop path: --> ${path}"

        // Get a password --> FcoPaliz1959
//        char[] pass = properties.getProperty("PASSWORD").toCharArray();

        BouncyCastleProvider provider = new BouncyCastleProvider();
        Security.addProvider(provider);

        // The first argument defines that the keys and certificates are stored using PKCS#12
        KeyStore ks = KeyStore.getInstance("pkcs12", provider.getName());
        ks.load(new FileInputStream(path), pass)

        println "ks: $ks"
        String alias = ks.aliases().nextElement()
        PrivateKey pk = (PrivateKey) ks.getKey(alias, pass)
        Certificate[] chain = ks.getCertificateChain(alias)

        println "alias: $alias, pk: $pk, chain: $chain"

        sign(arch_pdf, arch_salida, chain, pk,
                DigestAlgorithms.SHA256, provider.getName(), PdfSigner.CryptoStandard.CMS,
                "Test", "Quito", null, null, null, 0);
    }


}
