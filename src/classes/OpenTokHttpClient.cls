global with sharing class OpenTokHttpClient {
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
			System.DEBUG(this.httpResponse.getBody());
			return this.httpResponse.getBody();
		}catch(Exception e){
			System.DEBUG(e);
			return '';
		}
		return '';
	}

	public String stopArchive(String archiveId){
		String responseString = '';
		this.setStopArchiveRequest(archiveId);
		try{
			this.httpResponse = this.http.send(this.httpRequest);
			System.DEBUG(this.httpResponse);
			System.DEBUG(this.httpResponse.getBody());
			return this.httpResponse.getBody();
		}catch(Exception e){
			System.DEBUG(e);
			return '';
		}
		return responseString;
	}

	public String deleteArchive(String archiveId){
		String responseString = '';
		this.setDeleteArchiveRequest(archiveId);
		try{
			this.httpResponse = this.http.send(this.httpRequest);
			System.DEBUG(this.httpResponse);
			System.DEBUG(this.httpResponse.getBody());
			return this.httpResponse.getBody();
		}catch(Exception e){
			System.DEBUG(e);
			return '';
		}
		return responseString;
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

	private void setStopArchiveRequest(String archiveId){
		this.httpRequest.setEndpoint(this.apiUrl + '/v2/partner/' + this.apiKey + '/archive/' + archiveId + '/stop');
		this.httpRequest.setMethod('POST');
		this.httpRequest.setHeader('X-TB-PARTNER-AUTH', this.apiKey + ':' + this.apiSecret);
		this.httpRequest.setHeader('Content-Type', 'application/json');
	}

	private void setDeleteArchiveRequest(String archiveId){
		this.httpRequest.setEndpoint(this.apiUrl + '/v2/partner/' + this.apiKey + '/archive/' + archiveId);
		this.httpRequest.setMethod('DELETE');
		this.httpRequest.setHeader('X-TB-PARTNER-AUTH', this.apiKey + ':' + this.apiSecret);
		this.httpRequest.setHeader('Content-Type', 'application/json');
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