<cfcomponent name="ResponseInterceptorTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.handler.BaseHandlerInterceptor' ) />
	</cffunction>

<!---
	<cffunction name="testpreHandle" access="public" returnType="void">
		<cfset var r = structNew() />
		<cfset var gc = createObject("component","org.gliint.framework.GliintController")>
		<cfset var context = createObject( 'component', 'org.gliint.framework.command.CommandContext' ) />
		<cfset var cf = createObject( 'component', 'org.gliint.framework.command.CommandFactory' ).init() />
		<cfset var command = cf.createCommand( 'LetItBe' ) />
		<cfset gc.setCommandFactory( cf ) />
		<cfset context.init( gc, r, 30, false, false ) />
		<cfset this.myComp.preHandle( command, context ) />
		<cfset assertTrue( context.getResponse('response1') eq 1 ) />
		<cfset fail('more tests to do' ) />
	</cffunction>

	<cffunction name="testpostHandle" access="public" returnType="void">
		<cfset fail("not yet coded")>
	</cffunction>
--->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset var beaner = createObject( 'component', 'org.gliint.framework.util.Beaner').init() />
		<cfset var valueParser = createObject( 'component', 'org.gliint.framework.util.ValueParser' ).init() />
		<cfset var configuration = structNew() />
		<cfset configuration['preHandle'] = arrayNew(1) />
		<cfset configuration['postHandle'] = arrayNew(1) />

		<cfset configuration['preHandle'][1] = structNew() />
		<cfset configuration['preHandle'][1]['name'] = "response1" />
		<cfset configuration['preHandle'][1]['value'] = 1 />
<!---
		<cfset configuration['preHandle'][2] = structNew() />
		<cfset configuration['preHandle'][2]['name'] = "response2" />
		<cfset configuration['preHandle'][2]['value'] = "two" />

		<cfset configuration['preHandle'][3] = structNew() />
		<cfset configuration['preHandle'][3]['name'] = "response3" />
		<cfset configuration['preHandle'][3]['value'] = "g${response2}" />

		<cfset configuration['preHandle'][4] = structNew() />
		<cfset configuration['preHandle'][4]['name'] = "response4" />
		<cfset configuration['preHandle'][4]['value'] = "g?{request.response4}" />

		<cfset configuration['preHandle'][5] = structNew() />
		<cfset configuration['preHandle'][5]['name'] = "response5" />
		<cfset configuration['preHandle'][5]['value'] = "g?{nestedStruct.response5}" />

		<cfset configuration['preHandle'][6] = structNew() />
		<cfset configuration['preHandle'][6]['name'] = "response6" />
		<cfset configuration['preHandle'][6]['value'] = "g?{notFound}" />

		<cfset configuration['preHandle'][7] = structNew() />
		<cfset configuration['preHandle'][7]['name'] = "firstName" />
		<cfset configuration['preHandle'][7]['value'] = "John" />

		<cfset configuration['preHandle'][8] = structNew() />
		<cfset configuration['preHandle'][8]['name'] = "lastName" />
		<cfset configuration['preHandle'][8]['value'] = "Lennon" />

		<cfset configuration['preHandle'][9] = structNew() />
		<cfset configuration['preHandle'][9]['name'] = "mockBean" />
		<cfset configuration['preHandle'][9]['class'] = "org.gliint.test.org.gliint.util.MockBean" />
		<cfset configuration['preHandle'][9]['fields'] = "firstName,lastName" />
		<cfset configuration['preHandle'][9]['args']['aMethodArgumentName'] = "aMethodArgumentValue" />
		<cfset configuration['preHandle'][9]['args']['anotherMethodArgumentName'] = "anotherMethodArgumentValue" />
		<cfset configuration['preHandle'][9]['method'] = "hello" />

		<cfset configuration['preHandle'][10] = structNew() />
		<cfset configuration['preHandle'][10]['name'] = "aMap" />
		<cfset configuration['preHandle'][10]['value'] = structNew() />
		<cfset configuration['preHandle'][10]['value']['aMapKey'] = "aMapValue" />
		<cfset configuration['preHandle'][10]['value']['anotherMapKey'] = "anotherMapValue" />

		<cfset configuration['preHandle'][11] = structNew() />
		<cfset configuration['preHandle'][11]['name'] = "aList" />
		<cfset configuration['preHandle'][11]['value'] = arrayNew(1) />
		<cfset configuration['preHandle'][11]['value'][1] = "aListValue" />
		<cfset configuration['preHandle'][11]['value'][2] = "aSecondListValue" />
		<cfset configuration['preHandle'][11]['value'][3] = "aThirdListValue" />

		<cfset configuration['preHandle'][12] = structNew() />
		<cfset configuration['preHandle'][12]['name'] = "anArrayInsideAMap" />
		<cfset configuration['preHandle'][12]['value'] = structNew() />
		<cfset configuration['preHandle'][12]['value']['theFirstMapKey'] = "theFirstMapValue" />
		<cfset configuration['preHandle'][12]['value']['theSecondMapKey'] = arrayNew(1) />
		<cfset configuration['preHandle'][12]['value']['theSecondMapKey'][1] = "theFirstArrayValue" />
		<cfset configuration['preHandle'][12]['value']['theSecondMapKey'][2] = "theSecondArrayValue" />
		<cfset configuration['preHandle'][12]['value']['theSecondMapKey'][3] = "theThirdArrayValue" />

		<cfset configuration['preHandle'][13] = structNew() />
		<cfset configuration['preHandle'][13]['name'] = "factoryBean" />
		<cfset configuration['preHandle'][13]['factoryBean'] = "MockBean" />
		<cfset configuration['preHandle'][13]['factoryMethod'] = "hello" />
		<cfset configuration['preHandle'][13]['properties']['aFactoryBeanPropertyName'] = "aFactoryBeanPropertyValue" />
		<cfset configuration['preHandle'][13]['properties']['anotherFactoryBeanPropertyName'] = "g${aMap}" />
		<cfset configuration['preHandle'][13]['properties']['aThirdFactoryBeanPropertyName'] = "g${mockBean}" />
--->
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.handler.ResponseInterceptor' ).init() />
		<cfset this.myComp.setBeaner( beaner ) />
		<cfset this.myComp.setValueParser( valueParser ) />
		<cfset this.myComp.setConfiguration( configuration ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>