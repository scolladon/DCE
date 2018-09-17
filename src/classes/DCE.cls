public without sharing class DCE {
  private static final String CACHE_SESSION_NAME = 'DCE';
  private static final Map<String,Integer> execNtimes = new Map<String,Integer>();
  private static final String blacklist;
  public static Boolean preventAll;

  static{
    if (!Cache.Session.isAvailable() || !Cache.Session.contains(CACHE_SESSION_NAME)) {
      final List<String> bypassInfos = new List<String>();
      final User aUser = [SELECT DCE_TriggerBlackList__c,DCE_AllTrigger__c FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1];
      bypassInfos.add(aUser.DCE_AllTrigger__c ? '1' : '0');
      if(String.isNotBlank(aUser.DCE_TriggerBlackList__c)) bypassInfos.addAll(aUser.DCE_TriggerBlackList__c.split(';'));
      for(CustomPermission cp:[SELECT DeveloperName,(SELECT Id FROM Setupentityaccessitems WHERE SetupEntityType='CustomPermission' AND ParentId IN(SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId()) limit 1)FROM CustomPermission where DeveloperName like 'DCE%'])if(cp.SetupEntityAccessItems!=null && cp.SetupEntityAccessItems.size()>0)bypassInfos.add(cp.DeveloperName);
      blacklist = ';' + String.join(bypassInfos,';') + ';';
      Cache.Session.put(CACHE_SESSION_NAME, blacklist);
    } else  {
      blacklist = (String) Cache.Session.get(CACHE_SESSION_NAME);
    }
    preventAll = blacklist.substring(1,2) == '1';
  }

  public static boolean allow(final String ele){
    if(preventAll || blacklist.contains(';'+ele+';')) return false;
    boolean allow = true;
    if(execNtimes.containsKey(ele)) {
      execNtimes.put(ele,execNtimes.get(ele) - 1);
      if(execNtimes.get(ele) == 0) {
        execNtimes.remove(ele);
        allow = false;
      }
    }
    return allow;
  }

  public static void prevent(final String ele) {
    execNtimes.put(ele,-1);
  }

  public static void allowUntil(final String ele, final Integer ntimes) {
    if(ntimes == null)return;
    execNtimes.put(ele,ntimes);
  }
}