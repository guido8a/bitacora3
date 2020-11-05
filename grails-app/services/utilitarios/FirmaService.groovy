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
import com.itextpdf.signatures.SignatureUtil
import com.itextpdf.signatures.PdfPKCS7

import com.itextpdf.text.DocumentException
import com.itextpdf.text.Image
import com.itextpdf.text.pdf.AcroFields
import com.itextpdf.text.pdf.PdfAcroForm
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfDictionary
import com.itextpdf.text.pdf.PdfDocument
import com.itextpdf.text.pdf.PdfImage
import com.itextpdf.text.pdf.PdfIndirectObject
import com.itextpdf.text.pdf.PdfName
import com.itextpdf.text.pdf.PdfSignature
import com.itextpdf.text.pdf.PdfSignatureAppearance

//import com.itextpdf.text.pdf.PdfSignatureAppearance
import com.itextpdf.text.pdf.PdfStamper
import com.itextpdf.text.pdf.PdfString
import com.itextpdf.text.pdf.security.BouncyCastleDigest
import com.itextpdf.text.pdf.security.CertificateInfo
import com.itextpdf.text.pdf.security.DigestAlgorithms
import com.itextpdf.text.pdf.security.ExternalDigest
import com.itextpdf.text.pdf.security.ExternalSignature
import com.itextpdf.text.pdf.security.MakeSignature
//import com.itextpdf.text.pdf.security.PdfPKCS7
import com.itextpdf.text.pdf.security.PrivateKeySignature

import com.itextpdf.text.pdf.security.SignaturePermissions
import sun.security.x509.X509CertInfo

import javax.naming.ldap.LdapName
import javax.security.auth.x500.X500Principal

//import com.itextpdf.text.pdf.PdfSignatureAppearance

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
//import org.bouncycastle.cert.ocsp.BasicOCSPResp;

import java.security.cert.Certificate;


class FirmaService {

    static transactional = false

//    def sign(String src, String dest, Certificate[] chain, PrivateKey pk,
//             String digestAlgorithm, String provider, PdfSigner.CryptoStandard subfilter,
//             String reason, String location, Collection<ICrlClient> crlList,
//             IOcspClient ocspClient, ITSAClient tsaClient, int estimatedSize)
//            throws GeneralSecurityException, IOException {
//        PdfReader reader = new PdfReader(src);
//        com.itextpdf.text.pdf.PdfReader r1 = new com.itextpdf.text.pdf.PdfReader(src)
//        PdfSigner signer = new PdfSigner(reader, new FileOutputStream(dest), new StampingProperties());
////
//        def certificados = chain.size()
//        String signedBy = CertificateInfo.getSubjectFields((X509Certificate) chain[certificados -1]).getField("CN");
//        println("nombre: " + CertificateInfo.getSubjectFields(chain[0]).getField("CN"))
//
////         Create the signature appearance
//        Rectangle rect = new Rectangle(60, 10, 300, 100);
//        PdfSignatureAppearance appearance = signer.getSignatureAppearance();
//        appearance
//                .setReason(reason)
//                .setLocation(location)
//
//        // Specify if the appearance before field is signed will be used
//        // as a background for the signed field. The "false" value is the default value.
//                .setReuseAppearance(false)
//                .setPageRect(rect)
//                .setPageNumber(1)
//                .setLayer2FontSize(7)
//        .setLayer2Text("Firmado por ${signedBy} texto asuministrado para que resulte demodelo de lo que se intenta incluir en la firma:");
//
//        signer.setFieldName("sig");
//
//        Image image = Image.getInstance("/var/bitacora/firmas/logo.png");
////        Image image = Image.getInstance("/var/bitacora/firmas/gatos2.jpg");
//
//        PdfImage stream = new PdfImage(image, "", null);
//        PdfStamper stamper = new PdfStamper(r1, new FileOutputStream(dest))   ;
////        def pdfContentByte = stamper.getOverContent(1);
////        image.setAbsolutePosition(1, 1);
////        pdfContentByte.addImage(image);
////        stamper.close();
//
////        PdfContentByte content = stamper.getUnderContent(1);
////        image.setAbsolutePosition(10, 10);
////        content.addImage(image);
//
//        PdfIndirectObject ref = stamper.getWriter().addToBody(stream);
//        image.setDirectReference(ref.getIndirectReference());
//        image.setAbsolutePosition(0, 0);
//        PdfContentByte over = stamper.getOverContent(1);
//        over.addImage(image);
//        stamper.close();
//
////        println("------ " + image)
//
//       println "$pk, $digestAlgorithm, $provider, -->$signedBy"
//
//        IExternalSignature pks = new PrivateKeySignature(pk, digestAlgorithm, provider);
//        IExternalDigest digest = new BouncyCastleDigest();
//
//        // Sign the document using the detached mode, CMS or CAdES equivalent.
//        signer.signDetached(digest, pks, chain, crlList, ocspClient, tsaClient, estimatedSize, subfilter);
//    }

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

//        sign(arch_pdf, arch_salida, chain, pk,
//                DigestAlgorithms.SHA256, provider.getName(), PdfSigner.CryptoStandard.CMS,
//                "Test", "Quito", null, null, null, 0);

