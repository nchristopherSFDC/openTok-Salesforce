public class OpenTokViewController {

	public String sessionId { get; set; }
	public String apiKey { get; set; }
	public String token { get; set; }

	public OpenTokViewController(){
		apiKey = openTokKey__c.getValues('key').Api_Key__c;
		sessionId = '2_MX40NTE0MTU1Mn5-MTQyMjg4NDQ0Njg2NX5xTDhJYnZ1blJkSkIwNTJsSlpiVCtNVG9-fg';
		token = generateToken(sessionId);
	}

	private String generateToken(String sessionId){
		OpenTokSession session = new OpenTokSession(sessionId, Integer.valueOf(apiKey), openTokKey__c.getValues('key').Secret__c);
		OpenTokTokenOptions tokenOptions = new OpenTokTokenOptions(OpenTokRole.PUBLISHER, 30, UserInfo.getName());
		return session.generateToken(tokenOptions);
	}

}

