# Apex Dynamic Code Execution
Apex Library to dynamically prevent/allow code execution
Test Coverage : 100%

This Library aims to dynamically control code execution in apex, validation rule and workflow rule / Process Builder.

## Getting Started

Here we go !

### Installing

<a href="https://githubsfdeploy.herokuapp.com?owner=scolladon&repo=DCE">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>


### Trigger

In order to apply the dynamic code execution, wrap you code in a if statement :
```java
trigger myTrigger on myObject (after update) {
  if(DCE_BypassManager.isAllowed('myTrigger')) {
    MyObjectTriggerDelegate();
  } 
}
```

If you user as the value "myTrigger" selected in the multipicklist DCE_TriggerBlackList__c the DCE_BypassManager.isAllowed('myTrigger') condition will be false.

You can force to prevent all in your code or in your script either by checking the field DCE_AllTrigger__c or by setting the preventAll boolean to true dynamically :
```java
DCE_BypassManager.preventAll = true;
```

You can force to prevent execution after n execution :
```java
DCE_BypassManager.allowUntil('myTrigger', 2);
```
This way the trigger myTrigger will be executed 2 times.

### Validation Rule

In order to by pass validation rule you can configure your user with the multipicklist DCE_VBL__c to filter what you want to prevent or you can use the checkbox DCE_AV__c to prevent all.
Then configure you're validation rule this way :
```java
Not($User.DCE_AV__c) &&  NOT(INCLUDES($User.DCE_VBL__c,'MyValidationRule')) && MyConditions
```

### Workflow Rule, Process Builder
In order to by pass Workflow rule or Process Buidler you can configure your user with the multipicklist DCE_WBL__c to filter what you want to prevent or you can use the checkbox DCE_AW__c to prevent all.
Then configure you're workflow rule / Process Builder this way :
```java
Not($User.DCE_AW__c) &&  NOT(INCLUDES($User.DCE_WBL__c,'MyValidationRule')) && MyConditions
```

## Authors

* **Sebastien Colladon** - *Initial work* - [scolladon](https://github.com/scolladon)