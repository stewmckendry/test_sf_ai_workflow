@isTest
public class ExpenseControllerTest {
  @isTest
  static void testGetExpenses() {
    // Create test expenses
    List<Expense__c> testExpenses = new List<Expense__c>();
    testExpenses.add(
      new Expense__c(
        Name = 'Hotel Stay',
        Amount__c = 150.00,
        Date__c = Date.today(),
        Category__c = 'Travel'
      )
    );
    testExpenses.add(
      new Expense__c(
        Name = 'Team Lunch',
        Amount__c = 45.50,
        Date__c = Date.today().addDays(-1),
        Category__c = 'Food'
      )
    );
    insert testExpenses;

    // Call the method
    Test.startTest();
    List<Expense__c> expenses = ExpenseController.getExpenses();
    Test.stopTest();

    // Verify results
    System.assertEquals(
      2,
      expenses.size(),
      'Expected 2 expenses to be returned'
    );
    System.assertEquals(
      'Hotel Stay',
      expenses[0].Name,
      'Expected expenses to be ordered by date descending'
    );
  }

  @isTest
  static void testAddExpense() {
    // Call the method
    Test.startTest();
    Expense__c newExpense = ExpenseController.addExpense(
      'Office Supplies',
      75.25,
      Date.today(),
      'Supplies'
    );
    Test.stopTest();

    // Verify the expense was inserted
    System.assertNotEquals(
      null,
      newExpense.Id,
      'Expected expense to be inserted with an Id'
    );

    // Query to verify the expense exists
    List<Expense__c> expenses = [
      SELECT Id, Name, Amount__c, Date__c, Category__c
      FROM Expense__c
      WHERE Id = :newExpense.Id
    ];
    System.assertEquals(1, expenses.size(), 'Expected 1 expense to be found');
    System.assertEquals(
      'Office Supplies',
      expenses[0].Name,
      'Expected Name to be Office Supplies'
    );
    System.assertEquals(
      75.25,
      expenses[0].Amount__c,
      'Expected Amount to match'
    );
    System.assertEquals(
      Date.today(),
      expenses[0].Date__c,
      'Expected Date to match'
    );
    System.assertEquals(
      'Supplies',
      expenses[0].Category__c,
      'Expected Category to match'
    );
  }
}
