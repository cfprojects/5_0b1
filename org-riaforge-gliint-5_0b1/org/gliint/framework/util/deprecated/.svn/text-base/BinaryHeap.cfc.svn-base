<cfcomponent displayname="BinaryHeap" output="false" >
<!---
  org.gliint.framework.util.BinaryHeap

  original code courtesy of Matt Liotta -  thanks, Matt!
  http://lists.topica.com/lists/mach-ii-coldfusion/read/message.html?mid=808786843

  IMPORTANT NOTE: any element used in conjunction with the BinaryHeap must have
  a public getPriority() method.

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

  <cfset variables['maxSize'] = 0 />
  <cfset variables['currentSize'] = 0 />
  <cfset variables['orderOk'] = true />
  <cfset variables['heap'] = arrayNew(1) />

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.BinaryHeap" >
    <cfargument name="maxSize" type="numeric" required="true" />
    <cfargument name="minValue" type="numeric" required="true" />

    <cfset setMaxSize( arguments.maxSize ) />
    <!--- an element for variables.heap[1] could be placed here --->

    <cfreturn this />
  </cffunction>


  <cffunction name="peek" access="public" returntype="any">
    <!--- index 1 is for special case --->
    <cfreturn variables.heap[2] />
  </cffunction>


  <cffunction name="put" access="public" returntype="void" >
    <cfargument name="element" type="any" required="true" />
    <cfset var hole = "">

    <cfif ( not isObject( element) ) >
      <cfthrow type="objectRequiredException" message="The element which is being added to the heap must be an object" />
    </cfif>

    <!--- not enforced: element has getPriority() method --->

    <cfif getOrderOk() >
      <cfif ( currentSize lt maxSize ) >
        <cfset variables.currentSize = variables.currentSize + 1 />
        <cfset hole = variables.currentSize />
        <cfif ( hole gt 1 ) >
          <cfloop condition="arguments.element.getPriority() lt variables.heap[getIndex(hole / 2)].getPriority()">
            <cfset variables.heap[getIndex(hole)] = variables.heap[getIndex(hole / 2)] />
            <cfset hole = hole / 2 />
          </cfloop>
        </cfif>
        <cfset variables.heap[getIndex(hole)] = arguments.element />
      <cfelse>
        <cfthrow type="maximumSizeException" message="Insert failed because the heap is at its size limit" />
      </cfif>
    <cfelse>
      <cfset toss( arguments.element ) />
    </cfif>
  </cffunction>


  <cffunction name="get" access="public" returntype="any" >
    <!--- index 1 is for special case --->
    <cfset var element = peek() />
    <cfset variables.heap[2] = variables.heap[getIndex(variables.currentSize)] />
    <cfset variables.currentSize = variables.currentSize - 1 />
    <cfset percolateDown(1) />
    <cfreturn element />
  </cffunction>


  <cffunction name="clear" access="public" returntype="void" >
    <cfset variables.currentSize = 0 />
  </cffunction>


  <cffunction name="size" access="public" returntype="numeric" >
    <cfreturn variables.currentSize() />
  </cffunction>


  <cffunction name="isEmpty" access="public" returntype="boolean" >
    <cfreturn variables.currentSize eq 0 />
  </cffunction>


  <cffunction name="toss" access="public" returntype="void" >
    <cfargument name="element" type="any" required="true" />

    <cfif currentSize lt maxSize>
      <cfset variables.currentSize = variables.currentSize + 1 />
      <cfset variables.heap[getIndex(variables.currentSize)] = arguments.event />
      <cfif arguments.element.getPriority() lt variables.heap[getIndex(variables.currentSize / 2)].getPriority() >
        <cfset setOrderOk( false ) />
      </cfif>
    <cfelse>
        <cfthrow type="maximumSizeException" message="Insert failed because the heap is at its size limit" />
    </cfif>
  </cffunction>


  <cffunction name="fixHeap" access="public" returntype="void" >
    <cfset var from = variables.currentSize / 2 />
    <cfset var itr = "" />

    <cfloop index="itr" from="#from#" to="2" step="-1" >
      <cfset percolateDown(itr) />
    </cfloop>
    <cfset setOrderOk( true ) />
  </cffunction>


  <cffunction name="percolateDown" access="private" returntype="void" >
    <cfargument name="index" type="numeric" required="true" />
    <cfset var hole = arguments.index />
    <cfset var child = "" />
    <cfset var tmp = variables.heap[getIndex(hole)] />

    <cfloop condition="hole * 2 lte variables.currentSize" >
      <cfset child = hole * 2 />
      <cfif child neq variables.currentSize and variables.heap[getIndex(child + 1)].getPriority() lt variables.heap[getIndex(child)].getPriority() >
        <cfset child = child + 1 />
      </cfif>
      <cfif variables.heap[getIndex(child)].getPriority() lt tmp.getPriority() >
        <cfset variables.heap[getIndex(hole)] = variables.heap[getIndex(child)] />
      <cfelse>
        <cfbreak>
      </cfif>
      <cfset hole = child />
    </cfloop>
    <cfset variables.heap[getIndex(hole)] = tmp />
  </cffunction>


  <cffunction name="getIndex" access="private" returntype="numeric" >
    <cfargument name="index" type="numeric" required="true" />
    <!---
    If number is greater than or equal to 0, the closest integer less than number.
    If number is less than 0, the closest integer greater than number.
    --->
    <cfreturn fix(arguments.index + 1) />
  </cffunction>


  <cffunction name="setMaxSize" access="private" returntype="void" >
    <cfargument name="maxSize" required="true" type="numeric" />
    <cfset variables['maxSize'] = arguments.maxSize />
  </cffunction>


  <cffunction name="setOrderOk" access="private" returntype="void" >
    <cfargument name="orderOk" required="true" type="boolean" />
    <cfset variables['orderOk'] = arguments.orderOk />
  </cffunction>


  <cffunction name="getOrderOk" access="public" returntype="boolean" >
    <cfreturn variables['orderOk'] />
  </cffunction>

</cfcomponent>