public with sharing class RecordCount {
 
    @AuraEnabled(cacheable=true)
    public static integer getFacultyValue() {
        integer faculty ;
        faculty=[SELECT count() FROM User where Profile.Name ='System Administrator'];
        return (faculty);
    }
    @AuraEnabled(cacheable=true)
    public static integer getStudentValue() {
        integer studnet ;
        studnet=[SELECT count() FROM User where Profile.Name ='Standard Platform User'];
        return (studnet);
    }
    @AuraEnabled(cacheable=true)
    public static Decimal getBooksValue() {
        Decimal books=0 ;
        for( Book__c b:[SELECT Quantity__c FROM Book__c ])
        {
            books=books + b.Quantity__c;
        }
        return (books);
    }
    @AuraEnabled(cacheable=true)
    public static integer getBookIssuedValue() {
        integer booksissued ;
        booksissued=[SELECT count() FROM Borrower__c where Status__C !='Returned'];
        return (booksissued);
    }
}