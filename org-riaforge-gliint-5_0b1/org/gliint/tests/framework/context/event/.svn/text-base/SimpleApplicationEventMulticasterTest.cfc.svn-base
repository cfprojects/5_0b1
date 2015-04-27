<cfcomponent name="SimpleApplicationEventMulticasterTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testaddApplicationListener" access="public" returnType="void">
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var listeners = structNew() />
    <cfset this.myComp.setCollectionClass( structNew() ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertIsTypeOf( listeners['org.gliint.framework.context.BaseApplicationListener'], 'org.gliint.framework.context.BaseApplicationListener' ) />

    <cfset this.myComp.setCollectionClass( arrayNew(1) ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertIsTypeOf( listeners[1], 'org.gliint.framework.context.BaseApplicationListener' ) />

  </cffunction>

<!---
  <cffunction name="testgetApplicationListeners" access="public" returnType="void">
    <cfset fail("Test testgetApplicationListeners not implemented") />
  </cffunction>
--->

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.context.event.SimpleApplicationEventMulticaster' ) />
  </cffunction>

  <cffunction name="testmulticastEvent" access="public" returnType="void">
    <cfset var fail = true />
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var type = "" />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cftry>
      <cfset this.myComp.multicastEvent( 'someEvent' ) />
      <cfcatch type="any">
        <cfset fail = false />
        <cfset type = cfcatch.type />
      </cfcatch>
    </cftry>
    <cfset assertIsTypeOf( listener, 'org.gliint.framework.context.BaseApplicationListener' ) />
    <cfset assertTrue( type eq 'Method.NotImplemented' ) />
    <cfset assertFalse( fail ) />
  </cffunction>

  <cffunction name="testremoveAllListeners" access="public" returnType="void">
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var listeners = structNew() />
    <cfset this.myComp.setCollectionClass( arrayNew(1) ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertIsTypeOf( listeners[3], 'org.gliint.framework.context.BaseApplicationListener' ) />
    <!-- now there are three listeners and we've proved it --->
    <cfset this.myComp.removeAllListeners() />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertTrue( arrayLen( listeners) eq 0 ) />
  </cffunction>

  <cffunction name="testremoveApplicationListener" access="public" returnType="void">
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var listeners = structNew() />

    <!--- if the collectionClass is a struct --->
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertIsTypeOf( listeners['org.gliint.framework.context.BaseApplicationListener'], 'org.gliint.framework.context.BaseApplicationListener' ) />
    <!--- ok, it's there, now remove it --->
    <cfset this.myComp.removeApplicationListener( 'org.gliint.framework.context.BaseApplicationListener' ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertTrue( structIsEmpty( listeners ) ) />

    <!--- if the collectionClass is an array --->
    <cfset this.myComp.setCollectionClass( arrayNew(1) ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertIsTypeOf( listeners[3], 'org.gliint.framework.context.BaseApplicationListener' ) />
    <!--- now there are three listeners and we've proved it --->
    <cfset this.myComp.removeApplicationListener( 'org.gliint.framework.context.BaseApplicationListener' ) />
    <cfset listeners = this.myComp.getApplicationListeners() />
    <cfset assertTrue( arrayLen( listeners) eq 0 ) />

  </cffunction>

<!---
  <cffunction name="testsetCollectionClass" access="public" returnType="void">
    <cfset this.myComp.setCollectionClass( arrayNew(1) ) />
    <cfset fail("Test testsetCollectionClass not implemented - need mock")>
  </cffunction>
--->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.context.event.SimpleApplicationEventMulticaster' ).init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>