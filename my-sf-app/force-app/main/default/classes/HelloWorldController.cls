public with sharing class HelloWorldController {
  @AuraEnabled
  public static String echoName(String name) {
    return 'Hello, ' + name;
  }
}
