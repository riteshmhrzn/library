public without sharing class GetBorrowerController {
    @AuraEnabled
    public static list<Borrower__c> getBorrow(string BName){
        String userProfileName = [select Name from profile where id =: userinfo.getProfileId()].Name;
        String usrname= UserInfo.getFirstName();
        if(userProfileName == 'System Administrator'){
            if(BName != null ){
                string ac= Bname+'%';
                //System.debug('if:::'+[Select Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c ]);
                return [Select Id,Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c where Borrowed_By__c LIKE:ac OR Book__r.Name LIKE:ac  order by Name ];
            }
            else{
                //System.debug('else:::'+[Select Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c ]);
                return [Select Id,Name,Bill_Ammount_B__c,Borrowed_By__c,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c ];
            }
        }
        else{
            if(BName != null ){
                string ac= Bname+'%';
                //System.debug('if:::'+[Select Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c ]);
                return [Select Id,Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c where Borrowed_By__c LIKE:usrname AND Book__r.Name LIKE:ac order by Name ];
            }
            else{
                //System.debug('else:::'+[Select Name,Bill_Ammount_B__c,Borrowed_By__c ,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c ]);
                return [Select Id,Name,Bill_Ammount_B__c,Borrowed_By__c,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c where Borrowed_By__c=:usrname];
            }
        }
        
    }
    
    @AuraEnabled
    public static list<Borrower__c> getBookByid(string ID){
        return [Select Id,Name,Bill_Ammount_B__c,Borrowed_By__c,Date_of_Issue_B__c ,Date_of_Return_B__c,Date_To_Be_Returned__c,Status__c,Book__r.Name  From Borrower__c where Id=: ID ];
    }
    
    @AuraEnabled
    public static void editBorrowRecord(string bid){
        Borrower__c borrowertoUpdate;
        borrowertoUpdate=[Select Status__c from Borrower__c where Name=: bid LIMIT 1 ];
        borrowertoUpdate.Status__c='Return Pending';
        borrowertoUpdate.Return_Book__c=true;
        update borrowertoUpdate;
        
    }
    
    
}