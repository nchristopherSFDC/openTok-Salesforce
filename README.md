# OpenTok SalesForce SDK



The OpenTok Salesforce SDK lets you generate
[sessions](http://tokbox.com/opentok/tutorials/create-session/) and
[tokens](http://tokbox.com/opentok/tutorials/create-token/) for [OpenTok](http://www.tokbox.com/)
applications that run on the Salesforce Platform. 

Coming Soon -  the SDK will also include support for working
with [OpenTok 2.0 archives](http://tokbox.com/#archiving).


# Installation
Coming Soon

## Creating Sessions

To create an OpenTok Session, use the `OpenTok` instance's `createSession(SessionProperties properties)`
method. The `properties`(ToDo) parameter is optional and it is used to specify two things:

* Whether the session uses the OpenTok Media Router
* A location hint for the OpenTok server.


## Generating Tokens

Once a Session is created, you can start generating Tokens for clients to use when connecting to it.
You can generate a token either by calling an OpenTok instance's
`generateToken(String sessionId, TokenOptions options)` method, or by calling a OpenTokSession
instance's `generateToken(TokenOptions options)` method after creating it. The `options` parameter
is optional and it is used to set the role, expire time, and connection data of the token. An
instance can be initialized using the `OpenTokTokenOptions` class.

## Working with Archives

TODO - Coming Soon - Work In Progress

# Requirements

You need an OpenTok API key and API secret, which you can obtain at <https://dashboard.tokbox.com>.

A salesforce ORG or Developer Account. To get a salesforce developer account sign up at https://developer.salesforce.com/

# Release Notes

TODO



Find a bug? File it on the [Issues](https://github.com/nchristopher/openTokSFDC/issues) page. Hint:
test cases are really helpful!
