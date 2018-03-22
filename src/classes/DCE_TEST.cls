@isTest
private class DCE_TEST {
  @isTest
  static void test(){
    DCE.allowUntil('AP123',1);
    DCE.isAllowed('AP123');
    DCE.isAllowed('AP123');
  }
}