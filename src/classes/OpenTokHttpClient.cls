public with sharing class OpenTokHttpClient {
	private final String apiUrl;
    private final Integer apiKey;
    private final String apiSecret;
    private Http http;
    private HttpRequest httpRequest;
    private HttpResponse httpResponse;

	public OpenTokHttpClient(String apiUrl, Integer apiKey, String apiSecret) {
		this.apiUrl = apiUrl;
		this.apiKey = apiKey;
		this.apiSecret = apiSecret;
		this.http = new Http();
		this.httpRequest = new HttpRequest();
		this.httpResponse = new HttpResponse();
	}

	public String createSession(){
		this.setHttpRequest();
		try{
			httpResponse = http.send(httpRequest);
			if(httpResponse.getStatusCode() == 200){
				return OpenTokXMLStreamReader.parseSessionResponse(httpResponse.getBodyDocument());
			}else{
				return 'Could Not create session. Could not read response : ' + httpResponse.getStatusCode();
			}
			return 'Error';
		}catch (Exception e){
			return 'Could Not create session. Could not read response : ' + e;
		}
	}

	private void setHttpRequest(){
		httpRequest.setEndpoint(apiUrl + '/session/create');
		httpRequest.setMethod('POST');
		httpRequest.setHeader('X-TB-PARTNER-AUTH', this.apiKey + ':' + this.apiSecret);
	}
}