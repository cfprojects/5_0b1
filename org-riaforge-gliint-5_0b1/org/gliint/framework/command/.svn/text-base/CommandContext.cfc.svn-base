<cfcomponent displayname="CommandContext" output="false" >
<!---
A per-request transient created by the GliintController which provides the primary API for Gliint CommandHandlers.
Utilizes a sized deque to allow commands to be either queued or stacked. Holds the responses struct (map) which contains
the variables necessary for processing. Is initialized with a commandFactory, allowing it to delegate to the factory to
create commands, and a beaner, a component which creates transient beans to assist in enabling processing.

CommandContexts are nestable (if needed) simply by setting the parent;
the ultimate parent is GliintController, which provides necessary instance variables when the CommandContext is
initialized.

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
		<td>deque</td>
		<td>false</td>
		<td>a sized, linear collection that supports element insertion and removal at both ends.</td>
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
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private parent</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_any">any</a></div>
				<div class="summaryTableDescription">Parent of context, typically the GliintController or another CommandContext</div>
		</td>
	</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private responses</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_struct">struct</a></div>
				<div class="summaryTableDescription">A structure (map) with instance specific name/value pairs which will be used for output rendering</div>
		</td>
	</tr>
	</tbody>
</table>

--->
<!---
org.gliint.framework.command.CommandContext

