public with sharing class OpenTokXMLStreamReader {
	

    public Static String parseSessionResponse(Dom.Document doc) {
        String sessionId = '';
        Dom.XMLNode session = doc.getRootElement();
        for(Dom.XMLNode childElement : session.getChildElements()) {
            for(Dom.XMLNode child : childElement.getChildElements()) {
                System.debug(child.getName() + ':' +child.getText());
                if(child.getName().equalsIgnoreCase('session_id')){
                    sessionId = child.getText();
                }
            }
        }
        return sessionId;
    }


}