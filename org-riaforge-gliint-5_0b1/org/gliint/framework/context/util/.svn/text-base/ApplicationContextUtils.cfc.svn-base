<cfcomponent displayname="ApplicationContextUtils" extends="coldspring.context.util.ApplicationContextUtils" output="false" >
<!---
Provides additional functionality to Gliint Framework subclasses
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


	<cffunction name="destroyNamedContext" access="public" returntype="void" output="false">
		<cfargument name="scope" type="string" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfset var scopeStruct = getScope(arguments.scope) />
		<cfset structDelete( scopeStruct, arguments.name ) />
	</cffunction>


	<cffunction name="destroyDefaultContext" access="public" returntype="void" output="false">
		<cfargument name="scope" type="string" required="true" />
		<cfset var scopeStruct = getScope(arguments.scope) />
		<cfset structDelete( scopeStruct,this.DEFAULT_CONTEXT_KEY ) />
	</cffunction>


	<cffunction name="getScope" access="private" returntype="struct" output="false">
		<cfargument name="scope" type="string" required="true" />
		 <cfswitch expression="#lCase( arguments.scope )#">
			<cfcase value="application"><cfreturn application /></cfcase>
			<cfcase value="request"><cfreturn request /></cfcase>
			<cfcase value="server"><cfreturn server /></cfcase>
			<cfcase value="session"><cfreturn session /></cfcase>
			<cfcase value="this"><cfreturn this /></cfcase>
			<cfcase value="variables"><cfreturn variables /></cfcase>
			<cfdefaultcase><cfreturn structNew() /></cfdefaultcase>
		</cfswitch>
	</cffunction>

</cfcomponent>