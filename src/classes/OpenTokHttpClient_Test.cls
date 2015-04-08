@isTest
private class OpenTokHttpClient_Test {	
    @isTest 
    static void OpenTokHttpClient_startArchiving_Success() {
        Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTokHttpClient controller = new OpenTokHttpClient('https://api.opentok.com', 12345678, 'test');
            String result = controller.startArchive('testsessionId','testname');
        Test.stopTest();

        System.assertNotEquals('{"id" : "testarchivedid", "status" : "started", "name" : "testname", "reason" : "", "sessionId" : "testsessionid", "partnerId" : 45168812,   "createdAt" : 1425395554038, "size" : 0, "duration" : 0, "mode" : "automatic", "updatedAt" : 1425395554038, "url" : null}', result);
    }
    @isTest 
    static void OpenTokHttpClient_stopArchiving_Success() {
        Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTokHttpClient controller = new OpenTokHttpClient('https://api.opentok.com', 12345678, 'test');
            String result = controller.stopArchive('testsessionId');
        Test.stopTest();

        System.assertNotEquals('{"id" : "testarchivedid", "status" : "started", "name" : "testname", "reason" : "", "sessionId" : "testsessionid", "partnerId" : 45168812,   "createdAt" : 1425395554038, "size" : 0, "duration" : 0, "mode" : "automatic", "updatedAt" : 1425395554038, "url" : null}', result);
    }
    @isTest
	public static void OpenTokHttpClient_Test_CreateSession_Success() {
		OpenTokKey__c openTokKey = new OpenTokKey__c(name = 'key');
		openTokKey.Api_Key__c = 'test';
		openTokKey.Secret__c = 'test';
		insert openTokKey;

		Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTokHttpClient controller = new OpenTokHttpClient('https://api.opentok.com', 12345678, 'test');
            String result = controller.createSession();
        Test.stopTest();

        System.assertEquals('testsessionid', result);
	}
    @isTest 
    static void deleteArchiving_Success() {
        Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTokHttpClient controller = new OpenTokHttpClient('https://api.opentok.com', 12345678, 'test');
            String result = controller.deleteArchive('testsessionId');
        Test.stopTest();

        System.assertEquals('pass', result);
    }
}