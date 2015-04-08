@isTest
public with sharing class OpenTok_Test {
	@isTest
	public static void OpenTok_CreateSession() {
		OpenTokKey__c openTokKey = new OpenTokKey__c(name = 'key');
		openTokKey.Api_Key__c = 'test';
		openTokKey.Secret__c = 'test';
		insert openTokKey;

		Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTok  controller = new OpenTok(12345678, 'testsecret');
            OpenTokSession sessionId = controller.createSession(null);
        Test.stopTest();

        System.assertEquals('testsessionid', sessionId.sessionId);
	}
	@isTest
	public static void OpenTok_GenerateToken() {
		OpenTokKey__c openTokKey = new OpenTokKey__c(name = 'key');
		openTokKey.Api_Key__c = 'test';
		openTokKey.Secret__c = 'test';
		insert openTokKey;
		
		Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTok  controller = new OpenTok(12345678, 'testsecret');
            OpenTokSession sessionId = controller.createSession(null);
            String token = controller.generateToken(sessionId.sessionId, new OpenTokTokenOptions(OpenTokRole.PUBLISHER, Double.valueOf(30.0), 'test'));
        Test.stopTest();

	}	
	@isTest
	public static void OpenTok_GenerateToken_TokenOptionsCannotBeNull() {
		OpenTokKey__c openTokKey = new OpenTokKey__c(name = 'key');
		openTokKey.Api_Key__c = 'test';
		openTokKey.Secret__c = 'test';
		insert openTokKey;
		Boolean testPass = false;
		Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTok  controller = new OpenTok(12345678, 'testsecret');
            OpenTokSession sessionId = controller.createSession(null);
            try{
            	String token = controller.generateToken(sessionId.sessionId, null);
            	testPass = false;
            	}catch(OpenTokException e){
            		testPass = true;
            		System.assertEquals('Token options cannot be null',e.getMessage());
            	}
        Test.stopTest();
        System.assert(testPass);
	}	
	@isTest
	public static void OpenTok_GenerateToken_SessionNotValid() {
		OpenTokKey__c openTokKey = new OpenTokKey__c(name = 'key');
		openTokKey.Api_Key__c = 'test';
		openTokKey.Secret__c = 'test';
		insert openTokKey;
		Boolean testPass = false;
		Test.setMock(HttpCalloutMock.class, new OpenTokHttpCalloutMock());

        Test.startTest();
            OpenTok  controller = new OpenTok(12345678, 'testsecret');
            OpenTokSession sessionId = controller.createSession(null);
            try{
            	String token = controller.generateToken(null, null);
            	testPass = false;
            	}catch(OpenTokException e){
            		testPass = true;
            		System.assertEquals('Session not valid',e.getMessage());
            	}
        Test.stopTest();
        System.assert(testPass);
	}
}