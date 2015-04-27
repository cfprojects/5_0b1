<cfcomponent displayname="MultiHandlerMapping" extends="org.gliint.framework.handler.mapping.BaseHandlerMapping" output="false">
<!---
Returns a HandlerExecutionChain for a request if the targetPage is in the list of requesters
Returns FALSE if no match is found.

Really, this one is a bit too naive for most applications and is provided primarily for reference implementations.

This component is bean factory aware, mapped handlers are expected to be found in the bean factory.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
<table class="withBorder" cellpadding="3" cellspacing="">
	<tbody>
	<tr class="" style="bottom-border: 1px black solid;">
		<th><b>name</b></th>
		<th><b>default</b></th>
		<th><b>description</b></th>
	</tr>
	<tr>
		<td>order</td>
		<td>0</td>
		<td>the order value for this HandlerMapping bean</td>
	</tr>
	<tr>
		<td>defaultHandler</td>
		<td>false</td>
		<td>the default handler for this handler mapping</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>if true, when ColdFusion debugging is on traces will be written</td>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
	</tr>
	<tr>
		<td>requesters</td>
		<td>index.cfm</td>
		<td>a list of target pages which will be mapped</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.handler.mapping.MultiHandlerMapping

Copyright (c) 2009 Mitchell M. Rose
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
	<cfset variables['properties'] = structNew() />
	<cfset variables['properties']['shouldTrace'] = false />
	<cfset variables['properties']['order'] = 0 />
	<cfset variables['properties']['defaultHandler'] = false />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['requesters'] = "index.cfm" />

	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.mapping.MultiHandlerMapping" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="any" output="false">

		<cfset var hec = false />
		<cfset var targetPage = getFileFromPath( cgi.PATH_TRANSLATED ) />
		<cfset var bf = getBeanFactory() />
		<cfset var requester = listLast( targetPage, '/' ) />

		<cfif ( listFindNoCase( getRequesters(), requester ) neq 0 ) >
			<cfset hec = createObject( 'component', 'org.gliint.framework.HandlerExecutionChain' ).init( getDefaultHandler() ) />
			<cfif ( isObject( getBeanFactory() ) ) >
				<cfset hec.addInterceptor( bf.getBean( 'htmlConnector' ) ) />
			</cfif>
			<cfif getShouldTrace() >
				<cftrace type="information" text="org.gliint.framework.handler.mapping.MultiHandlerMapping: Created a HandlerExecutionChain with the defaultHandler (#getmetadata( getDefaultHandler() ).name#)" />
				<cftrace type="information" text="org.gliint.framework.handler.mapping.MultiHandlerMapping: Added Interceptor htmlConnector to the HandlerExecutionChain" />
			</cfif>
			<cfreturn hec />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="warning" text="org.gliint.framework.handler.mapping.MultiHandlerMapping: Did NOT create a HandlerExecutionChain" />
		</cfif>
		<cfreturn FALSE />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory">
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false" >
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false" >
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


	<cffunction name="setRequesters" access="public" returntype="void" output="false" >
		<cfargument name="requesters" type="string" required="true" />
		<cfset variables['properties']['requesters'] = arguments.requesters />
	</cffunction>


	<cffunction name="getRequesters" access="public" reutrntype="string" output="false" >
		<cfreturn variables['properties']['requesters'] />
	</cffunction>

</cfcomponent>