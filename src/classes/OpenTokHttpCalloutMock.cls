@isTest
global with sharing class OpenTokHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        System.debug('req -> ' + req);
        String endpoint = req.getEndpoint() ;
        System.debug('endpoint -> ' + endpoint);
        HttpResponse res = new HttpResponse();
        if(endpoint == 'https://api.opentok.com/session/create'){
            // creating a new session
            res.setHeader('Content-Type', 'application/xml');
            res.setBody('<?xml version="1.0" encoding="UTF-8"?><sessions><Session><session_id>testsessionid</session_id><partner_id>12345678</partner_id><create_dt>Mon Mar 02 06:25:40 PST 2015</create_dt></Session></sessions>');
            res.setStatusCode(200);
        } else {
            //start/stop archiving
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"id" : "testarchivedid", "status" : "started", "name" : "testname", "reason" : "", "sessionId" : "testsessionid", "partnerId" : 45168812,   "createdAt" : 1425395554038, "size" : 0, "duration" : 0, "mode" : "automatic", "updatedAt" : 1425395554038, "url" : null}');
            res.setStatusCode(200);
        }
        return res;
    }
}