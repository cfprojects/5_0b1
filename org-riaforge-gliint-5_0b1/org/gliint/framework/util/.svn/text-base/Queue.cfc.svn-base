<cfcomponent displayname="Queue" output="false" >
<!---
  org.gliint.framework.util.Queue

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

  <cfset variables['instance'] = structNew() />
  <cfset variables['instance']['queue'] = arrayNew(1) />

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.Queue" >
    <cfargument name="arr" type="array" required="false" default="#arrayNew(1)#" />

    <cfset setQueue( arguments.arr ) />

    <cfreturn this />
  </cffunction>


  <cffunction name="clear" access="public" returntype="void" >
    <cfset arrayClear( variables['instance']['queue'] ) />
  </cffunction>


  <cffunction name="get" access="public" returntype="any" >
    <cfset var i = peek() />
    <cfset arrayDeleteAt( variables['instance']['queue'], 1 ) />
    <cfreturn i />
  </cffunction>


  <cffunction name="isEmpty" access="public" returntype="boolean" >
    <cfreturn ( arrayLen( variables['instance']['queue'] ) eq 0 ) />
  </cffunction>


  <cffunction name="peek" access="public" returntype="any" >
    <cfargument name="row" required="false" type="numeric" default=1 />
    <cfreturn variables['instance']['queue'][arguments.row] />
  </cffunction>


  <cffunction name="put" access="public" returntype="void" >
    <cfargument name="item" type="any" required="true" />
    <cfset arrayAppend( variables['instance']['queue'], arguments.item ) />
  </cffunction>


  <cffunction name="size" access="public" returntype="numeric" >
    <cfreturn arrayLen( variables['instance']['queue'] ) />
  </cffunction>


  <cffunction name="setQueue" access="private" returntype="void" >
    <cfargument name="queue" type="array" required="true" />
    <cfset variables['instance']['queue'] = arguments.queue />
  </cffunction>


  <cffunction name="state" access="public" returntype="struct" >
    <cfreturn variables['instance'] />
  </cffunction>


</cfcomponent>