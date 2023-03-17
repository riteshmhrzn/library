trigger AvailableBooks on Borrower__c (before insert) {
    Set<String> bookId = new Set<String>();
    //String bookId;
    for (Borrower__c bok:trigger.new){
        bookId.add(bok.Book__c);
        //BookName=bok.Book__r.Name;        
    }
    
    Integer BookAvailable =[SELECT Count() From Borrower__c where Book__r.Id in:bookId and Status__c = 'Not Returned'];
    //System.Assert(false,BookAvailable);
    Decimal bookquant;
    //System.Assert(false, [SELECT Quantity__c from Book__c where id = :bookId ]);
    for (Book__c b: [SELECT Quantity__c from Book__c where Id in :bookId ]) {
        bookquant=b.Quantity__C;
    }   
    if(BookAvailable == bookquant){
        for(Borrower__c bok:trigger.new){
            //System.Assert(false,bok);
            bok.addError('book not available');          
        }
    }
    Integer maxBooksStudent = 5;
    Integer maxBooksTeacher = 7;
    if (maxBooksStudent != null) {
        Set<Id> userIds = new Set<Id>();
        Map<Id, Integer> bkCountMap = new Map<Id, Integer>();
        for (Borrower__c bk: trigger.new) {
            userIds.add(bk.OwnerId);
            bkCountMap.put(bk.OwnerId,0);
        }
        Map<Id, User> userMap = new Map<Id, User>([select Name from User where Id in :userIds]);
        for (AggregateResult result: [select count(Id),OwnerId from Borrower__c where Status__c = 'Not Returned' and OwnerId in :userIds group by OwnerId]) {
            bkCountMap.put((Id) result.get('OwnerId'), (Integer) result.get('expr0'));
        }
        for (Borrower__c bk: trigger.new) {
            bkCountMap.put(bk.OwnerId, bkCountMap.get(bk.OwnerId) + 1);
            if (bkCountMap.get(bk.OwnerId) > maxBooksStudent) {
                bk.addError('Please return previous books. Max book ' + userMap.get(bk.OwnerId).Name + 'can borrow is ' + maxBooksStudent);
            }
        }
    }
}