@isTest
private class OpenTokCryptoTest {
	
    @isTest 
    static void signData() {
        Test.startTest();
            OpenTokCrypto controller = new OpenTokCrypto();
            String result = OpenTokCrypto.signData('testdata', 'testkey');
        Test.stopTest();

        System.assertEquals('e1df1976238aa72bd56a05a850c78c7be58812e8', result);
    }
	

}