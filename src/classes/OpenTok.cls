/**
* Contains methods for creating OpenTok sessions, generating tokens, and working with archives.
* To create a new OpenTok object, call the OpenTok constructor with your OpenTok API key
* and the API secret from https://dashboard.tokbox.com Do not publicly share
* your API secret. You will use it with the OpenTok constructor to create OpenTok sessions.
*/
public with sharing class OpenTok {
	private Integer apiKey;
    private String apiSecret;
    private String apiUrl;

    /**
     * Creates an OpenTok object.
     *
     * @param apiKey Your OpenTok API key. (See the 'https://dashboard.tokbox.com')
     * @param apiSecret Your OpenTok API secret. (See the 'https://dashboard.tokbox.com')
     */
    public OpenTok(Integer apiKey, String apiSecret) {
        this.apiKey = apiKey;
        this.apiSecret = apiSecret.trim();
        this.apiUrl = 'https://api.opentok.com';
    }


    /**
     * Creates a new OpenTok session.
     * @return A Session object representing the new session. Call the OpenTokSession.sessionId to
     * get the session ID, which uniquely identifies the
     * session. You will use this session ID in the client SDKs to identify the session.
     */
    public OpenTokSession createSession(OpenTokSessionProperties properties){
    	OpenTokHttpClient httpClient = new OpenTokHttpClient(this.apiUrl, this.apiKey, this.apiSecret);
    	String xmlResponse = httpClient.createSession();
    	return new OpenTokSession(xmlResponse,apiKey,apiSecret);
    }

    /**
     * Creates a token for connecting to an OpenTok session. In order to authenticate a user
     * connecting to an OpenTok session, the client passes a token when connecting to the session.
     */
     public String generateToken(String sessionId, OpenTokTokenOptions tokenOptions) {
        List<String> sessionIdParts = null;
        if(sessionId == null || sessionId == '') {
            throw new OpenTokException('Session not valid');
        }
        /*
        TODO Exception Handling
        */
        OpenTokSession session = new OpenTokSession(sessionId, apiKey, apiSecret);
        return session.generateToken(tokenOptions);
    }

}