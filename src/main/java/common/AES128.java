package common;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class AES128 {
    /**
     * 암호화
     *
     * @param input
     * @param key
     * @return
     */
    public static String encrypt(String input, String key) {
        byte[] crypted = null;
        try {

            SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");

            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, skey);
            crypted = cipher.doFinal(input.getBytes());
        } catch(Exception e) {
            System.out.println(e.toString());
        }

        BASE64Encoder encoder = new BASE64Encoder();

        String str = encoder.encode(crypted);

        return new String(str);
    }

    /**
     * 복호화
     *
     * @param input
     * @param key
     * @return
     */
    public static String decrypt(String input, String key) {
        byte[] output = null;
        try {
            BASE64Decoder decoder = new BASE64Decoder();

            SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");

            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, skey);
            output = cipher.doFinal(decoder.decodeBuffer(input));

        } catch(Exception e) {
            System.out.println(e.toString());
        }
        return new String(output);
    }
}