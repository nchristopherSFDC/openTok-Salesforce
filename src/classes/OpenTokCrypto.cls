public with sharing class OpenTokCrypto {
	public OpenTokCrypto() {
		
	}
	public static String signData(String data, String key){
        String algorithmName = 'HMacSHA1';
      	Blob mac = Crypto.generateMac(algorithmName,  Blob.valueOf(data), 
                                                    Blob.valueOf(key));
      	String macUrl = EncodingUtil.convertToHex(mac);
        return macUrl;
    }
}