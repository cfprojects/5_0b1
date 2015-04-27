<cfcomponent name="TestBean" output="false" >
<!---
	org.gliint.test.org.gliint.util.TestBean.cfc

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
	<cfset variables.instance = structNew() />

	<cffunction name="init" access="public" returntype="TestBean" >
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfset setFirstName( arguments.firstName ) />
		<cfset setLastName( arguments.lastName ) />
		<cfreturn this />
	</cffunction>


  <cffunction name="hello" access="public" returntype="any" >
		<cfset var v = "hello, world" />
    <cfreturn this />
  </cffunction>


	<cffunction name="setFirstName" access="public" returntype="void" >
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.instance.firstName = arguments.firstName />
	</cffunction>


	<cffunction name="getFirstName" access="public" returntype="string" >
		<!--- <cfreturn variables.instance.firstName /> --->
    <cfreturn 'Ringo' />
	</cffunction>


	<cffunction name="setLastName" access="public" returntype="void" >
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.instance.lastName = arguments.lastName />
	</cffunction>


	<cffunction name="getLastName" access="public" returntype="string" >
		<!--- <cfreturn variables.instance.lastName /> --->
    <cfreturn 'Starr' />
	</cffunction>

</cfcomponent>