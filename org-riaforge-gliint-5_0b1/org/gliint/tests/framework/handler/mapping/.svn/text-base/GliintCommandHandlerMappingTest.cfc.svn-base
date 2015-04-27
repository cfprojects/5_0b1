<cfcomponent name="GliintCommandHandlerMappingTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.handler.mapping.GliintCommandHandlerMapping' ) />
  </cffunction>

  <cffunction name="testgetMulticastHandler" access="public" returnType="void">
    <cfset var c = this.bf.getBean( 'commandFactory' ).createCommand( 'DigAPony', 'multicast', structNew(), true ) />
    <cfset var hec = this.myComp.getHandler(c) />
    <cfset assertIsTypeOf( hec, 'org.gliint.framework.HandlerExecutionChain' ) />
    <cfset assertIsTypeOf( hec.getHandler(), 'org.gliint.framework.lexicon.Multicast' ) />
  </cffunction>

  <cffunction name="testgetNotifyHandler" access="public" returnType="void">
    <cfset var c = this.bf.getBean( 'commandFactory' ).createCommand( 'IAmTheWalrus', 'notify', structNew(), true ) />
    <cfset var hec = this.myComp.getHandler(c) />
    <cfset assertIsTypeOf( hec, 'org.gliint.framework.HandlerExecutionChain' ) />
    <cfset assertIsTypeOf( hec.getHandler(), 'org.gliint.framework.lexicon.Notify' ) />
  </cffunction>

  <cffunction name="testgetNamedHandler" access="public" returnType="void">
    <cfset var c = this.bf.getBean( 'commandFactory' ).createCommand( 'namedHandler', 'name', structNew(), true ) />
    <cfset var hec = this.myComp.getHandler(c) />
    <cfset assertIsTypeOf( hec, 'org.gliint.framework.HandlerExecutionChain' ) />
    <cfset assertIsTypeOf( hec.getHandler(), 'org.gliint.framework.lexicon.Nop' ) />
  </cffunction>

  <cffunction name="testgetBeanNotFoundHandler" access="public" returnType="void">
    <cfset var c = this.bf.getBean( 'commandFactory' ).createCommand( 'HereComesTheSun', 'name', structNew(), true ) />
    <cfset var hec = this.myComp.getHandler(c) />
    <cfset assertIsTypeOf( hec, 'org.gliint.framework.HandlerExecutionChain' ) />
    <cfset assertIsTypeOf( hec.getHandler(), 'org.gliint.framework.lexicon.Nop' ) />
  </cffunction>

  <cffunction name="testinvalidAccessHandler" access="public" returnType="void">
    <cfset var c = this.bf.getBean( 'commandFactory' ).createCommand( 'warnInvalidAccess', 'name', structNew(), true ) />
    <cfset var hec = this.myComp.getHandler(c) />
    <cfset assertIsTypeOf( 'org.gliint.framework.HandlerExecutionChain', hec ) />
    <cfset assertIsTypeOf( hec.getHandler(), 'org.gliint.framework.lexicon.Warn' ) />
  </cffunction>

<!--- NOT testing getters and setters

  <cffunction name="testgetBeanFactory" access="public" returnType="void">
    <cfset fail("Test testgetBeanFactory not implemented")>
  </cffunction>

  <cffunction name="testgetBroadcastHandler" access="public" returnType="void">
    <cfset fail("Test testgetBroadcastHandler not implemented")>
  </cffunction>

  <cffunction name="testgetNotifyHandler" access="public" returnType="void">
    <cfset fail("Test testgetNotifyHandler not implemented")>
  </cffunction>

  <cffunction name="testgetShouldTrace" access="public" returnType="void">
    <cfset fail("Test testgetShouldTrace not implemented")>
  </cffunction>

  <cffunction name="testsetBeanFactory" access="public" returnType="void">
    <cfset fail("Test testsetBeanFactory not implemented")>
  </cffunction>

  <cffunction name="testsetBroadcastHandler" access="public" returnType="void">
    <cfset fail("Test testsetBroadcastHandler not implemented")>
  </cffunction>

  <cffunction name="testsetNotifyHandler" access="public" returnType="void">
    <cfset fail("Test testsetNotifyHandler not implemented")>
  </cffunction>

  <cffunction name="testsetShouldTrace" access="public" returnType="void">
    <cfset fail("Test testsetShouldTrace not implemented")>
  </cffunction>

--->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structnew(), structnew() ) />
    <cfset this.bf.loadBeansFromXmlFile( '/org/gliint/tests/resources/coldspring.gliint.cfg.xml' ) />
    <cfset this.myComp = this.bf.getBean( 'gliintCommandHandlerMapping' ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>
