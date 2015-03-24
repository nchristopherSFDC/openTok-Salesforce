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
			this.httpResponse = http.send(this.httpRequest);
			if(this.httpResponse.getStatusCode() == 200){
				return OpenTokXMLStreamReader.parseSessionResponse(this.httpResponse.getBodyDocument());
			}else{
				return 'Could Not create session. Could not read response : ' + this.httpResponse.getStatusCode();
			}
			return 'Error';
		}catch (Exception e){
			return 'Could Not create session. Could not read response : ' + e;
		}
	}

	public String startArchive(String sessionId, String name){
		String responseString = '';
		ArchiveDataWrapper dataWapper = new ArchiveDataWrapper(sessionId, name);
		this.setStartArchiveRequest(dataWapper);
		try{
			this.httpResponse = this.http.send(this.httpRequest);
			System.DEBUG(this.httpResponse);
			return '';
		}catch(Exception e){
			System.DEBUG(e);
			return '';
		}
		return '';
	}
	
	private void setHttpRequest(){
		this.httpRequest.setEndpoint(this.apiUrl + '/session/create');
		this.httpRequest.setMethod('POST');
		this.httpRequest.setHeader('X-TB-PARTNER-AUTH', this.apiKey + ':' + this.apiSecret);
	}

	private void setStartArchiveRequest(ArchiveDataWrapper dataWapper){
		this.httpRequest.setEndpoint(this.apiUrl + '/v2/partner/' + this.apiKey + '/archive');
		this.httpRequest.setMethod('POST');
		this.httpRequest.setHeader('X-TB-PARTNER-AUTH', this.apiKey + ':' + this.apiSecret);
		this.httpRequest.setHeader('Content-Type', 'application/json');
		System.DEBUG(JSON.serialize(dataWapper));
		this.httpRequest.setBody(JSON.serialize(dataWapper));
	}

	public Class ArchiveDataWrapper{
		String sessionId { get; set; }
		String name { get; set; }

		public ArchiveDataWrapper(String sessionId, String name){
			this.sessionId = sessionId;
			this.name = name;
		}

	}
}