
<cfcomponent name="BeanerTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testfill" access="public" returnType="void">
    <cfset fail("Test testfill not implemented (private - need mock)")>
  </cffunction>

  <cffunction name="testgetBeanByClass" access="public" returnType="void">
    <cfset var class = "org.gliint.tests.util.testBean" />
    <cfset var st = structNew() />
    <cfset st.firstName = "george" />
    <cfset st.lastName = "harrison" />
    <cfset assertIsTypeOf( this.myComp.getBeanByClass( class, st ), class  ) />
  </cffunction>

  <cffunction name="testgetBeanByFactory" access="public" returnType="void">
    <cfset var factoryBean = "testBean" />
    <cfset var factoryMethod = "init" />
    <cfset var st = structNew() />
    <cfset st.firstName = "george" />
    <cfset st.lastName = "harrison" />
    <cfset assertIsTypeOf( this.myComp.getBeanByFactory( 'testBean', 'init', st ), 'TestBean'  ) />
  </cffunction>

  <cffunction name="testgetFieldCollectionName" access="public" returnType="void">
    <cfset this.myComp.setFieldCollectionName( 'ringo' ) />
    <cfset assertTrue( this.myComp.getFieldCollectionName() eq 'ringo' ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.util.Beaner' ) />
  </cffunction>

  <cffunction name="testlistFunctions" access="public" returnType="void">
    <cfset fail("Test testlistFunctions not implemented (private - need mock)")>
  </cffunction>

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset var bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset bf.loadBeansFromXmlFile( '\org\gliint\tests\resources\lexicon1.xml' ) />
    <cfset this.myComp = createObject( 'component', 'org.gliint.util.Beaner' ).init( bf ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

