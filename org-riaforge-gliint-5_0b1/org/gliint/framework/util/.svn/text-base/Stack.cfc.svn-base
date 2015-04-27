<cfcomponent displayname="Stack" output="false">
<!---
  org.gliint.framework.util.Stack

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

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.Stack" >
    <cfargument name="arr" type="array" required="false" default="#arrayNew(1)#" />
    <cfset setStack( arguments.arr ) />
    <cfreturn this />
  </cffunction>


  <cffunction name="clear" access="public" returntype="void" hint="Removes all of the elements from this Stack. The Stack will be empty after this call returns (unless it throws an exception)." >
    <cfset arrayClear( variables['instance']['stack'] ) />
  </cffunction>


  <cffunction name="isEmpty" access="public" returntype="boolean" hint="Tests if this stack is empty" >
    <cfreturn arrayIsEmpty( variables['instance']['stack'] ) />
  </cffunction>


  <cffunction name="peek" access="public" returntype="any" hint="Looks at the object at the top of this stack without removing it from the stack."  >

    <cftry>
      <cfreturn variables['instance']['stack'][1] />

      <cfcatch type="any">
        <cfthrow type="org.gliint.framework.util.stack.StackIsEmpty" message="#cfcatch.message#" detail="#cfcatch.detail#"/>
      </cfcatch>
    </cftry>

  </cffunction>


  <cffunction name="pop" access="public" returntype="any" hint="Removes the object at the top of this stack and returns that object as the value of this function." >
    <cfset var element = "" />
    <cftry>
      <cfset element = variables['instance']['stack'][1] />
      <cfset arrayDeleteAt( variables['instance']['stack'], 1 ) />
      <cfreturn element />

      <cfcatch type="any">
        <cfthrow type="org.gliint.framework.util.stack.StackIsEmpty" message="#cfcatch.message#" detail="#cfcatch.detail#"/>
      </cfcatch>
    </cftry>
  </cffunction>


  <cffunction name="push" access="public" returntype="void" hint="Pushes an item onto the top of this stack" >
    <cfargument name="element" type="any" required="true" />
    <cfset arrayPrepend( variables['instance']['stack'], arguments.element ) />
  </cffunction>


  <cffunction name="size" access="public" returntype="numeric" hint="Returns the number of elements in this stack" >
    <cfreturn arrayLen( variables['instance']['stack'] ) />
  </cffunction>


  <cffunction name="setStack" access="private" returntype="void" >
    <cfargument name="stack" type="array" required="true" />
    <cfset variables['instance']['stack'] = arguments.stack />
  </cffunction>

</cfcomponent>