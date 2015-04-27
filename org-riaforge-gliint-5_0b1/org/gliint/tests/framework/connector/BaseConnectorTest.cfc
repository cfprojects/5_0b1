<cfcomponent name="BaseConnectorTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetTraceQuery" access="public" returnType="void">
    <!--- debugging must be enabled for this test to pass --->
    <cfset assertIsQuery( this.myComp.getTraceQuery() ) />
  </cffunction>

  <cffunction name="testhasProperty" access="public" returnType="void">
    <cfset assertTrue( this.myComp.hasProperty('theBeatles') ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.connector.BaseConnector' ) />
  </cffunction>

  <cffunction name="testpreHandle" access="public" returnType="void">
    <cfset var r = structNew() />
    <cfset this.myComp.preHandle( 'request', r, 'any' ) />
    <cfset assertTrue( structKeyExists(r, '_timestamp' ) ) />
  </cffunction>

  <cffunction name="testpostHandle" access="public" returnType="void">
    <cfset var success = false />
    <cftry>
      <cfset this.myComp.postHandle( 'request', structNew(), 'any' ) />
      <cfcatch type="Method.NotImplemented" >
        <!--- should throw exception --->
        <cfset success = true />
      </cfcatch>
    </cftry>
    <cfset assert(success) />
  </cffunction>

  <cffunction name="testgetProperty" access="public" returnType="void">
    <cfset var ret = this.myComp.getProperty('theBeatles') />
    <cfset assertTrue( ret['Ringo'] eq 'drums' ) />
  </cffunction>

<!--- not testing getters and setters

  <cffunction name="testgetConfiguration" access="public" returnType="void">
    <cfset this.myComp.setConfiguration( 'theBeatles' ) />
    <cfset assertTrue( this.myComp.getConfiguration() eq 'theBeatles' ) />
  </cffunction>

--->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset var st = structNew() />
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.connector.BaseConnector').init() />
    <cfset st['theBeatles'] = structNew() />
    <cfset st['theBeatles']['John'] = 'rhythm' />
    <cfset st['theBeatles']['Paul'] = 'bass' />
    <cfset st['theBeatles']['George'] = 'lead' />
    <cfset st['theBeatles']['Ringo'] = 'drums' />
    <cfset this.myComp.setConfiguration( st ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