        sign(arch_pdf, arch_salida, chain, pk,
                DigestAlgorithms.SHA256, provider.getName(), MakeSignature.CryptoStandard.CMS,
                "Test", "Quito");
    }



    public void sign(String src  //The path of the pdf file to be signed
                     , String dest  // The pdf file path of the signed chapter
                     , Certificate[] chain //Certificate chain
                     , PrivateKey pk //Sign private key
                     , String digestAlgorithm  //Digest algorithm name, such as SHA-1
                     , String provider  // Key algorithm provider, can be null
                     , MakeSignature.CryptoStandard subfilter //Digital signature format, itext has 2 types
                     , String reason  //The reason for the signature, displayed in the pdf signature attribute, just fill in
                     , String location) //The location of the signature, displayed in the pdf signature properties, just fill in
            throws GeneralSecurityException, IOException, DocumentException {
        //The steps below are fixed, just follow the instructions, there is nothing to explain
        // Creating the reader and the stamper, start pdfreader
        com.itextpdf.text.pdf.PdfReader reader = new com.itextpdf.text.pdf.PdfReader(src)
//        PdfReader reader = new PdfReader(src)
        //Target file output stream
        FileOutputStream os = new FileOutputStream(dest);
        //Create a signature tool PdfStamper, the last boolean parameter
        //If false, the pdf file is only allowed to be signed once, signed multiple times, and the last one is valid
        //If true, the pdf can be added to the signature, and the signature verification tool can identify whether the document has been modified after each signature
//        PdfStamper stamper = PdfStamper.createSignature(reader, os, '\0', null, true);
        Character ad = '\0'
//        String signedBy = CertificateInfo.getSubjectFields((X509Certificate) chain[0]).getField("CN");
        def certificados = chain.size()
        String signedBy = CertificateInfo.getSubjectFields(chain[certificados -1]).getField("CN");
        PdfStamper stamper = PdfStamper.createSignature(reader, os, ad)
        // Get the digital signature attribute object and set the attributes of the digital signature
        PdfSignatureAppearance appearance = stamper.getSignatureAppearance();
        appearance.setReason(reason);
        appearance.setLocation(location)
//        appearance.setReuseAppearance(true);
//        appearance.setLayer2FontSize(7)
        appearance.setLayer2Text("Firmado por ${signedBy} texto asuministrado para que resulte demodelo de lo que se intenta incluir en la firma:");
        //Set the location of the signature, the page number, and the name of the signature domain. When the signature is added multiple times, the signature pre-name cannot be the same
        //The position of the signature is the position coordinate of the stamp relative to the pdf page, the origin is the lower left corner of the pdf page
        //The four parameters are: the lower left corner of the stamp x, the lower left corner of the stamp y, the upper right corner of the stamp x, and the upper right corner of the stamp y
        appearance.setVisibleSignature(new com.itextpdf.text.Rectangle(10, 55, 200, 100), 1, "sig1");
        //Read the stamp image, this image is the image of the itext package
        Image image = Image.getInstance("/var/bitacora/firmas/logo.png");
//        image.setInverted(true)
        appearance.setSignatureGraphic(image)
        appearance.setCertificationLevel(PdfSignatureAppearance.NOT_CERTIFIED);
        //Set the display mode of the stamp. The following option is to display only the stamp (there are other modes, and the stamp and the signature description can be displayed together)
        appearance.setRenderingMode(PdfSignatureAppearance.RenderingMode.GRAPHIC_AND_DESCRIPTION);

        // Here itext provides 2 interfaces for signing, which can be implemented by yourself, and I will focus on this implementation later
        // Summary algorithm
        ExternalDigest digest = new BouncyCastleDigest();
        // signature algorithm
        ExternalSignature signature = new PrivateKeySignature(pk, digestAlgorithm, null);
        // Call itext signature method to complete the pdf signature
        MakeSignature.signDetached(appearance, digest, signature, chain, null, null, null, 0, subfilter);
    }




