/**
* Defines values for the role parameter of the OpenTokTokenOptions.Role method.
*/
public enum OpenTokRole {
/**
*   A subscriber can only subscribe to streams.
*
*   A publisher can publish streams, subscribe to streams, and signal. This is the default
*   value if you do not set a role
*
*   In addition to the privileges granted to a publisher, in clients using the OpenTok.js 2.2
*   library, a moderator can call the <code>forceUnpublish()</code> and
*   <code>forceDisconnect()</code> method of the Session object.
*/
	SUBSCRIBER,PUBLISHER,MODERATOR
}