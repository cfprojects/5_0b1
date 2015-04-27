<cfcomponent displayname="Multicast" extends="org.gliint.framework.handler.BaseCommandHandler" output="false" >
<!---
Broadcasts a command to all known listeners, depending upon the listener to choose which
Commands to respond to.

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
	<tr>
		<td>listeners</td>
		<td>#arrayNew(1)#</td>
		<td>an array of listeners which extend BaseCommandHandler</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.context.lexicon.Multicast

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

	<cfset variables['properties']['listeners'] = arrayNew(1) />

	<cffunction name="init" access="public" returntype="org.gliint.framework.lexicon.Multicast" output="false" >
		<!--- an array of listeners --->
		<!--- cfset setProperty( 'listeners', arrayNew(1) ) / --->
		<cfset super.init() />
		<cfreturn this />
	</cffunction>


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var result = true />
		<cfset var i = 0 />
		<cfset var listeners = getListeners() />
		<cfset var size = arrayLen( listeners ) />

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.context.lexicon.Multicast: Started (#size# listeners)" />
		</cfif>

		<!--- we can't enstack here as listeners may be processing based on the command name --->
		<cfloop condition="i lt size">
			<cfset i = i + 1 />
			<cfif getShouldTrace() >
				<cftrace type="information" text="org.gliint.framework.context.lexicon.Multicast: Sending command #arguments.command.getName()# to listener #getmetadata( listeners[i] ).name#" />
			</cfif>
			<cfset listeners[i].execute( arguments.command, arguments.context ) />
		</cfloop>

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.context.lexicon.Multicast: Completed" />
		</cfif>

		<cfreturn result />
	</cffunction>


	<cffunction name="addListener" access="public" returntype="void" output="false">
		<cfargument name="listener" type="any" required="true" />
		<!--- will overwrite if by name --->
		<cflock name="MulticastLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfset arrayAppend( variables['instance']['listeners'], arguments.listener ) />
		</cflock>
	</cffunction>


<!--- accessors & mutators ------------------------------------------------------->

	<cffunction name="setListeners" access="public" returntype="void" output="false" >
		<cfargument name="listeners" type="array" required="true" />
		<cflock name="MulticastLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfset variables['properties']['listeners'] = arguments.listeners />
		</cflock>
	</cffunction>


	<cffunction name="getListeners" access="private" returntype="array" output="false" >
		<cfset var z = arrayNew(1) />
		<cflock name="MulticastLock" throwontimeout="true" timeout="30" type="readonly">
			<cfset z = variables['properties']['listeners'] />
		</cflock>
		<cfreturn z />
	</cffunction>

</cfcomponent>