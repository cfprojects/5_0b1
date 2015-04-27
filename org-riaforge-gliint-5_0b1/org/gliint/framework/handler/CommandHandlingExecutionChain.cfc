<cfcomponent displayname="CommandHandlingExecutionChain" output="false" extends="org.gliint.framework.HandlerExecutionChain" >
<!---
Experimental Base Class for Gliint based HandlerExecutionChains which function as CommandHandlers.

By extending this component, authors can create controller commands which bridge to model components maintained by the bean factory.

Follows the command design pattern, a.k.a Handler, executes it's unique functionality.

Like the BaseCommandHandler, this object is typically configured by the bean factory as a singleton, injected with it's interceptors when created.
Unlike the BaseCommandHandler it is NOT bean factory aware; model components should be wired in explicitly.

Creates result objects to be used on return of it's execute method, which must be
overridden.

Handles exceptions thrown during execution.

Can mixin additional methods.

Functioning as a HandlerExecutionChain, its getHandler method returns a reference to itself.

Its handle method allows it to function as a controller when convenient; generally speaking,
authors should code either the execute or the handle method, and point one to the other, the primary
difference is whether you require the passing of a distinct handlerExecutionChain, and which dispatcher is calling it.
--->
<!---
org.gliint.framework.handler.CommandHandlingExecutionChain

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
	<cfset variables['properties']['access'] = "" />
	<cfset variables['properties']['comment'] = "" />
	<cfset variables['properties']['handlingMethod'] = "execute" />
	<cfset variables['properties']['interceptors'] = arrayNew(1) />
	<cfset variables['properties']['name'] = "#getMetaData( this ).name#" />
	<cfset variables['properties']['resultClass'] = "org.gliint.framework.util.Result" />
	<cfset variables['properties']['shouldTrace'] = false />


	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.CommandHandlingExecutionChain" output="false">
		<cfargument name="interceptors" type="array" required="false" />

		<cfset variables['properties']['handlingMethod'] = "execute" />
		<cfset variables['properties']['interceptors'] = arrayNew(1) />
		<cfif ( structKeyExists( arguments, 'interceptors' ) ) >
			<cfset variables['properties']['interceptors'] = arguments.interceptors />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="CommandHandlingExecutionChain #getName()# was initialized" />
		</cfif>

		<cfreturn this />
	</cffunction>


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var result = true />

		<cfthrow type="Method.NotImplemented" message="The CommandHandlingExecuationChain's execute method is abstract and must be overridden" />

		<cftry>

			<!--- your code goes here --->

			<cfcatch type="any" >
				<cfset handleException( cfcatch, result, arguments.context )>
			</cfcatch>
		</cftry>

		<cfreturn result />
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="any" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="handle" access="public" returntype="any" output="false">
		<cfargument name="request" type="any" required="true" />
		<cfargument name="response" type="any" required="true" />
		<cfreturn execute( arguments.request, arguments.response ) />
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


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory" />
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getInstance" access="public" returntype="struct" output="false">
		<cfreturn variables['properties'] />
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


	<cffunction name="getHandlingMethod" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['handlingMethod'] />
	</cffunction>


	<cffunction name="setHandlingMethod" access="public" returntype="void" output="false">
		<cfargument name="handlingMethod" type="string" required="true" hint="the method to be used to handle requests (typically 'execute')" />
		<cfset variables['properties']['handlingMethod'] = arguments.handlingMethod />
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


	<cffunction name="getShouldTrace" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


	<cffunction name="setResultClass" access="public" returntype="void" output="false">
		<cfargument name="resultClass" type="string" required="true" />
		<cfset variables['properties']['resultClass'] = arguments.resultClass />
	</cffunction>


	<cffunction name="getResultClass" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['resultClass'] />
	</cffunction>


	<cffunction name="addInterceptor" access="public" returntype="void" output="false">
		<cfargument name="interceptor" type="any" required="true" hint="The order of the interceptors may matter, depending on your implementation. This method does something stack-like. If you don't want that, extend this component or use addInterceptors() below." />
		<cfset arrayPrepend( variables['properties']['interceptors'], arguments.interceptor ) />
	</cffunction>


	<cffunction name="addInterceptors" access="public" returntype="void" output="false">
		<cfargument name="interceptors" type="array" required="true" hint="Preserves the order of interceptors. (You probably wanted it that way anyhow)" />
		<cfset var i = 0 />
		<cfloop condition="i lt arrayLen( arguments.interceptors )" >
			<cfset i = i + 1 />
			<cfset arrayAppend( variables['properties']['interceptors'], arguments.interceptors[i] ) />
		</cfloop>
	</cffunction>


	<cffunction name="getInterceptors" access="public" returntype="array" output="false">
		<cfreturn variables['properties']['interceptors'] />
	</cffunction>

</cfcomponent>