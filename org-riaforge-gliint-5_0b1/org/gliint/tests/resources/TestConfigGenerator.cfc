<cfcomponent displayname="TestConfigGenerator" output="false" >
<!---
	org.gliint.test.org.gliint.util.TestConfigGenerator.cfc

	Copyright (c) 2005-2008 Mitchell M. Rose
	All rights reserved.

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
--->
  <cffunction name="init" access="public" returntype="TestConfigGenerator" >
    <cfreturn this />
  </cffunction>

	<!--- if you change this, also change GliintXMLParserTest, ControllerTest, and test.xml --->
	<cffunction name="getTestStruct" access="public" returntype="struct" output="false" >
		<cfset var st = structNew() />
		<cfset st['commandHandlers'] = structNew() />

    <cfset st['commandHandlers']['simplestCommandHandlerEver'] = newCommandHandler() />
		<cfset st['commandHandlers']['simplestCommandHandlerEver']['name'] = 'simplestCommandHandlerEver' />
		<cfset st['commandHandlers']['simplestCommandHandlerEver']['access'] = 'public' />

    <cfset st['commandHandlers']['anotherCommandHandler'] = newCommandHandler() />
		<cfset st['commandHandlers']['anotherCommandHandler']['name'] = 'anotherCommandHandler' />
		<cfset st['commandHandlers']['anotherCommandHandler']['access'] = 'public' />
		<cfset st['commandHandlers']['anotherCommandHandler']['method']['name'] = "listenDoYouWantToKnowASecret" />
		<cfset st['commandHandlers']['anotherCommandHandler']['method']['args']['firstArgument'] = "Paul" />
		<cfset st['commandHandlers']['anotherCommandHandler']['method']['args']['secondArgument'] = "McCartney" />
		<cfset st['commandHandlers']['anotherCommandHandler']['messages']['eightDaysAWeek'] = "the hint" />
		<cfset st['commandHandlers']['anotherCommandHandler']['messages']['yellowSubmarine'] = "glubglub" />

    <cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps'] = newCommandHandler() />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['class'] =  "" />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['name'] = 'aFactoryBeanCommandHandlerWithProps' />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['access'] = 'private' />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['factory-bean'] = 'someFactory' />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['factory-method'] = 'someFactoryBeanMethod' />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['properties'] = structNew() />
		<cfset st['commandHandlers']['aFactoryBeanCommandHandlerWithProps']['properties']['anotherBeatlesSong'] = "Norwegian Wood" />

    <cfset st['commandHandlers']['mockListener'] = newCommandHandler() />
		<cfset st['commandHandlers']['mockListener']['name'] = 'mockListener' />
		<cfset st['commandHandlers']['mockListener']['access'] = 'public' />
		<cfset st['commandHandlers']['mockListener']['class'] = 'org.gliint.test.org.gliint.commandHandler.MockListenerCommandHandler' />
		<cfset st['commandHandlers']['mockListener']['messages']['eightDaysAWeek'] = "the hint" />

		<cfset st['commandHandlers']['mockCommandHandler'] = newCommandHandler() />
		<cfset st['commandHandlers']['mockCommandHandler']['name'] = 'mockCommandHandler' />
		<cfset st['commandHandlers']['mockCommandHandler']['access'] = 'public' />
		<cfset st['commandHandlers']['mockCommandHandler']['class'] = 'org.gliint.test.org.gliint.commandHandler.MockCommandHandler' />
		<cfset st['commandHandlers']['mockCommandHandler']['comment'] = 'this is a comment' />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][1] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][1]['name'] = "response1" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][1]['value'] = 1 />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][2] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][2]['name'] = "response2" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][2]['value'] = "two" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][3] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][3]['name'] = "response3" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][3]['value'] = "${response2}" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][4] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][4]['name'] = "response4" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][4]['value'] = "?{request.response4}" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][5] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][5]['name'] = "response5" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][5]['value'] = "?{nestedStruct.response5}" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][6] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][6]['name'] = "response6" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][6]['value'] = "${notFound}" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][7] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][7]['name'] = "firstName" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][7]['value'] = "John" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][8] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][8]['name'] = "lastName" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][8]['value'] = "Lennon" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['name'] = "mockBean" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['class'] = "org.gliint.test.org.gliint.util.MockBean" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['fields'] = "firstName,lastName" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['args']['aMethodArgumentName'] = "aMethodArgumentValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['args']['anotherMethodArgumentName'] = "anotherMethodArgumentValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][9]['method'] = "hello" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][10] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][10]['name'] = "aMap" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][10]['value'] = structNew() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][10]['value']['aMapKey'] = "aMapValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][10]['value']['anotherMapKey'] = "anotherMapValue" />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['name'] = "aList" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['value'] = arrayNew(1) />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['value'][1] = "aListValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['value'][2] = "aSecondListValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['value'][3] = "aThirdListValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][11]['sequence'] = 28 />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['name'] = "anArrayInsideAMap" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value'] = structNew() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value']['theFirstMapKey'] = "theFirstMapValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value']['theSecondMapKey'] = arrayNew(1) />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value']['theSecondMapKey'][1] = "theFirstArrayValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value']['theSecondMapKey'][2] = "theSecondArrayValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['value']['theSecondMapKey'][3] = "theThirdArrayValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][12]['sequence'] = 29 />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13] = newResponse() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['name'] = "factoryBean" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['factoryBean'] = "MockBean" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['factoryMethod'] = "hello" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['properties']['aFactoryBeanPropertyName'] = "aFactoryBeanPropertyValue" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['properties']['anotherFactoryBeanPropertyName'] = "${aMap}" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['properties']['aThirdFactoryBeanPropertyName'] = "${mockBean}" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['responses'][13]['sequence'] = 30 />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1] = newRule() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['commands'][1] = newCommand('Void', 'verb', 1 ) />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['commands'][1]['args']['argument1'] = "one" />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['commands'][2] = newCommand('eightDaysAWeek', 'message' ) />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['commands'][3] = newCommand('Void', 'name', 3 ) />
    <cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['commands'][4] = newCommand('four', 'name', 4 ) />

		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['conditions'][1] = newCondition() />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['conditions'][1]['conjunction'] = '' />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['conditions'][1]['key'] = 'yesterday' />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['conditions'][1]['operator'] = 'eq' />
		<cfset st['commandHandlers']['mockCommandHandler']['preprocess']['rules'][1]['conditions'][1]['value'] = 'yesterday' />

		<cfset st['commandHandlers']['mockCommandHandler']['properties']['property3'] = 'value3' />
		<cfset st['commandHandlers']['mockCommandHandler']['properties']['property4'] = 'value4' />

		<cfreturn st />
	</cffunction>


  <cffunction name="newCommandHandler" access="private" returntype="struct">
    <cfset var ch = structNew() />
    <cfset ch['name'] = "" />
    <cfset ch['access'] = "" />
    <cfset ch['class'] = "org.gliint.commandHandler.lexicon.Void" />
    <cfset ch['factory-bean'] = "" />
    <cfset ch['factory-method'] = "" />
    <cfset ch['comment'] = "" />
    <cfset ch['method']= newMethod() />
    <cfset ch['postprocess'] = structNew() />
		<cfset ch['postprocess']['responses'] = arrayNew(1) />
		<cfset ch['postprocess']['rules'] = arrayNew(1) />
    <cfset ch['preprocess']= structNew() />
		<cfset ch['preprocess']['responses'] = arrayNew(1) />
		<cfset ch['preprocess']['rules'] = arrayNew(1) />
    <cfset ch['properties'] = structNew() />
    <cfset ch['messages'] = structNew() />
    <cfreturn ch />
  </cffunction>


  <cffunction name="newMethod" access="private" returntype="struct">
    <cfset var m = structNew() />
    <cfset m['name'] = "execute" />
    <cfset m['args'] = structNew() />
    <cfreturn m />
  </cffunction>


  <cffunction name="newResponse" access="private" returntype="struct">
    <cfset var r = structNew() />
		<cfset r['name'] = "" />
		<cfset r['value'] = "" />
		<cfset r['class'] = "" />
		<cfset r['factoryBean'] = "" />
		<cfset r['factoryMethod'] = "" />
		<cfset r['fields'] = "" />
		<cfset r['method'] = "" />
    <cfset r['sequence'] = 0 />
		<cfset r['args'] = structNew() />
    <cfset r['properties'] = structNew() />
    <cfreturn r />
  </cffunction>


  <cffunction name="newRule" access="private" returntype="struct">
    <cfset var r = structNew() />
		<cfset r['commands'] = arrayNew(1) />
		<cfset r['conditions'] = arrayNew(1) />
		<cfset r['onMatch'] = "next" />
		<cfset r['salience'] = 1 />
    <cfreturn r />
  </cffunction>


  <cffunction name="newCommand" access="private" returntype="struct">
    <cfargument name="name" type="string" required="false" default="Void" />
    <cfargument name="bind" type="string" required="false" default="verb" />
    <cfargument name="sequence" type="numeric" required="false" default="0" />

    <cfset var c = structNew() />
		<cfset c['args'] = structNew() />
		<cfset c['name'] = arguments.name />
		<cfset c['bind'] = arguments.bind /><!--- not as default, required --->
		<cfset c['sequence'] = arguments.sequence />
    <cfreturn c />
  </cffunction>


  <cffunction name="newCondition" access="private" returntype="struct">
    <cfset var c = structNew() />
		<cfset c['conjunction'] = "" />
		<cfset c['key'] = ""  />
		<cfset c['operator'] = "" />
		<cfset c['value'] = "" />
    <cfreturn c />
  </cffunction>

</cfcomponent>