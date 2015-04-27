<cfcomponent displayname="BaseApplicationListener" output="false" >
<!---
Based on Spring framework 1.2 interface ApplicationListener:

"Interface to be implemented by application event listeners.
Based on standard java.util base interface for Observer design pattern."

--->
<!---
org.gliint.framework.context.BaseApplicationListener

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
	<cfset variables['instance']['name'] = "" />

	<!--- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = --->

	<cffunction name="init" access="public" returntype="org.gliint.framework.context.BaseApplicationListener" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="class" access="public" hint="returns the runtime class of an object" returntype="string" output="false" >
		<cfreturn getMetaData( this ).name />
	</cffunction>


	<cffunction name="onApplicationEvent" access="public" returntype="void" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>

</cfcomponent>