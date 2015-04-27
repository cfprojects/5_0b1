<cfcomponent displayname="Command" output="false" >
<!---
The Gliint Command bean is a transient created by the CommandFactory.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>none (transient)

<b>Since:</b>

<b>See Also:</b>
	<br/>org.gliint.framework.handler.mapping.GliintCommandHandlerMapping
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private name</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">Name for the command ('doSomething' e.g.)</div>
		</td>
	</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private bind</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">Binds the command to a commandHandler for processing; options are: 'multicast', 'notify', and 'name' (default)</div>
		</td>
	</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private args</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_struct">struct</a></div>
				<div class="summaryTableDescription">A structure (map) with instance specific name/value pairs to aid in processing</div>
		</td>
	</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private isPublic</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_boolean">boolean</a></div>
				<div class="summaryTableDescription">Determines if this command can be accessed from a URL, e.g. ?/event=doSomething, or /pathToSomeApp/doSomething  Defaults to false (not public) </div>
		</td>
	</tr>

	</tbody>
</table>
--->
<!---
org.gliint.framework.command.Command

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

	<cfset variables['instance'] = structNew() />
	<cfset variables['instance']['name'] = "" />
	<cfset variables['instance']['bind'] = "" />
	<cfset variables['instance']['args'] = structNew() />
	<cfset variables['instance']['isPublic'] = false />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.command.Command" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="bind" type="string" required="true" />
		<cfargument name="args" type="struct" required="true" />
		<cfargument name="isPublic" type="boolean" required="false" default="#false#" />

		<cfset setName( arguments.name ) />
		<cfset setBind( arguments.bind ) />
		<cfset setArgs( arguments.args ) />
		<cfset setIsPublic( arguments.isPublic ) />

		<cfreturn this />
	</cffunction>


	<cffunction name="getArg" access="public" returntype="string" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfreturn variables['instance']['args'][arguments.key] />
	</cffunction>


	<cffunction name="isArgDefined" access="public" returntype="boolean" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfreturn structKeyExists( variables['instance']['args'], arguments.key ) />
	</cffunction>


	<cffunction name="getInstance" access="public" returntype="struct" output="false">
		<cfreturn variables['instance'] />
	</cffunction>

	<!--- getters/setters ------------------------------------------------------->

	<cffunction name="setName" access="private" returntype="void" output="false">
		<cfargument name="name" required="true" type="string" />
		<cfset variables['instance']['name'] = arguments.name />
	</cffunction>

	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables['instance']['name'] />
	</cffunction>


	<cffunction name="setBind" access="private" returntype="void" output="false">
		<cfargument name="bind" required="true" type="string" />
		<cfset variables['instance']['bind'] = arguments.bind />
	</cffunction>

	<cffunction name="getBind" access="public" returntype="string" output="false">
		<cfreturn variables['instance']['bind'] />
	</cffunction>


	<cffunction name="setArgs" access="private" returntype="void" output="false">
		<cfargument name="args" required="true" type="struct" />
		<cfset variables['instance']['args'] = arguments.args />
	</cffunction>


	<cffunction name="getArgs" access="public" returntype="struct" output="false">
		<cfreturn variables['instance']['args'] />
	</cffunction>


	<cffunction name="setIsPublic" access="private" returntype="void" output="false">
		<cfargument name="isPublic" required="true" type="boolean" />
		<cfset variables['isPublic'] = arguments.isPublic />
	</cffunction>

	<cffunction name="getIsPublic" access="public" returntype="boolean" output="false">
		<cfreturn variables['isPublic'] />
	</cffunction>

</cfcomponent>