public with sharing class ContactController {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    return [
      SELECT Id, Name, LastName, Email, Phone
      FROM Contact
      ORDER BY Name
      LIMIT 100
    ];
  }

  @AuraEnabled
  public static Contact addContact(String name, String email, String phone) {
    Contact newContact = new Contact(
      LastName = name,
      Email = email,
      Phone = phone
    );
    insert newContact;
    return newContact;
  }
}
