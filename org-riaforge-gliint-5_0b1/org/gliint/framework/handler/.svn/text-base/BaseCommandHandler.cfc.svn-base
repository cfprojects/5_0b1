<cfcomponent displayname="BaseCommandHandler" output="false" >
<!---
Base Class for Gliint based CommandHandlers; Must be subclassed.

Follows the command design pattern, a.k.a Handler, executes it's unique functionality.
Creates result objects to be used on return of it's execute method, which must be
overridden. By extending this component, authors can create controller commands which bridge
to model components maintained by the bean factory.

Handles exceptions thrown during execution.

Can mixin additional methods.

Is Bean factory aware.

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
		<td>access</td>
		<td>public</td>
		<td>determines if it can be used as an event handler</td>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
	</tr>
	<tr>
		<td>comment</td>
		<td>&nbsp;</td>
		<td>optional; a description of the functionality provided</td>
	</tr>
	<tr>
		<td>name</td>
		<td>#getMetaData( this ).name#</td>
		<td>the name of this commandHandler</td>
	</tr>
	<tr>
		<td>resultClass</td>
		<td>org.gliint.framework.util.Result</td>
		<td>dotted path notation to the component to be instantiated for Result objects</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>if true, when ColdFusion debugging is on traces will be written</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>org.gliint.framework.util.SizedDeque
--->
<!---
org.gliint.framework.handler.BaseCommandHandler

Copyright (c) 2008-2009 Mitchell M. Rose
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
	<cfset variables['properties']['access'] = "public" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['comment'] = "" />
	<cfset variables['properties']['name'] = "#getMetaData( this ).name#" />
	<cfset variables['properties']['resultClass'] = "org.gliint.framework.util.Result" />
	<cfset variables['properties']['shouldTrace'] = false />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.BaseCommandHandler" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" hint="the Command to execute" />
		<cfargument name="context" type="any" required="true" hint="the Context to execute it in" />

		<cfset var result = true />

		<cfthrow type="Method.NotImplemented" message="The BaseCommandHandler's execute method is abstract and must be overridden" />

		<cftry>

			<!--- your code goes here --->

			<cfcatch type="any" >
				<cfset handleException( cfcatch, result, arguments.context )>
			</cfcatch>
		</cftry>

		<cfreturn result />
	</cffunction>


	<cffunction name="mixin" access="public" returntype="void" output="false">
		<cfargument name="name" required="true" type="string" />
		<cfargument name="func" required="true" type="any" />

		<cfset this[arguments.name] = arguments.func />
		<cfset variables[arguments.name] = arguments.func />

	</cffunction>


	<!--- public primarily for testing purposes, but might prove useful --->
	<cffunction name="newResult" access="public" returntype="any" output="false">
		<cfset var r = createObject( 'component', getResultClass() ).init() />
		<cfreturn r />
	</cffunction>


	<cffunction name="handleException" access="private" returntype="void" output="false">
		<cfargument name="exception" required="true" />
		<cfargument name="result" required="true" type="any" />
		<cfargument name="context" type="any" required="true" />

		<cfset var e = arguments.exception />
		<cfset var cxt = arguments.context />
		<cfset var i = 0 />
		<cfset var ec = structNew() />
		<cfset var tc = "" />

		<!---
		note that this method does NOT create and enqueue an exception command, since we cannot
		guarantee that something hasn't gone wrong with initialization or configuration
		and we don't want to get in an endless loop
		In fact, since gliint doesn't write views, we NEVER need to create and enqueue an exception command
		--->

		<!--- we'll ignore this exception, which is thrown when cflocation runs --->
		<cfif ( structKeyExists( e, 'RootCause' ) )
			and	( structKeyExists( e.RootCause, 'Type' ) )
			and ( e.RootCause.Type eq 'coldfusion.runtime.AbortException' ) >
			<cfreturn>
		</cfif>

		<!--- place in responses --->
		<cfset cxt.setResponse( '_exception', arguments.exception ) />

		<cfparam name="e.type" default="commandHandlerRuntimeException" />
		<cfparam name="e.message" default="an exception occurred" />
		<cfparam name="e.detail" default="" />
		<cfparam name="e.extendedInfo" default="" />
		<cfparam name="e.errorCode" default="500" />
		<cfparam name="e.tagContext" default="#arrayNew(1)#" />

		<!--- show tagContext in trace --->
		<cfloop from="1" to="#arrayLen( e.tagContext )#" index="i">
			<cfset ec = e.tagContext[i] />
			<cfset tc = tc & "<br>#i#. #ec['TEMPLATE']# (line #ec['LINE']#)" />
		</cfloop>

		<cfif isObject( arguments.result ) >
			<cfset arguments.result.setType( e.type ) />
			<cfset arguments.result.setMessage( e.message ) />
			<cfset arguments.result.setDetail( e.detail ) />
			<cfset arguments.result.setExtendedInfo( e.extendedInfo ) />
			<cfset arguments.result.setCode( e.errorCode ) />
		</cfif>

		<!--- always trace exceptions! --->
		<cftrace type="fatal information" text="EXCEPTION #e.message# #e.detail# #tc#" />
	</cffunction>

	<!--- getters/setters/etctters --------------------------------------------->


	<cffunction name="getHandlingMethod" access="public" returntype="string" output="false">
		<cfreturn 'execute' />
	</cffunction>


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory" />
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getAccess" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['access'] />
	</cffunction>


	<cffunction name="setAccess" access="public" returntype="void" output="false">
		<cfargument name="access" type="string" required="true" />
		<cfset variables['properties']['access'] = arguments.access />
	</cffunction>


	<cffunction name="getComment" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['comment'] />
	</cffunction>


	<cffunction name="setComment" access="public" returntype="void" output="false">
		<cfargument name="comment" type="string" required="true" />
		<cfset variables['properties']['comment'] = arguments.comment />
	</cffunction>


	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['name'] />
	</cffunction>


	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset variables['properties']['name'] = arguments.name />
	</cffunction>


	<cffunction name="getProperties" access="public" returntype="struct" output="false">
		<cfreturn variables['properties'] />
	</cffunction>


	<cffunction name="getProperty" access="public" returntype="any" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn variables['properties'][arguments.propertyName] />
	</cffunction>


	<cffunction name="setProperty" access="public" returntype="void" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfargument name="propertyValue" required="true" type="any" />
		<cfset variables['properties'][arguments.propertyName] = arguments.propertyValue />
	</cffunction>


	<cffunction name="isPropertyDefined" access="public" returntype="boolean" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn structKeyExists( variables['properties'], arguments.propertyName ) />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" returntype="boolean" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


	<cffunction name="setResultClass" access="public" returntype="void" output="false">
		<cfargument name="resultClass" type="string" required="true" />
		<cfset variables['properties']['resultClass'] = arguments.resultClass />
	</cffunction>


	<cffunction name="getResultClass" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['resultClass'] />
	</cffunction>

</cfcomponent>