//    public PdfPKCS7 verifySignature(SignatureUtil signUtil, String name) throws GeneralSecurityException {
//
//        PdfPKCS7 pkcs7 = signUtil.readSignatureData(name);
//
//        return pkcs7;
//    }


    public void inspectSignatures(String path) throws IOException, GeneralSecurityException {
        com.itextpdf.text.pdf.PdfReader reader = new com.itextpdf.text.pdf.PdfReader(path)
//        PdfAcroForm form = PdfAcroForm.getAcroForm(reader, false);
//        AcroFields fields = reader.acroFields;
        AcroFields fields = reader.getAcroFields();
        List<String> names = fields.getSignatureNames();
//        SignaturePermissions perms = null;
//        SignatureUtil signUtil = new SignatureUtil(pdfDoc);
//        List<String> names = signUtil.getSignatureNames();

        println("path " + path)
        println("name " + names)
//        println("name 2 " + fields.getSignature(names[0]))

//        PdfPKCS7 pkcs7 = fields.getField(names[0])

//        PdfPKCS7 pkcs7 = fields.readSignatureData(names[0]);


//        PdfPKCS7 pkcs7 = fields. (names[0]);
//        PdfPKCS7 pkcs7 = fields.verifySignature(names[0]);
//
//        BouncyCastleDigest cert = pkcs7.getSigningCertificate();
//        println("nombre: " + CertificateInfo.getSubjectFields(cert).getField("CN"))



//        X509Certificate cert = (X509Certificate) pkcs7.getSigningCertificate();
//        println("Name of the signer: " + CertificateInfo.getSubjectFields(cert).getField("CN"));


        PdfDictionary sigDict = fields.getSignatureDictionary(names[0]);
        PdfName sub = sigDict.getAsName(PdfName.SUBFILTER);
        PdfString certStr = sigDict.getAsString(PdfName.CERT);

        println("--> " + sub)
        println("--> " + certStr)
//        println("--> " + pkcs7)

        //        X509CertInfo certParser = new X509CertInfo()
//        X509CertParser certParser = new X509CertParser();
//        certParser.engineInit(new ByteArrayInputStream(certStr.getBytes()));
//        Collection<Certificate> certs = certParser.engineReadAll();
//
//        X509Certificate certificate = (X509Certificate) certs.iterator().next();

//
//        X500Principal principal = certificate.getSubjectX500Principal();
//
//
//        LdapName ldapDN = new LdapName(principal.getName());







//        def a = VerifySignature(fields, names[0])


//        println("--> " + pkcs7)

//        for (String name : names) {
//            System.out.println("===== " + name + " =====");
//            perms = inspectSignature(pdfDoc, signUtil, form, name, perms);
//        }
    }


//   public PdfPKCS7 VerifySignature(AcroFields fields, String name)
//    {
//        println("Signature covers whole document: " + fields.signatureCoversWholeDocument(name));
//        println("Document revision: " + fields.getRevision(name) + " of " + fields.totalRevisions);
//        PdfPKCS7 pkcs7 = fields.verifySignature(name);
//        println("Integrity check OK? " + pkcs7.verify());
//        return pkcs7;
//    }


    def informacion(String src){
        com.itextpdf.text.pdf.PdfReader reader = new com.itextpdf.text.pdf.PdfReader(src)

            }

    def verifica(){
        def archivo = "/var/bitacora/firmas/salida.pdf"
//        informacion(archivo)
        inspectSignatures(archivo)
    }


}
