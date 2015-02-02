/**
 * Defines values for the OpenTokTokenOptions parameter of the
 * OpenTok.generateToken(String sessionId, OpenTokTokenOptions tokenOptions) method
 * and the OpenTokHttpClient.generateToken(OpenTokTokenOptions tokenOptions) method.
 */
public with sharing class OpenTokTokenOptions {
	public OpenTokRole role { get; set; }
    public Double expireTime { get; set; }
    public String connectionData { get; set; }

	public OpenTokTokenOptions(OpenTokRole role, Double expireTime, String connectionData) {
		this.role = role != null ? role : OpenTokRole.PUBLISHER;
		this.expireTime = expireTime;
		this.connectionData = connectionData;
	}
}