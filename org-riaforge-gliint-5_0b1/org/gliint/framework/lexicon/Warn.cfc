<cfcomponent displayname="Warn" extends="org.gliint.framework.handler.BaseCommandHandler" output="false" >
<!---
A convenience commandHandler; writes its command's comment attribute as a trace warning.

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
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.lexicon.Warn

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


	<cffunction name="init" access="public" returntype="org.gliint.framework.lexicon.Warn" output="false">
		<cfset super.init() />
		<cfreturn this />
	</cffunction>


  <cffunction name="execute" access="public" returntype="any" output="false">
    <cfargument name="command" type="any" required="true" />
    <cfargument name="context" type="any" required="true" />

    <cfset var result = newResult() />

    <cfif getShouldTrace() >
      <cftrace type="information" text="org.gliint.framework.lexicon.Warn started" />
    </cfif>

    <cftrace type="warning" text="#getComment()#" />

    <cfif getShouldTrace() >
      <cftrace type="information" text="org.gliint.framework.lexicon.Warn completed" />
    </cfif>

    <cfreturn result />
  </cffunction>

</cfcomponent>