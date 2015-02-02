/**
* Represents an OpenTok session. Use the  OpenTok.createSession(SessionProperties properties)
* method to create an OpenTok session. Use OpenTokSession.sessionId to get the session ID.
*/
public with sharing class OpenTokSession {
	public String sessionId { get; set; }
	public Integer apiKey { get; set; }
	public String apiSecret { get; set; }
	public OpenTokSessionProperties properties { get; set; }

	public OpenTokSession(String sessionId, Integer apiKey, String apiSecret) {
		this.sessionId = sessionId;
		this.apiKey = apiKey;
		this.apiSecret = apiSecret;
		this.properties = new OpenTokSessionProperties('');
	}

	/**
     * Creates a token for connecting to an OpenTok session. In order to authenticate a user
     * connecting to an OpenTok session that user must pass an authentication token along with
     * the API key.
     *
     * returns The token string.
     */
    public String generateToken(OpenTokTokenOptions tokenOptions) {

        // Token format
        //
        // | ------------------------------  tokenStringBuilder ----------------------------- |
        // | 'T1=='+Base64Encode(| --------------------- innerBuilder --------------------- |)|
        //                       | 'partner_id={apiKey}&sig={sig}:| -- dataStringBuilder -- |

        if (tokenOptions == null) {
            throw new OpenTokException('Token options cannot be null');
        }

        OpenTokTokenOptions openTokTokenOptions = tokenOptions;
        Double expireTime = tokenOptions.expireTime; // will be 0 if nothing was explicitly set
        String data = tokenOptions.connectionData;             // will be null if nothing was explicitly set
        Long create_time = System.currentTimeMillis() / 1000;

        String dataStringBuilder = '';
        dataStringBuilder += 'session_id=';
        dataStringBuilder += sessionId;
        dataStringBuilder += '&create_time=';
        dataStringBuilder += create_time;
        dataStringBuilder += '&nonce=';
        dataStringBuilder += Math.round(Math.random() * (100 - 1)) + 1;
        dataStringBuilder += '&role=';
        dataStringBuilder += openTokTokenOptions.role;
        if(expireTime != 0){
        	expireTime = System.now().addDays(Integer.valueOf(expireTime)).getTime() / 1000L;
        }
        Double now = System.currentTimeMillis() / 1000L;
        if (expireTime == 0) {
            expireTime = now + (60*60*24); // 1 day
        } else if(expireTime < now-1) {
            throw new OpenTokException(
                    'Expire time must be in the future. relative time: '+ (expireTime - now));
        } else if(expireTime > (now + (60*60*24*30) /* 30 days */)) {
            throw new OpenTokException(
                    'Expire time must be in the next 30 days. too large by '+ (expireTime - (now + (60*60*24*30)))/1000);
        }
        // NOTE: Double.toString() would print the value with scientific notation
        dataStringBuilder += String.valueOf('&expire_time=' + Integer.valueOf(expireTime));

        if (data != null) {
            if(data.length() > 1000) {
                throw new OpenTokException(
                        'Connection data must be less than 1000 characters. length: ' + data.length());
            }
            dataStringBuilder += '&connection_data=';
            try {
                dataStringBuilder += EncodingUtil.urlEncode(data, 'UTF-8');
            } catch (Exception e) {
                throw new OpenTokException(
                        'Error during URL encode of your connection data: ' +  e.getMessage());
            }
        }
        System.DEBUG('dataStringBuilder : ' + dataStringBuilder); 

        String tokenStringBuilder = '';
        try {
            tokenStringBuilder += 'T1==';

            String innerBuilder = '';
            innerBuilder += 'partner_id=';
            innerBuilder += this.apiKey;

            innerBuilder += '&sig=';

            innerBuilder += OpenTokCrypto.signData(dataStringBuilder, this.apiSecret);
            innerBuilder += ':';
            innerBuilder += dataStringBuilder;

            tokenStringBuilder += 
                    EncodingUtil.base64Encode(
                            Blob.valueOf(innerBuilder)
                    )
                    .replace('+', '-')
                    .replace('/', '_');
             System.DEBUG('innerBuilder : ' + innerBuilder);

        } catch (Exception e) {
            throw new OpenTokException('Could not generate token, a signing error occurred.', e);
        }

        return tokenStringBuilder;
    }
}