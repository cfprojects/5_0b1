<cfcomponent displayname="SizedQueue" output="false" extends="org.gliint.framework.util.Queue" >
<!---
  org.gliint.framework.util.SizedQueue
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

  <cfset variables['instance']['maxSize'] = 0 />

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" access="public" output="false" returntype="org.gliint.framework.util.SizedQueue" >
    <cfargument name="maxSize" type="numeric" required="false" default="10" />
    <cfset super.init() />
    <cfset setMaxSize( arguments.maxSize ) />
    <cfreturn this />
  </cffunction>


  <cffunction name="getMaxSize" access="public" output="false" returntype="numeric" >
    <cfreturn variables['instance']['maxSize'] />
  </cffunction>


  <cffunction name="isFull" access="public" output="false" returntype="boolean" >
    <cfreturn ( size() GTE variables['instance']['maxSize'] ) />
  </cffunction>


  <cffunction name="put" access="public" output="false" returntype="void" >
    <cfargument name="item" type="any" required="true" />

    <cfif ( isFull() ) >
      <cfthrow type="org.gliint.framework.util.SizedQueue.queueFull" message="cannot add item to Sized Queue since it is full" />
    </cfif>

    <cfset super.put( arguments.item ) />
  </cffunction>


  <cffunction name="setMaxSize" access="private" output="false" returntype="void" >
    <cfargument name="maxSize" type="numeric" required="true" />
    <cfset variables['instance']['maxSize'] = arguments.maxSize />
  </cffunction>

</cfcomponent>