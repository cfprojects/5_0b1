<cfcomponent displayname="GliintController" output="false" >
<!---
Designed to be a persistent singleton which handles requests from a centralized API utilizing the command pattern.
Typically, the Dispatcher's HandlerMapping resolves (through a HandlerExecutionChain) to the GliintController,
whose handleRequest() method will be invoked. For each request, the GliintController's handleRequest() method
uses it's handleApplicationEvents property and it's CommandFactory's PublicCommandName property to replace
the value of the request, creating a Command instance based on request attributes, then creates a CommandContext
instance to maintain the request's state.

Functionality such as optional validation, form handling, etc should be obtained by creating
CommandHandlers to perform atomic functions. CommandHandlers can also behave like
'controllers', 'listeners', or 'event handlers' as required. The Dispatch commandHandler
(org.gliint.framework.lexicon.Dispatch) is typically composed into the GliintController as its commandDispatcher
to handle the assignment of Commands to CommandHandlers for resolution and execution.

'Boilerplate' functionality used for a majority of use cases can also be placed in interceptors.

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
		<td>beaner</td>
		<td>false</td>
		<td>used to create and optionally fill it with request data</td>
	</tr>
	<tr>
		<td>commandBinding</td>
		<td>name</td>
		<td>optional bind attribute for Command instances which will override the default binding (name), one of 'name','notify', or 'multicast'</td>
	</tr>
	<tr>
		<td>commandContextClass</td>
		<td>org.gliint.framework.command.CommandContext</td>
		<td>dotted notation path to component to be instantiated and used for CommandContext</td>
	</tr>
	<tr>
		<td>commandDispatcher</td>
		<td>false</td>
		<td>used to dispatch requests to registered handlers</td>
	</tr>
	<tr>
		<td>commandFactory</td>
		<td>false</td>
		<td>responsible for the creation of command objects</td>
	</tr>
	<tr>
	<tr>
		<td>handleApplicationEvents</td>
		<td>onRequestStart,onRequestEnd</td>
		<td>a comma delimited list of application events used for event name substitution</td>
	</tr>
		<td>maximumCommands</td>
		<td>100</td>
		<td>the number of commands which can be run within a single CommandContext</td>
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
org.gliint.framework.command.Command, org.gliint.framework.command.CommandContext
	<br/>
