@isTest
public class ContactControllerTest {
  @isTest
  static void testGetContacts() {
    // Create test contacts
    List<Contact> testContacts = new List<Contact>();
    testContacts.add(
      new Contact(
        LastName = 'Smith',
        Email = 'smith@test.com',
        Phone = '1234567890'
      )
    );
    testContacts.add(
      new Contact(
        LastName = 'Johnson',
        Email = 'johnson@test.com',
        Phone = '0987654321'
      )
    );
    insert testContacts;

    // Call the method
    Test.startTest();
    List<Contact> contacts = ContactController.getContacts();
    Test.stopTest();

    // Verify results
    System.assertEquals(
      2,
      contacts.size(),
      'Expected 2 contacts to be returned'
    );
    System.assertEquals(
      'Johnson',
      contacts[0].LastName,
      'Expected contacts to be ordered by name'
    );
  }

  @isTest
  static void testAddContact() {
    // Call the method
    Test.startTest();
    Contact newContact = ContactController.addContact(
      'Brown',
      'brown@test.com',
      '5551234567'
    );
    Test.stopTest();

    // Verify the contact was inserted
    System.assertNotEquals(
      null,
      newContact.Id,
      'Expected contact to be inserted with an Id'
    );

    // Query to verify the contact exists
    List<Contact> contacts = [
      SELECT Id, LastName, Email, Phone
      FROM Contact
      WHERE Id = :newContact.Id
    ];
    System.assertEquals(1, contacts.size(), 'Expected 1 contact to be found');
    System.assertEquals(
      'Brown',
      contacts[0].LastName,
      'Expected LastName to be Brown'
    );
    System.assertEquals(
      'brown@test.com',
      contacts[0].Email,
      'Expected Email to match'
    );
    System.assertEquals(
      '5551234567',
      contacts[0].Phone,
      'Expected Phone to match'
    );
  }
}
