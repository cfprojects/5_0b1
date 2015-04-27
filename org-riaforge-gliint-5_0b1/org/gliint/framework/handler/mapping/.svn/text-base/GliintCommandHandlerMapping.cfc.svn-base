<cfcomponent displayname="GliintCommandHandlerMapping" extends="org.gliint.framework.handler.mapping.BaseHandlerMapping" output="false">
<!---
Returns a HandlerExecutionChain for a request, based on the provided commands' bind attribute.
Returns FALSE if no match is found. Implements the setOrder() and getOrder() methods
from the parent class so that the calling object can retrieve the order from its set
of handlerMappings and call them from low to high.

A 'multicast' bind attribute will bind the multicastHandler to the HandlerExecutionChain,
which will broadcast the command to all listeners, allowing the listeners to determine whether
they should interact or not with the command.

A 'notify' bind attribute will bind the notifyHandler to the HandlerExecutionChain, which will
notify previously registered listeners (controllers) with the command

A 'name' bind attribute (the default) will bind the bean with the same beanFactory id to the command
if it exists ( parent beanFactory references are respoected), or the defaultHandler if none is found.

The 'verb' bind attribute is currently deprecated.

Some paths to components utilized by the GliintCommandHandlerMapping are hard-coded. Authors wishing to use
different components should write their own CommandHandlerMapping component, or extend this one.

This component is bean factory aware.

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
		<td>invalidAccessHandler</td>
		<td>false</td>
		<td>used when a public command attempts to acquire a private commandHandler</td>
	</tr>
	<tr>
		<td>multicastHandler</td>
		<td>false</td>
		<td>used when the a command has a 'multicast' bind attribute</td>
	</tr>
	<tr>
		<td>notifyHandler</td>
		<td>false</td>
		<td>used when the a command has a 'notify' bind attribute</td>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.handler.mapping.GliintCommandHandlerMapping

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
	<cfset variables['properties']['order'] = 0 />
	<cfset variables['properties']['defaultHandler'] = false />
	<cfset variables['properties']['shouldTrace'] = false />
	<cfset variables['properties']['invalidAccessHandler'] = false />
	<cfset variables['properties']['multicastHandler'] = false />
	<cfset variables['properties']['notifyHandler'] = false />
	<cfset variables['properties']['beanFactory'] = false />


	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.mapping.GliintCommandHandlerMapping" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="org.gliint.framework.HandlerExecutionChain" output="false">
		<cfargument name="command" type="org.gliint.framework.command.Command" required="true" />

		<!--- cfset var hec = createObject( 'component', 'org.gliint.framework.HandlerExecutionChain' ) / --->
		<cfset var cmd = arguments.command />
		<cfset var bf = getBeanFactory() />
		<cfset var text = "" />
		<cfset var type = "information">
		<cfset var hec = false />

		<cfswitch expression="#cmd.getBind()#">

			<cfcase value="multicast">
				<cfset hec = getMulticastHandler() />
				<cfset text = "org.gliint.framework.handler.mapping.GliintCommandHandlerMapping: Multicasting command #cmd.getName()#" />
			</cfcase>

			<cfcase value="notify">
				<cfset hec = getNotifyHandler() />
				<cfset text = "org.gliint.framework.handler.mapping.GliintCommandHandlerMapping: Notifying listeners of command #cmd.getName()#" />
			</cfcase>

			<cfdefaultcase >
				<cfif ( isObject( bf ) and bf.containsBean( cmd.getName() ) ) >
					<cfset hec = bf.getBean( cmd.getName() ) />
					<cfset text = "org.gliint.framework.handler.mapping.GliintCommandHandlerMapping: Assigned CommandHandler #hec.getHandler().getName()# to Command #cmd.getName()# " />
				<cfelse>
					<cfset hec = getDefaultHandler() />
					<cfset text = "org.gliint.framework.handler.mapping.GliintCommandHandlerMapping: Assigned CommandHandler #hec.getHandler().getName()# to Command #cmd.getName()# (missing)" />
					<cfset type = "warning" />
				</cfif>

				<!--- can't access private (internal) commandHandlers with a public command --->
				<cfif ( ( not compareNoCase( hec.getHandler().getAccess(), 'private' ) ) and cmd.getIsPublic() ) >
					<cfset hec = getInvalidAccessHandler() />
					<cfset text = "org.gliint.framework.handler.mapping.GliintCommandHandlerMapping: Assigned CommandHandler #hec.getHandler().getName()# to Command #cmd.getName()# (private!)" />
					<cfset type = "warning" />
				</cfif>
			</cfdefaultcase>

		</cfswitch>

		<cfif getShouldTrace() >
			<cftrace type="#type#" text="#text#" />
		</cfif>
		<cfreturn hec />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory">
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getBeanFactory" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false" >
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false" >
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


	<cffunction name="setMulticastHandler" access="public" returntype="void" output="false">
		<cfargument name="multicastHandler" type="any" required="true" />
		<cfset variables['properties']['multicastHandler'] = arguments.multicastHandler />
	</cffunction>


	<cffunction name="getMulticastHandler" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['multicastHandler'] />
	</cffunction>


	<cffunction name="setInvalidAccessHandler" access="public" returntype="void" output="false">
		<cfargument name="invalidAccessHandler" type="any" required="true" />
		<cfset variables['properties']['invalidAccessHandler'] = arguments.invalidAccessHandler />
	</cffunction>


	<cffunction name="getInvalidAccessHandler" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['invalidAccessHandler'] />
	</cffunction>


	<cffunction name="setNotifyHandler" access="public" returntype="void" output="false">
		<cfargument name="notifyHandler" type="any" required="true" />
		<cfset variables['properties']['notifyHandler'] = arguments.notifyHandler />
	</cffunction>


	<cffunction name="getNotifyHandler" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['notifyHandler'] />
	</cffunction>

</cfcomponent>