--->
<!---
org.gliint.framework.GliintController

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
	<cfset variables['properties']['beaner'] = false />
	<cfset variables['properties']['commandBinding'] = 'name' />
	<cfset variables['properties']['commandContextClass'] = 'org.gliint.framework.command.CommandContext' />
	<cfset variables['properties']['commandDispatcher'] = false />
	<cfset variables['properties']['commandFactory'] = false />
	<cfset variables['properties']['handleApplicationEvents'] = 'onRequestStart,onRequestEnd' />
	<cfset variables['properties']['maximumCommands'] = 100 />
	<cfset variables['properties']['shouldTrace'] = false />

	<!------------------------------------------------------------------------------------->


	<cffunction name="init" access="public" returntype="org.gliint.framework.GliintController" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="handleRequest" access="public" returntype="struct" output="false" >
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<!---
			We're ignoring the handlerExecutionChain provided by the Dispatcher. Our
			BaseConnectors' preHandle() method has already placed it in the response so the
			CommandHandlers can modify it as needed.
			We could also ignore the request argument, as the BaseConnector has also placed it in
			arguments.response['_applicationEvent']
		--->

		<cfset var cmd = "" />
		<cfset var cxt = "" />
		<cfset var num = 0 />
		<cfset var r = arguments.response />
		<cfset var result = false />

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.GliintController: Request #arguments.request# starts" />
		</cfif>

		<!--- n.b. exceptions thrown here are intentionally uncaught, should bubble to onError() --->
		<cfset cmd = requestCommand( arguments.request, arguments.response ) />
		<cfset cxt = createObject( 'component', getCommandContextClass() ).init( this, r, getMaximumCommands(), getCommandFactory(), getBeaner() ) />
		<cfset cxt.enqueueCommand( cmd ) />

		<cfloop condition="cxt.hasCommands()" >

			<cfset num = num + 1 />
			<cfif ( num gt getMaximumCommands() ) >
				<cftrace type="error" text="org.gliint.framework.GliintController: Maximum number of commands () has been exceeded. Terminating Request" />
				<cfbreak />
			</cfif>

			<cfset cmd = cxt.dequeueCommand() />
			<!--- assign a handlerExecutionChain and execute() it --->
			<cfset result = getCommandDispatcher().execute( cmd, cxt ) />
			<cfset r = cxt.getResponses() />

		</cfloop>

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.GliintController: Request #arguments.request# completes" />
		</cfif>

		<cfreturn r />
	</cffunction>


	<!--- internal handler adapter for handleRequest()	--->
	<cffunction name="handle" access="public" returntype="struct" output="false" >
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="handler" type="any" required="true" hint="handlerExecutionChain" />
		<cfreturn handleRequest( arguments.request, arguments.response, arguments.handler ) />
	</cffunction>


	<cffunction name="hasParent" access="public" returntype="boolean" output="false" hint="needed for nestable CommandContexts" >
		<cfreturn false />
	</cffunction>

	<!--- private -------------------------------------------------------------- --->

	<cffunction name="requestCommand" access="private" returntype="any" output="false" hint="Return the Command for this request">
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />

		<cfset var r = arguments.response />
		<cfset var n = getCommandFactory().getPublicCommandName() />

		<!---
			the '_request' struct must exist as a subkey of arguments.response
			see the BaseConnector's preHandle() method
		 --->
		<cfif ( not structKeyExists( r,	'_request' ) ) >
			<cfset r['_request'] = structNew() />
		</cfif>

		<!--- if it's not on the handleApplicationEvent list, use the application event as the command name --->
		<cfif ( listFindNoCase( getHandleApplicationEvents() , arguments.request ) eq 0 ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="org.gliint.framework.GliintController: #arguments.request# is NOT on the list of handleApplicationEvents" />
			</cfif>
			<cfreturn getCommandFactory().createCommand( arguments.request, getCommandBinding(), duplicate(r['_request']), false ) />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.GliintController: #arguments.request# IS on the list of handleApplicationEvents, trying response '#n#'" />
		</cfif>

		<!--- set default. for example, r['event'] = 'default' --->
		<cfset r[n] = getCommandFactory().getPublicCommandDefaultValue() />

		<!--- if it exists, set to the requested 'event' name and value --->
		<cfif ( structKeyExists( r['_request'], n ) ) >
			<cfset r[n] = r['_request'][n] />
		</cfif>

		<cfreturn getCommandFactory().createCommand( r[n], getCommandBinding(), duplicate(r['_request']), false ) />
	</cffunction>


<!--- accessors & mutators ------------------------------------------------------->

	<cffunction name="getBeaner" access="private" returntype="any" output="false">
			<cfreturn variables['properties']['beaner'] />
	</cffunction>


	<cffunction name="setBeaner" access="public" returntype="void" output="false">
		<cfargument name="beaner" type="any" required="true" />
		<cfset variables['properties']['beaner'] = arguments.beaner />
	</cffunction>


	<cffunction name="setCommandBinding" access="public" returntype="void" output="false">
		<cfargument name="commandBinding" required="true" type="string">
		<cfset variables['properties']['commandBinding'] = arguments.commandBinding />
	</cffunction>


	<cffunction name="getCommandBinding" access="private" returntype="string" output="false">
		<cfreturn variables['properties']['commandBinding'] />
	</cffunction>


	<cffunction name="setCommandFactory" access="public" returntype="void" output="false">
		<cfargument name="commandFactory" required="true" type="any">
		<cfset variables['properties']['commandFactory'] = arguments.commandFactory />
	</cffunction>


	<cffunction name="getCommandFactory" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['commandFactory'] />
	</cffunction>


	<cffunction name="setCommandDispatcher" access="public" returntype="void" output="false">
		<cfargument name="commandDispatcher" required="true" type="any">
		<cfset variables['properties']['commandDispatcher'] = arguments.commandDispatcher />
	</cffunction>


	<cffunction name="getCommandDispatcher" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['commandDispatcher'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false" >
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false" >
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


	<cffunction name="setMaximumCommands" access="public" returntype="void" output="false" >
		<cfargument name="maximumCommands" type="numeric" required="true" />
		<cfset variables['properties']['maximumCommands'] = arguments.maximumCommands />
	</cffunction>


	<cffunction name="getMaximumCommands" access="public" reutrntype="numeric" output="false" >
		<cfreturn variables['properties']['maximumCommands'] />
	</cffunction>


	<cffunction name="setCommandContextClass" access="public" returntype="void" output="false" >
		<cfargument name="commandContextClass" type="string" required="true" />
		<cfset variables['properties']['commandContextClass'] = arguments.commandContextClass />
	</cffunction>


	<cffunction name="getCommandContextClass" access="public" reutrntype="string" output="false" >
		<cfreturn variables['properties']['commandContextClass'] />
	</cffunction>


	<cffunction name="setHandleApplicationEvents" access="public" returntype="void" output="false" >
		<cfargument name="handleApplicationEvents" type="string" required="true" />
		<cfset variables['properties']['handleApplicationEvents'] = arguments.handleApplicationEvents />
	</cffunction>


	<cffunction name="getHandleApplicationEvents" access="public" reutrntype="string" output="false" >
		<cfreturn variables['properties']['handleApplicationEvents'] />
	</cffunction>

</cfcomponent>