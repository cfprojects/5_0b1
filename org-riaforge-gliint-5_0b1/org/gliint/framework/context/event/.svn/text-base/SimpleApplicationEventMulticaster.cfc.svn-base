<cfcomponent displayname="SimpleApplicationEventMulticaster" output="false">
<!---
Based on Spring framework 1.2  org.springframework.context.event.SimpleApplicationEventMulticaster:

"Simple implementation of the ApplicationEventMulticaster interface."

"Multicasts all events to all registered listeners, leaving it up to the listeners to
ignore events that they are not interested in. Listeners will usually perform
corresponding instanceof checks on the passed-in event object."

"By default, all listeners are invoked in the calling thread. This allows the danger of a
rogue listener blocking the entire application, but adds minimal overhead."

The collection class used may be either a struct of listener beans, or an array of listener beans
--->
<!---
org.gliint.framework.context.util.ApplicationContextUtils

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

	<cfset variables['instance'] = structNew() />
	<cfset variables['instance']['listeners'] = structNew() />

	<!--- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = --->

	<cffunction name="init" access="public" returntype="org.gliint.framework.context.event.SimpleApplicationEventMulticaster" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="multicastEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true" />

		<cfset var i = 0 />
		<cfset var size = 0 />
		<cfset var z = structNew() />

		<cflock name="EventMulticasterListenerLock" throwontimeout="true" timeout="30" type="readonly">
			<cfset z = variables['instance']['listeners'] />
			<cfif ( isStruct( z ) ) >
				<cfloop collection="#z#" item="i">
					<!--- here we could:
						1) ask the listener if it has an onApplicationEvent() method,
						2) catch an exception caused by a missing onApplicationEvent() method and ignore it,
						or 3) let it throw!
						Right now, it's 3
					--->
					<cfset z[i].onApplicationEvent( arguments.event ) />
				</cfloop>
			<cfelse>
				<cfset size = arrayLen( z ) />
				 <cfloop from="1" to="#size#" index="i">
					 <cfset z[i].onApplicationEvent( arguments.event ) />
				 </cfloop>
			</cfif>
		</cflock>

	</cffunction>


	<cffunction name="addApplicationListener" access="public" returntype="void" output="false">
		<cfargument name="listener" type="any" required="true" />
		<!--- will overwrite if by name --->
		<cflock name="EventMulticasterListenerLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfif ( isStruct( variables['instance']['listeners'] ) ) >
				<cfset variables['instance']['listeners'][arguments.listener.class()] = arguments.listener />
			<cfelse>
				<cfset arrayAppend( variables['instance']['listeners'], arguments.listener ) />
			</cfif>
		</cflock>
	</cffunction>


	<cffunction name="removeAllListeners" access="public" returntype="void" output="false">
		<cflock name="EventMulticasterListenerLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfif ( isStruct( variables['instance']['listeners'] ) ) >
				<cfset structClear( variables['instance']['listeners'] ) />
			<cfelse>
				<cfset arrayClear( variables['instance']['listeners'] ) />
			</cfif>
		</cflock>
	</cffunction>


	<cffunction name="removeApplicationListener" access="public" returntype="void" output="false">
		<cfargument name="listenerClass" type="string" required="true" />

		<cfset var i = 0 />

		<cflock name="EventMulticasterListenerLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfif ( isStruct( variables['instance']['listeners'] ) ) >
				<cfset structDelete( variables['instance']['listeners'], arguments.listenerClass ) />
			<cfelse>

				<cfset i = arrayLen( variables['instance']['listeners'] ) />
				<!--- note that here we must go from the end of the array to the front, or we'll miss duplicates or throw an exception --->
				<cfloop condition="i gt 0" >
						<cfif ( variables['instance']['listeners'][i].class() eq arguments.listenerClass ) >
							<cfset arrayDeleteAt( variables['instance']['listeners'], i ) />
						</cfif>
					<cfset i = i - 1 />
				</cfloop>

			</cfif>
		</cflock>

	</cffunction>


	<cffunction name="setCollectionClass" access="public" returntype="void" output="false">
		<cfargument name="collection" type="any" required="true" />

		<cfif ( ( not isArray( arguments.collection ) ) and	( not isStruct( arguments.collection ) ) ) >
			<cfthrow type="InvalidMulticasterCollection" detail="invalid collection" message="The collection provided to the ApplicationEventMulticaster must be either a struct or an array" />
		</cfif>

		<cflock name="EventMulticasterListenerLock" throwontimeout="true" timeout="30" type="exclusive">
			<cfset variables['instance']['listeners'] = arguments.collection />
		</cflock>
		<!--- note that here, unlike Spring, we do not reset the collection elements --->
	</cffunction>


	<!--- access set to public primarily for testing purposes, original is 'protected' --->
	<cffunction name="getApplicationListeners" access="public" returntype="any" output="false">
		<cfreturn variables['instance']['listeners'] />
	</cffunction>

</cfcomponent>