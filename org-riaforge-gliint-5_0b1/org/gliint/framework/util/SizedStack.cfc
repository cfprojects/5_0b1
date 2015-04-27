<cfcomponent displayname="SizedStack" extends="org.gliint.framework.util.Stack" output="false" >
<!---
  org.gliint.framework.util.SizedStack

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
  <cfset variables['instance']['stack'] = arrayNew(1) />
  <cfset variables['instance']['maxSize'] = 0 />

  <!-------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.SizedStack" >
    <cfargument name="maxSize" type="numeric" required="true" />
    <cfargument name="arr" type="array" required="false" default="#arrayNew(1)#" />

    <cfset setMaxSize( arguments.maxSize ) />
    <cfset super.init( arguments.arr ) />
    <cfreturn this />
  </cffunction>


  <cffunction name="isFull" access="public" returntype="boolean" >
    <cfreturn ( arrayLen( variables['instance']['stack'] ) GTE variables['instance']['maxSize'] ) />
  </cffunction>


  <cffunction name="push" access="public" returntype="void" >
    <cfargument name="item" type="any" required="true" />

    <cfif ( isFull() ) >
      <cfthrow type="org.gliint.framework.util.SizedStack.stackFull" message="cannot add item to Sized Stack since it is full" />
    </cfif>

    <cfset super.push( arguments.item ) />
  </cffunction>


  <cffunction name="getMaxSize" access="public" returntype="numeric" >
    <cfreturn variables['instance']['maxSize'] />
  </cffunction>


  <cffunction name="setMaxSize" access="private" returntype="void" >
    <cfargument name="maxSize" type="numeric" required="true" />
    <cfset variables['instance']['maxSize'] = arguments.maxSize />
  </cffunction>

</cfcomponent>