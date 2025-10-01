import { LightningElement } from "lwc";
import sayHello from "@salesforce/apex/HelloWorld.sayHello";

export default class HelloWorld extends LightningElement {
  name = "";
  greeting = "";

  handleNameChange(event) {
    this.name = event.target.value;
  }

  handleClick() {
    sayHello({ name: this.name })
      .then((result) => {
        this.greeting = result;
      })
      .catch((error) => {
        this.greeting = "Error: " + error.body.message;
      });
  }
}
