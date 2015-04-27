<cfcomponent name="DefaultWebApplicationContextTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testaddApplicationListener" access="public" returnType="void">
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var listeners = structNew() />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getBean( 'simpleApplicationEventMulticaster' ).getApplicationListeners() />
    <cfset assertIsTypeOf( listeners['org.gliint.framework.context.BaseApplicationListener'], 'org.gliint.framework.context.BaseApplicationListener'  ) />

    <cfset this.myComp.getBean( 'simpleApplicationEventMulticaster' ).setCollectionClass( arrayNew(1) ) />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cfset listeners = this.myComp.getBean( 'simpleApplicationEventMulticaster' ).getApplicationListeners() />
    <cfset assertIsTypeOf( listeners[1], 'org.gliint.framework.context.BaseApplicationListener' ) />
  </cffunction>

  <cffunction name="testcontainsBean" access="public" returnType="void">
  <!--- does NOT ascend a hierarchy, if it exists, to determine if parents contain the bean requested --->
  <!---
    <cfset var bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset var parent = createObject( 'component', 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
    <cfset bf.loadBeansFromXmlFile( '\org\gliint\tests\resources\defaultWebApplicationContextTest2.coldspring.cfg.xml' ) />
    <cfset parent.setBeanFactory( bf ) />
    <cfset this.myComp.setParent( parent ) />
  --->
    <cfset assertTrue( this.myComp.containsBean( 'Nop' ) ) />
  </cffunction>

  <cffunction name="testcontainsLocalBean" access="public" returnType="void">
    <cfset assertTrue( this.myComp.containsLocalBean( 'Nop' ) ) />
  </cffunction>

  <cffunction name="testgetBean" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp.getBean( 'Nop' ), 'org.gliint.framework.lexicon.Nop' ) />
  </cffunction>

  <cffunction name="testgetBeanFactory" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp.getBeanFactory(), 'coldspring.beans.DefaultXmlBeanFactory' ) />
  </cffunction>

  <cffunction name="testgetConfigLocations" access="public" returnType="void">
    <cfset var a = arrayNew(1) />
    <cfset var a2 = arrayNew(1) />
    <cfset a[1] = "DontPassMeBy" />
    <cfset a[2] = "DontLetMeDown" />
    <cfset this.myComp.setConfigLocations(a) />
    <cfset a2 = this.myComp.getConfigLocations() />
    <cfset assertTrue( a2[2] eq 'DontLetMeDown' ) />
  </cffunction>

  <cffunction name="testgetDisplayname" access="public" returnType="void">
    <cfset this.myComp.setDisplayname( 'Linda' ) />
    <cfset assertTrue( this.myComp.getDisplayname() eq 'Linda' ) />
  </cffunction>

  <cffunction name="testgetId" access="public" returnType="void">
    <cfset assertTrue( len( this.myComp.getID() ) gt 0 ) />
  </cffunction>

  <cffunction name="testgetNamespace" access="public" returnType="void">
    <!--- namespace can be a string, but it also might be a struct --->
    <cfset this.myComp.setNamespace( 'HerMajesty' ) />
    <cfset assertTrue ( this.myComp.getNamespace() eq  'HerMajesty' ) />
  </cffunction>

  <cffunction name="testgetParent" access="public" returnType="void">
    <cfset var parent = createObject( 'component', 'org.gliint.framework.context.AbstractWebApplicationContext' ) />
    <cfset this.myComp.setParent( parent ) />
    <cfset assertIsTypeOf( this.myComp.getParent(), 'org.gliint.framework.context.AbstractWebApplicationContext' ) />
  </cffunction>

  <cffunction name="testgetParentBeanFactory" access="public" returnType="void">
    <cfset var bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset var parent = createObject( 'component', 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
    <cfset parent.setBeanFactory( bf ) />
    <cfset this.myComp.setParent( parent ) />
    <cfset assertIsTypeOf( this.myComp.getParentBeanFactory(), 'coldspring.beans.DefaultXmlBeanFactory' ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertTrue( isObject( this.myComp.init() ) ) />
  </cffunction>

  <cffunction name="testisActive" access="public" returnType="void">
    <cfset var bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset this.myComp.setBeanFactory( bf ) />
    <cfset assertTrue( this.myComp.isActive() ) />
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

  <cffunction name="testMissingSingleton" access="public" returnType="void">
    <cfset var e = structNew() />
    <cfset var r = false />
    <cftry>
      <!--- should throw an error, since EleanorRigby doesn't exist --->
      <cfset r = this.myComp.isSingleton( 'EleanorRigby' ) />
      <cfcatch type="any">
        <cfset e = cfcatch />
      </cfcatch>
    </cftry>
    <cfset assertTrue( structKeyExists( e, 'type' ) ) />
  </cffunction>

  <cffunction name="testisSingleton" access="public" returnType="void">
    <cfset assertTrue( this.myComp.isSingleton( 'nop' ) ) />
  </cffunction>

  <cffunction name="testpublishEvent" access="public" returnType="void">
    <cfset var fail = true />
    <cfset var listener = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
    <cfset var type = "" />
    <cfset this.myComp.addApplicationListener( listener ) />
    <cftry>
      <cfset this.myComp.publishEvent( 'someEvent' ) />
      <cfcatch type="any">
        <cfset fail = false />
        <cfset type = cfcatch.type />
      </cfcatch>
    </cftry>
    <cfset assertIsTypeOf( listener, 'org.gliint.framework.context.BaseApplicationListener' ) />
    <cfset assertTrue( type eq 'Method.NotImplemented' ) />
    <cfset assertFalse( fail ) />
  </cffunction>

  <cffunction name="testrefresh" access="public" returnType="void">
    <cfset var a = arrayNew(1) />
    <cfset a[1] = "\org\gliint\tests\resources\defaultWebApplicationContextTest2.coldspring.cfg.xml" />
    <cfset this.myComp.setConfigLocations(a) />
    <cfset this.myComp.refresh() />
    <cfset assertTrue( this.myComp.containsBean( 'nop2' ) ) />
  </cffunction>

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset var bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset bf.loadBeansFromXmlFile( '\org\gliint\tests\resources\defaultWebApplicationContextTest.coldspring.cfg.xml' ) />
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.context.DefaultWebApplicationContext' ).init() />
    <cfset this.myComp.setBeanFactory( bf ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>