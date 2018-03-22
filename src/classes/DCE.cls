public without sharing class DCE {
  private static final Map<String,Integer> execNtimes = new Map<String,Integer>();
  public static final Set<String> blacklist = new Set<String>();
  public static Boolean preventAll;
  static{
    User aUser = [SELECT DCE_TriggerBlackList__c,DCE_AllTrigger__c FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1];
    if(String.isNotBlank(aUser.DCE_TriggerBlackList__c)) blacklist.addAll(aUser.DCE_TriggerBlackList__c.split(';'));
    preventAll = aUser.DCE_AllTrigger__c;
  }
  public static boolean isAllowed(final String ele){
    if(preventAll || blacklist.contains(ele)) return false;
    boolean allow = true;
    if(execNtimes.containsKey(ele)) {
      if(execNtimes.get(ele) <= 0) {
        execNtimes.remove(ele);
        allow = false;
      }
      execNtimes.put(ele,execNtimes.get(ele) - 1);
    }
    return allow;
  }

  public static void allowUntil(final String ele, final Integer ntimes) {
    if(ntimes == null || ntimes <= 0)return;
    execNtimes.put(ele,ntimes);
  }
}