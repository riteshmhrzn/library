import { LightningElement, track, wire } from 'lwc';
import saveFeedback from '@salesforce/apex/LibraryFeedbackController.saveFeedback';
//import { getUserInfo } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import FEEDBACK_OBJECT from '@salesforce/schema/Library_Feedback__c';
//import NAME_FIELD from '@salesforce/schema/Library_Feedback__c.Name';
import TYPE_FIELD from '@salesforce/schema/Library_Feedback__c.Type__c';
import AUTHOR_FIELD from '@salesforce/schema/Library_Feedback__c.Author__c';
import FEEDBACK_FIELD from '@salesforce/schema/Library_Feedback__c.Feedback__c';
import BOOKNAME_FIELD from '@salesforce/schema/Library_Feedback__c.Book_Name__c';
export default class LibraryFeedback extends LightningElement {
  objectApiName=FEEDBACK_OBJECT;
    fields = [TYPE_FIELD,BOOKNAME_FIELD,AUTHOR_FIELD,FEEDBACK_FIELD];
    handleSuccess(event){
      const toastEvent=new ShowToastEvent({
          title:"Form posted !",
          message: "Form has been posted",
          variant: "success"
      });
      this.dispatchEvent(toastEvent);
      setTimeout(() => {
          eval("$A.get('e.force:refreshView').fire();");
     }, 1000);
  }
  
  
  currentUser;
    feedbackform=false;
    handleAddFeedback(){
      this.feedbackform= true;
    }
    handleCancel() {    
            
      this.feedbackform = false;
  }

  // Wire getUserInfo to currentUser property
  

    @track name = '';
  @track email = '';
  @track bookname = '';
  @track author = '';
  @track feedback = '';
  @track value = '';

    get options() {
        return [
            { label: 'Feedback', value: 'feedback' },
            { label: 'Request Book', value: 'requestBook' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

  handleSubmit() {
    // Validate form fields
    if (!this.name || !this.email || !this.feedback) {
      alert('Please enter a name, email, and feedback.');
      return;
    }
    

    // Call Apex method to save feedback
    saveFeedback({ name: this.name, email: this.email, bookname: this.bookname,author: this.author,value: this.value, feedback: this.feedback })
      .then(() => {
        // Clear form fields
        this.name = '';
        this.email = '';
        this.bookname='';
        this.value='';
        this.author='';
        this.feedback = '';
        alert('Thank you for your feedback!');
        setTimeout(() => {
          eval("$A.get('e.force:refreshView').fire();");
     }, 1000);
      })
      .catch((error) => {
        console.error(error);
        alert('An error occurred while saving your feedback.');
      });
  }
}