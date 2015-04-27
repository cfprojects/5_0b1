<cfcomponent displayname="CommandFactory" output="false" >
<!---
org.gliint.framework.command.CommandFactory

Creates Commands with its' createCommand() method; the class of the command returned is
determined by its' commandClass property.

Maintains a default command name and value for reference.

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
		<td>publicCommandName</td>
		<td>event</td>
		<td>key which may be found in the request</td>
	</tr>
	<tr>
		<td>publicCommandDefaultValue</td>
		<td>default</td>
		<td>name of the public command which will be used as a default if the publicCommandName key has no value, or is not found in the request</td>
	</tr>
	<tr>
		<td>commandClass</td>
		<td>org.gliint.framework.command.Command</td>
		<td>the class to use upon receiving a request</td>
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
	<br/>&nbsp;
--->
<!---
org.gliint.framework.command.CommandFactory

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
	<cfset variables['properties']['shouldTrace'] = false />
	<cfset variables['properties']['publicCommandName'] = "event" />
	<cfset variables['properties']['publicCommandDefaultValue'] = "default" />
	<cfset variables['properties']['commandClass'] = "org.gliint.framework.command.Command" />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.command.CommandFactory" >
		<cfreturn this />
	</cffunction>


	<cffunction name="createCommand" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="bind" type="string" required="false" default="name" />
		<cfargument name="args" type="struct" required="false" default="#structNew()#" />
		<cfargument name="isPublic" type="boolean" required="false" default="#false#" />

		<cfset var cmd = createObject( 'component', getCommandClass() ).init( argumentCollection = arguments ) />

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.command.CommandFactory: created command for #getPublicCommandName()# #arguments.name#" />
		</cfif>

		<cfreturn cmd />
	</cffunction>

	<!---------------------------------------------------------------------------->

	<cffunction name="getCommandClass" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['commandClass'] />
	</cffunction>


	<cffunction name="setCommandClass" access="public" returntype="void" output="false">
		<cfargument name="commandClass" type="string" required="true" />
		<cfset variables['properties']['commandClass'] = arguments.commandClass />
	</cffunction>


	<cffunction name="getPublicCommandName" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['publicCommandName'] />
	</cffunction>


	<cffunction name="setPublicCommandName" access="public" returntype="void" output="false">
		<cfargument name="publicCommandName" type="string" required="true" />
		<cfset variables['properties']['publicCommandName'] = arguments.publicCommandName />
	</cffunction>


	<cffunction name="getPublicCommandDefaultValue" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['publicCommandDefaultValue'] />
	</cffunction>


	<cffunction name="setPublicCommandDefaultValue" access="public" returntype="void" output="false">
		<cfargument name="publicCommandDefaultValue" type="string" required="true" />
		<cfset variables['properties']['publicCommandDefaultValue'] = arguments.publicCommandDefaultValue />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>

</cfcomponent>