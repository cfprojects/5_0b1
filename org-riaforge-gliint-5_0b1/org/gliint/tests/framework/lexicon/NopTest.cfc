<cfcomponent name="NopTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testexecute" access="public" returnType="void">
    <cfset fail("Test testexecute not implemented")>
  </cffunction>

<!--- NOT testing private functions yet --->

<!--- NOT testing getters, setters --->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structnew(), structnew() ) />
    <cfset this.bf.loadBeansFromXmlFile( '/org/gliint/tests/resources/coldspring-gliint-include-test.xml' ) />
    <cfset this.myComp = this.bf.getBean( 'Nop' ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>