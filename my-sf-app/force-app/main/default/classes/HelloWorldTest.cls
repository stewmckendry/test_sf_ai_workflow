@isTest
public class HelloWorldTest {
  @isTest
  static void testSayHello() {
    String result = HelloWorld.sayHello('Stewart');
    System.assertEquals(
      'Hello, Stewart!',
      result,
      'Expected greeting message for Stewart'
    );
  }
}
