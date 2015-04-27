<cfcomponent displayname="Notify" extends="org.gliint.framework.handler.BaseCommandHandler" output="false">
<!---
Broadcasts a command to all listeners registered for a command, expecting the listener to respond to that command.
Configured with Messages and the ids of corresponding commandHandlers coded as listeners for each message using
its setConfiguration method. In this case, the command object functions as a message.

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
		<td>configuration</td>
		<td>#structNew()#</td>
		<td>an structure of message names, each containing an array of listener ids</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;

--->
<!---
org.gliint.framework.lexicon.Notify

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

	<cfset variables['properties']['configuration'] = structNew() />
	<cfset variables['properties']['configuration']['messages'] = structNew() />
	<!---  variables['properties']['configuration']['messages'][message] = array of listenerNames --->


	<cffunction name="init" access="public" returntype="org.gliint.framework.lexicon.Notify" output="false" >
		<!--- a struct of messages (command names), each message contains an array of listenerNames
			it's an array of names so that we can configure this component without instantiating every listener,
			and can configure independently of who knows where the listeners are. Override the getListener method
			to use a different factory or service locator.
		  --->
		<cfset var configuration = structNew() >
		<cfset configuration['messages'] = structNew() />
		<cfset setProperty( 'configuration', configuration ) />
		<cfset super.init() />
		<cfreturn this />
	</cffunction>


	<!--- nee broadcast message --->
	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var i = 0 />
		<cfset var result = false />
		<cfset var listeners = getListenerNamesForCommand( arguments.command ) />
		<cfset var sz = arrayLen( listeners ) />
		<cfset var listener = false />

		<!--- commands broadcasted to no registered listeners DO NOT throw exceptions, but we'll trace that --->
		<cfif ( ( sz eq 0 ) and getShouldTrace() ) >
			<cftrace type="warning" text="message #arguments.command.getName()# has no associated commandHandler listeners" />
		</cfif>

		<cflock name="NotifyLock" throwontimeout="true" timeout="30" type="readonly">
			<!--- we can't enstack here as listeners may be processing based on the command name --->
			<cfloop condition="i lt sz" >
				<cfset i = i + 1 />

				<!---
					here we are catching bean factory exceptions, nothing more.
					it's expected that each commandHandler's execute() method contains it's own exception processing
					but you never know...
				--->
				<cftry>

					<!---
						we definitely want to get beans by id, not a direct reference to a bean (e.g. ref="")
						this is so that hierarchical bean factories will work as expected,
						i.e. if a parent factory resets it's beans, the new ones will be used.
					--->
					<cfset getListener( listeners[i] ).execute( arguments.command, arguments.context ) />

					<cfcatch type="any">
						<cfset handleException( cfcatch, newResult(), arguments.context ) />
						<cfset result = false />
					</cfcatch>
				</cftry>

			</cfloop>
		</cflock>

		<cfreturn result />
	</cffunction>


	<!--- this is a seperate method for subclassing purposes --->
	<cffunction name="getListener" access="private" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn getBeanFactory().getBean( id ) />
	</cffunction>


	<cffunction name="getListenerNamesForCommand" access="private" returntype="array" output="false">
		<cfargument name="command" type="any" required="true" />

		<cfset var n = arguments.command.getName() />

		<cfparam name="variables['properties']" default="#structNew()#">
		<cfparam name="variables['properties']['configuration']" default="#structNew()#">
		<cfparam name="variables['properties']['configuration']['messages']" default="#structNew()#">

		<cfif ( structKeyExists( variables['properties']['configuration']['messages'], n ) ) >
			<cfreturn variables['properties']['configuration']['messages'][n] />
		</cfif>

		<cfreturn arrayNew(1) />
	</cffunction>


	<cffunction name="setConfiguration" access="public" returntype="void" output="false">
		<cfargument name="configuration" type="struct" required="true" />
		<cflock name="NotifyLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfset variables['properties']['configuration'] = arguments.configuration />
		</cflock>
	</cffunction>

</cfcomponent>