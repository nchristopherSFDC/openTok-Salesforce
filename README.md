# OpenTok SalesForce SDK



The OpenTok Salesforce SDK lets you generate
[sessions](http://tokbox.com/opentok/tutorials/create-session/) and
[tokens](http://tokbox.com/opentok/tutorials/create-token/) for [OpenTok](http://www.tokbox.com/)
applications that run on the Salesforce Platform. 

If you are new to tokbox and its APIs, it might be worth spending some time reading up on their core concepts at their developer [website](https://tokbox.com/developer/concepts/)


# Installation

You can use the [ant migration tool](https://developer.salesforce.com/page/Force.com_Migration_Tool) to deploy this project to your 
salesforce org.

Edit the `package.xml` file:
```package.xml
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
	<types>
		<members>*</members>
		<name>ApexClass</name>
	</types>
	<types>
		<members>*</members>
		<name>ApexTrigger</name>
	</types>
	<types>
		<members>openTokKey__c</members>
		<name>CustomObject</name>
	</types>
	<types>
		<members>*</members>
		<name>StaticResource</name>
	</types>
	<version>28.0</version>
</Package>
```
A managed package is under consideration and the link to install this package in your org will be available soon. 

## Creating Sessions

To create an OpenTok Session, use the `OpenTok` instance's `createSession(SessionProperties properties)`
method. The `properties`(ToDo) parameter is optional and it is used to specify two things:

* Whether the session uses the OpenTok Media Router(In Progress, Default to relayed for now)
* A location hint for the OpenTok server.

```
//Ensure custom setting has record
String apiKey = openTokKey__c.getValue('key').Api_Key__c;
OpenTok openTok = new OpenTok(Integer.valueOf(this.apiKey),
			 openTokKey__c.getValues('key').Secret__c);
OpenTokSession session = openTok.createSession(null);
String sessionId = session.sessionId;
```

## Generating Tokens

Once a Session is created, you can start generating Tokens for clients to use when connecting to it.
You can generate a token either by calling an OpenTok instance's
`generateToken(String sessionId, TokenOptions options)` method, or by calling a OpenTokSession
instance's `generateToken(TokenOptions options)` method after creating it. The `options` parameter
is optional and it is used to set the role, expire time, and connection data of the token. An
instance can be initialized using the `OpenTokTokenOptions` class.

```
OpenTokSession session = new OpenTokSession(sessionId, 
				Integer.valueOf(apiKey), 
				openTokKey__c.getValues('key').Secret__c);
OpenTokTokenOptions tokenOptions = new OpenTokTokenOptions(OpenTokRole.PUBLISHER, 
					30, 
					UserInfo.getName());
String token = session.generateToken(tokenOptions);
```

## Working with Archives
You can start the recording of an OpenTok Session using an instance of `OpenTokHttpClient`  `startArchive(String sessionId, String name) method`. 
This will return a String with the archive Id. The parameter name is a optional and used to assign a name for the Archive. 
Note that you can only start an Archive on a Session that has clients connected.
```
OpenTokHTTPClient openTokHttpClient = new OpenTokHTTPClient('https://api.opentok.com', 
						Integer.valueof(openTokKey__c.getValues('key').Api_Key__c), 
						openTokKey__c.getValues('key').Secret__c);
openTokHttpClient.startArchive('sessionId', 'Test_Recording');
```

You can also stop and delete an archive by using the instance methods `stopArchive(String archiveId)` and `deleteArchive(String archiveId)`

Ability to list all archives and get an archive is under development(Coming Soon!)

# Requirements

You need an OpenTok API key and API secret, which you can obtain at <https://dashboard.tokbox.com>.

A salesforce ORG or Developer Account. To get a salesforce developer account sign up at https://developer.salesforce.com/

# Release Notes

TODO



Find a bug? File it on the [Issues](https://github.com/nchristopher/openTokSFDC/issues) page. Hint:
test cases are really helpful!
