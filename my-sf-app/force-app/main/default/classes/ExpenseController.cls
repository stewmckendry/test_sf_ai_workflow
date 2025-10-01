public with sharing class ExpenseController {
  @AuraEnabled(cacheable=true)
  public static List<Expense__c> getExpenses() {
    return [
      SELECT Id, Name, Amount__c, Date__c, Category__c
      FROM Expense__c
      ORDER BY Date__c DESC
      LIMIT 100
    ];
  }

  @AuraEnabled
  public static Expense__c addExpense(
    String name,
    Decimal amount,
    Date expenseDate,
    String category
  ) {
    Expense__c newExpense = new Expense__c(
      Name = name,
      Amount__c = amount,
      Date__c = expenseDate,
      Category__c = category
    );
    insert newExpense;
    return newExpense;
  }
}
