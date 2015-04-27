<cfcomponent displayname="NopHandler" output="false" >
<!---
a no-op handler; useful for testing and defaults
--->
<!---
org.gliint.framework.handler.NopHandler

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

	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.NopHandler" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="handle" access="public" returntype="struct" output="false">
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cftrace text="org.gliint.framework.handler.NopHandler: Started #arguments.request#" />
		<cftrace text="org.gliint.framework.handler.NopHandler: Completed #arguments.request#" />
		<cfreturn arguments.response />
	</cffunction>

</cfcomponent>