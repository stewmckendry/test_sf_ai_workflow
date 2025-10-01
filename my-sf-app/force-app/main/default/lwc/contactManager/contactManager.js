import { LightningElement, wire } from "lwc";
import getContacts from "@salesforce/apex/ContactController.getContacts";
import addContact from "@salesforce/apex/ContactController.addContact";
import { refreshApex } from "@salesforce/apex";

export default class ContactManager extends LightningElement {
  name = "";
  email = "";
  phone = "";
  message = "";
  messageClass = "";
  contacts;

  @wire(getContacts)
  wiredContacts(result) {
    this.contacts = result;
  }

  handleNameChange(event) {
    this.name = event.target.value;
  }

  handleEmailChange(event) {
    this.email = event.target.value;
  }

  handlePhoneChange(event) {
    this.phone = event.target.value;
  }

  get isAddDisabled() {
    return !this.name;
  }

  handleAddContact() {
    addContact({
      name: this.name,
      email: this.email,
      phone: this.phone
    })
      .then(() => {
        this.message = "Contact added successfully!";
        this.messageClass = "slds-text-color_success";
        this.name = "";
        this.email = "";
        this.phone = "";
        return refreshApex(this.contacts);
      })
      .catch((error) => {
        this.message = "Error adding contact: " + error.body.message;
        this.messageClass = "slds-text-color_error";
      });
  }
}
