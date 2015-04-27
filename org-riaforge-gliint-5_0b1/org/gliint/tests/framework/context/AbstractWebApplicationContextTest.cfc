
<cfcomponent name="AbstractWebApplicationContextTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testaddApplicationListener" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.addApplicationListener( 'TheRollingStones' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testcontainsBean" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.containsBean( 'eightDaysAWeek' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testcontainsLocalBean" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.containsLocalBean( 'revolver' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetBean" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getBean( 'Paul' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetBeanFactory" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getBeanFactory( 'MaxwellsSilverHammer' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetConfigLocations" access="public" returnType="void">
    <cfset var e = structNew() />
    <cfset var a = arrayNew(1) />
    <cftry>
      <cfset a = myComp.getConfigLocations() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetDisplayname" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getDisplayName() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetId" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getId() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetNamespace" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getNamespace() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetParent" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getParent() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testgetParentBeanFactory" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.getParentBeanFactory() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.init() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testisActive" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.isActive( 'John' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testisPrototype" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.isPrototype( 'George' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testisSingleton" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.isSingleton( 'Ringo' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testpublishEvent" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.publishEvent( 'Yoko' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testrefresh" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.refresh() />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testsetConfigLocation" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.setConfigLocation( 'TheresAPlace' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testsetConfigLocations" access="public" returnType="void">
    <cfset var e = structNew() />
    <cfset var a = arrayNew(1) />
    <cftry>
      <cfset myComp.setConfigLocations( a ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testsetNamespace" access="public" returnType="void">
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.setNamespace( 'Julia' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testsetParent" access="public" returnType="void">
    <cfset var context = createObject( 'component', 'org.gliint.framework.context.AbstractWebApplicationContext' ) />
    <cfset var e = structNew() />
    <cftry>
      <cfset myComp.setParent( context ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.framework.context.AbstractWebApplicationContext")>
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

