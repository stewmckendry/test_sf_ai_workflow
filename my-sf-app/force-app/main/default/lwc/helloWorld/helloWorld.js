import { LightningElement, track } from "lwc";
import echoName from "@salesforce/apex/HelloWorldController.echoName";

export default class HelloWorld extends LightningElement {
  @track name = "";
  @track greeting = "";

  handleNameChange(event) {
    this.name = event.target.value;
  }

  handleClick() {
    echoName({ name: this.name })
      .then((result) => {
        this.greeting = result;
      })
      .catch((error) => {
        this.greeting = "Error: " + error.body.message;
      });
  }
}
