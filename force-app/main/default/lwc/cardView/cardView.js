import { LightningElement , wire} from 'lwc';
import getFacultyValue from '@salesforce/apex/RecordCount.getFacultyValue';
import getStudentValue from '@salesforce/apex/RecordCount.getStudentValue';
import getBooksValue from '@salesforce/apex/RecordCount.getBooksValue';
import getBookIssuedValue from '@salesforce/apex/RecordCount.getBookIssuedValue';
export default class CardView extends LightningElement {
    totalFacultyMember;
    totalStudent;
    totalBooks;
    totalBooksIssued;

    @wire(getFacultyValue)
    wiredGetFacultyValue({ error, data }) {
        if (data) {
            this.totalFacultyMember = data;
        } else if (error) {
            console.error(error);
        }
    }
    @wire(getStudentValue)
    wiredGetStudentValue({ error, data }) {
        if (data) {
            this.totalStudent = data;
        } else if (error) {
            console.error(error);
        }
    }
    @wire(getBooksValue)
    wiredGetBooksValue({ error, data }) {
        if (data) {
            this.totalBooks = data;
        } else if (error) {
            console.error(error);
        }
    }
    @wire(getBookIssuedValue)
    wiredGetBookIssuedValue({ error, data }) {
        if (data) {
            this.totalBooksIssued = data;
        } else if (error) {
            console.error(error);
        }
    }
}