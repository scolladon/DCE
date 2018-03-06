@isTest
private class DCE_BypassManager_TEST {
  @isTest
  static void test(){
    DCE_BypassManager.allowUntil('AP123',1);
    DCE_BypassManager.isAllowed('AP123');
    DCE_BypassManager.isAllowed('AP123');
  }
}