Copyright (c) 2005-2009 Mitchell M. Rose
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
	<cfset variables['properties']['deque'] = false />
	<cfset variables['properties']['shouldTrace'] = false />

	<cfset variables['instance'] = structNew() />
	<cfset variables['instance']['parent'] = false />
	<cfset variables['instance']['responses'] = "" />
	<cfset variables['instance']['commandFactory'] = false >/
	<cfset variables['instance']['beaner'] = false >/


	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.command.CommandContext" output="false">
		<cfargument name="parent" required="true" type="any" />
		<cfargument name="responses" type="struct" required="true" />
		<cfargument name="commandMax" type="numeric" required="true" hint="the maximum number of commands which can be executed within this context, helps prevent never-ending loops" />
		<cfargument name="commandFactory" required="true" type="any" />
		<cfargument name="beaner" required="true" type="any" />

		<cfset setParent( arguments.parent ) />
		<cfset setResponses( arguments.responses ) />
		<cfset setCommandFactory( arguments.commandFactory ) />
		<cfset setBeaner( arguments.beaner ) />
		<cfset setDeque( createObject( 'component', 'org.gliint.framework.util.SizedDeque' ).init( arguments.commandMax ) ) />

		<cfreturn this />
	</cffunction>

	<!--- API for CommandHandlers --------------------------------------------->

	<cffunction name="do" access="public" returntype="any" output="false">
		<cfargument name="command" required="true" type="any" />
		<cfreturn getParent().getCommandDispatcher().execute( arguments.command, this ) />
	</cffunction>


	<cffunction name="enqueueCommand" access="public" returntype="void" output="false">
		<cfargument name="command" required="true" type="any" />
		<cfset getDeque().put( arguments.command ) />
	</cffunction>


	<cffunction name="dequeueCommand" access="public" returntype="any" output="false">
		<cfreturn getDeque().get() />
	</cffunction>


	<cffunction name="hasCommands" access="public" returntype="boolean" output="false">
		<cfreturn not getDeque().isEmpty() />
	</cffunction>


	<cffunction name="enstackCommand" access="public" returntype="void" output="false">
		<cfargument name="command" required="true" type="any" />
		<cfset getDeque().push( arguments.command ) />
	</cffunction>


	<cffunction name="destackCommand" access="public" returntype="any" output="false">
		<cfreturn getDeque().pop() />
	</cffunction>


	<cffunction name="clear" access="public" returntype="void" output="false">
		<cfset getDeque().clear() />
	</cffunction>


	<cffunction name="peek" access="public" returntype="any" output="false">
		<cfreturn getDeque().peek() />
	</cffunction>


	<cffunction name="setResponse" access="public" returntype="void" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfset variables['instance']['responses'][arguments.key] = arguments.value />
	</cffunction>


	<cffunction name="getResponse" access="public" returntype="any" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfreturn variables['instance']['responses'][arguments.key] />
	</cffunction>


	<cffunction name="isResponseDefined" access="public" returntype="boolean" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfreturn structKeyExists( variables['instance']['responses'], arguments.key ) />
	</cffunction>


	<cffunction name="removeResponse" access="public" returntype="void" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfif isResponseDefined( arguments.key ) >
			<cfset structDelete( variables['instance']['responses'], arguments.key ) />
		</cfif>
	</cffunction>


	<cffunction name="appendResponses" access="public" returntype="void" output="false">
		<cfargument name="struct2" type="struct" required="true" />
		<cfargument name="overwrite" type="boolean" required="false" default="true" />
		<cfset structAppend( variables['instance']['responses'], arguments.struct2, overwrite ) />
	</cffunction>


	<cffunction name="newCommand" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="bind" type="string" required="false" default="name" />
		<cfargument name="args" type="struct" required="false" default="#structNew()#" />
		<cfreturn getCommandFactory().createCommand( argumentCollection = arguments ) />
	</cffunction>


	<!--- convenience methods --->
	<cffunction name="setResponseBeanByClass" access="public" returntype="void" hint="creates a bean and puts it in the responses" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="class" type="string" required="true" />
		<cfargument name="fieldCollection" type="struct" required="false" default="#structNew()#" />
		<cfargument name="method" type="string" required="false" default="" />

		<cfset var b = getBeaner().getBeanByClass( arguments.class, arguments.fieldCollection, arguments.method ) />
		<cfset setResponse( arguments.key, b ) />
	</cffunction>


	<cffunction name="setResponseBeanByFactory" access="public" returntype="void" hint="creates a bean and puts it in the responses" output="false">
		 <cfargument name="key" type="string" required="true" />
		<cfargument name="factoryBean" type="string" required="true" />
		<cfargument name="factoryMethod" type="string" required="false" />
		<cfargument name="fieldCollection" type="struct" required="false" default="#structNew()#" />
		<cfargument name="method" type="string" required="false" default="" />
		<cfargument name="args" type="struct" required="false" default="#structNew()#">

		<cfset var b = getBeaner().getBeanByFactory( arguments.factoryBean, arguments.factoryMethod, arguments.fieldCollection, arguments.method, arguments.args ) />
		<cfset setResponse( arguments.key, b ) />
	</cffunction>

	<!--- getters/setters ------------------------------------------------------>

	<!--- TODO this whole parent business is out of hand. why are we doing it this way, again? --->
	<cffunction name="getParent" access="public" returntype="any" output="false" hint="returns the highest ancestor (typically GliintController) ">
		<cfset var p = variables['instance']['parent'] />
		<cfif ( isBoolean( variables['instance']['parent'] ) ) >
			<cfthrow message="CommandContext has not been properly initialized" />
		</cfif>
		<cfif p.hasParent() >
			<cfreturn p.getParent() />
		</cfif>
		<cfreturn variables['instance']['parent'] />
	</cffunction>


	<cffunction name="setParent" access="private" returntype="void" output="false" >
		<cfargument name="parent" required="true" type="WEB-INF.cftags.component" />
		<cfset variables['instance']['parent'] = arguments.parent />
	</cffunction>


	<cffunction name="hasParent" access="public" returntype="boolean" output="false">
		 <cfif ( isObject( getParent() ) ) >
			<cfreturn true />
		</cfif>
		<cfreturn false />
	</cffunction>

	<!--- public for hierarchical commandContexts --->
	<cffunction name="getCommandFactory" access="public" returntype="any" output="false">
			<cfreturn variables['instance']['commandFactory'] />
	</cffunction>


	<cffunction name="setCommandFactory" access="public" returntype="void" output="false">
		<cfargument name="commandFactory" type="any" required="true" />
		<cfset variables['instance']['commandFactory'] = arguments.commandFactory />
	</cffunction>


	<!--- public for hierarchical commandContexts --->
	<cffunction name="getBeaner" access="public" returntype="any" output="false">
			<cfreturn variables['instance']['beaner'] />
	</cffunction>


	<cffunction name="setBeaner" access="public" returntype="void" output="false">
		<cfargument name="beaner" type="any" required="true" />
		<cfset variables['instance']['beaner'] = arguments.beaner />
	</cffunction>


	<cffunction name="setDeque" access="private" returntype="void" output="false">
		<cfargument name="deque" required="true" type="any" />
		<cfset variables['properties']['deque'] = arguments.deque />
	</cffunction>


	<cffunction name="getDeque" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['deque']/>
	</cffunction>


	<cffunction name="setResponses" access="private" returntype="void" output="false">
		<cfargument name="responses" type="struct" required="true" />
		<cfset variables['instance']['responses'] = arguments.responses />
	</cffunction>


	<cffunction name="getResponses" access="public" returntype="struct" output="false">
		<cfreturn variables['instance']['responses'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>

</cfcomponent>