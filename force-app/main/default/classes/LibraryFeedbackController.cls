public with sharing class LibraryFeedbackController {
      @AuraEnabled
  public static Library_Feedback__c[] saveFeedback(Library_Feedback__c[] b){
    try {
            insert b;
            return b;
        
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}
}