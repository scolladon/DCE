@isTest
private class DCE_TEST {
  @isTest
  static void test(){
    DCE.allowUntil('test',1);
    DCE.prevent('test+');
    DCE.allow('test');
    DCE.allow('test');
  }
}