import { LightningElement, wire } from "lwc";
import getExpenses from "@salesforce/apex/ExpenseController.getExpenses";
import addExpense from "@salesforce/apex/ExpenseController.addExpense";
import { refreshApex } from "@salesforce/apex";

export default class ExpenseTracker extends LightningElement {
  name = "";
  amount = "";
  expenseDate = "";
  category = "";
  message = "";
  messageClass = "";
  expenses;

  @wire(getExpenses)
  wiredExpenses(result) {
    this.expenses = result;
  }

  handleNameChange(event) {
    this.name = event.target.value;
  }

  handleAmountChange(event) {
    this.amount = event.target.value;
  }

  handleDateChange(event) {
    this.expenseDate = event.target.value;
  }

  handleCategoryChange(event) {
    this.category = event.target.value;
  }

  get isAddDisabled() {
    return !this.name || !this.amount || !this.expenseDate || !this.category;
  }

  get categoryOptions() {
    return [
      { label: "Travel", value: "Travel" },
      { label: "Food", value: "Food" },
      { label: "Supplies", value: "Supplies" },
      { label: "Other", value: "Other" }
    ];
  }

  handleAddExpense() {
    addExpense({
      name: this.name,
      amount: parseFloat(this.amount),
      expenseDate: this.expenseDate,
      category: this.category
    })
      .then(() => {
        this.message = "Expense added successfully!";
        this.messageClass = "slds-text-color_success";
        this.name = "";
        this.amount = "";
        this.expenseDate = "";
        this.category = "";
        return refreshApex(this.expenses);
      })
      .catch((error) => {
        this.message = "Error adding expense: " + error.body.message;
        this.messageClass = "slds-text-color_error";
      });
  }
}
