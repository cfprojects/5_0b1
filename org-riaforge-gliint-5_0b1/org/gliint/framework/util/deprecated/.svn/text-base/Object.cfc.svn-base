<cfcomponent displayname="Object" output="false" with="" >
<!---
  org.gliint.framework.util.Object

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

  <!--- "public" variables whose access is moderated by getters and setters, go here --->
  <cfset variables['identity'] = "" >
  <cfset variables['timestamp'] = now() />

  <!--- protected and/or static instance variables go here --->
  <cfset variables['_protected'] = structNew() />

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" returntype="org.gliint.framework.util.Object" access="public" output="false" hint="">
    <cfset var i = 0 >
    <cfset setIdentity( createUUID() ) />

    <!--- static mixin composition based on metadata! --->
    <cfif structKeyExists( getMetaData( this ), 'with' ) >
      <cfloop list="#getMetaData( this ).with#" index="i" >
        <cfset mixinOnInit( i ) />
      </cfloop>
    </cfif>

    <cfreturn this/>
  </cffunction>


  <cffunction name="class" access="public" hint="returns the base class of the object" returntype="string" output="false" >
    <cfreturn getMetaData( this ).name />
  </cffunction>


  <cffunction name="path" access="public" hint="returns the absolute path to the object's base class" returntype="string" output="false" >
    <cfreturn getMetaData( this ).path />
  </cffunction>


  <cffunction name="display" access="public" hint="dumps the object's persistent state" returntype="void"  output="true">
    <cfargument name="instanceOnly" required="no" default="true" type="boolean" />
    <cfif arguments.instanceOnly >
      <cfdump var="#variables#" >
    <cfelse>
      <cfreturn variables />
    </cfif>
  </cffunction>


  <cffunction name="state" access="public" hint="returns the object's persistent state" returntype="struct" output="false">
    <cfargument name="instanceOnly" required="no" default="true" type="boolean" />

    <cfif arguments.instanceOnly >
      <cfreturn variables />
    <cfelse>
      <cfreturn variables />
    </cfif>
  </cffunction>


  <cffunction name="instanceOf" access="public" returntype="boolean" output="false">
    <cfargument name="className" type="string" required="yes" />
    <cfargument name="obj" type="any" required="no" default="#this#" />

    <cfset var md = getMetaData( obj ) />
    <cfset var ret = false />

    <cfif ( md.name eq className ) >
       <cfreturn true />
    </cfif>

    <cfif ( structKeyExists( md, 'extends' ) ) >
      <cfset ret = instanceOf( arguments.className, md.extends ) />
    </cfif>

    <cfreturn ret />
  </cffunction>


  <cffunction name="sameAs" access="public" hint="true if the identity of both components match" returntype="boolean" output="false">
    <cfargument name="object" type="any" required="true" />
    <!--- no check to see if arguments.object has a getIdentity() method --->
    <cfreturn ( arguments.object.getIdentity() eq this.getIdentity() ) />
  </cffunction>


  <cffunction name="equalTo" access="public" output="false" returntype="boolean">
    <cfargument name="object" type="any" required="true" />
    <!--- equalTo needs to be symmetric: a.equalTo(b) should return the same result as b.equalTo(a) --->
      <cfthrow type="org.gliint.framework.util.Object.equaltToAbstractMethod" message="abstract method, must be overridden" />
     <cfreturn false />
  </cffunction>


  <cffunction name="asString" access="public" hint="" returntype="string" output="false">
    <!--- asString(): string -- returns a string representation of the object  --->
      <cfthrow type="org.gliint.framework.util.Object.asStringAbstractMethod" message="abstract method, must be overridden" />
     <cfreturn false />
  </cffunction>


  <!--- cffunction name="kindOf" access="public" hint="" returntype="boolean" output="false">
     kindOf(className: string): boolean -- true if className is the same as the value returned by the class method OR if className is the same as any of the object's superclasses
    <cfargument name="className" type="string" required="yes">

    <cfreturn ( arguments.className eq class() ) />
  </cffunction --->


  <cffunction name="getIdentity" access="public" hint="" returntype="uuid" output="false">
    <cfreturn variables['identity'] />
  </cffunction>


  <cffunction name="setIdentity" access="private" hint="" returntype="void" output="false">
    <cfargument name="identity" required="yes" type="uuid" />
    <cfset variables['identity'] = arguments.identity />
  </cffunction>


  <!----------------------------------------------------------------------------------
    Surprisingly, using cfscript to hide functions from metadata only works in WEB-INF.componenet.cfc,
    so in the interest of portability, the below are written using tag based format
  ----------------------------------------------------------------------------------->

  <!--- generic instance variable getter --->
  <cffunction name="get" access="public" output="false" returntype="any" >
    <cfargument name="name" required="true" type="string" />

    <cfset var f = 0 />

    <!---  if there's a getter in this object, use it --->
    <cfif ( structKeyExists( this, "get" & arguments.name ) and isCustomFunction( this["get" & arguments.name] ) ) >
      <cfset f = this["get" & arguments.name] />
      <cfreturn f() />
    </cfif>

    <!--- don't get a function as a variable --->
    <cfif ( StructKeyExists( variables, arguments.name ) and IsCustomFunction( arguments.name ) ) >
      <cfthrow type="org.gliint.Object.getException" message="cannot get a function as an instance variable" />
    </cfif>

    <!--- use generic; will throw exception if instance variable is not defined --->
    <cfreturn variables["_instance"][arguments.name] />
  </cffunction>


  <!--- generic setter, instance variables only --->
  <cffunction name="set" access="public" output="false" returntype="any" >
    <cfargument name="name" required="true" type="string" />
    <cfargument name="value" required="true" type="any" />

    <cfset var f = 0 />

    <!--- don't set a function as a variable --->
    <cfif ( structKeyExists( variables, arguments.name ) and isCustomFunction( arguments.name ) ) >
      <cfthrow type="org.gliint.framework.util.Object.setException" message="cannot set a function as an instance variable" />
    </cfif>

    <!--- the variable must already exist (been defined in the psuedo-constructor) --->
    <cfif ( not structKeyExists( variables, arguments.name ) ) >
      <cfthrow type="org.gliint.framework.util.Object.setException" message="instance variable #arguments.name# does not exist" />
    </cfif>

    <!---  if there's a setter in this object, use it --->
    <cfif ( structKeyExists( this, 'set' & arguments.name ) and isCustomFunction( this['set' & arguments.name] ) ) >
      <cfset f = this['set' & arguments.name] />
      <cfreturn f( arguments.value ) />
    </cfif>

    <!--- default: do generic --->
    <cfset variables[arguments.name] = arguments.value />

  </cffunction>


  <cffunction name="mixinOnInit" access="private" output="false" returntype="void" >
    <cfargument name="type" required="true" type="string" />

    <cfset var target = createObject( 'component', arguments.type ) />

    <cfset mixin( target ) />

    <cfif ( not listFind( getMetaData( this ).mixins, arguments.type )  ) >
      <cfset listAppend( getMetaData( this ).mixins, arguments.type ) />
    </cfif>

  </cffunction>


  <cffunction name="mixin" access="public" output="false" returntype="void" >
    <cfargument name="obj" required="true" type="any" />
    <cfargument name="overwrite" required="false" type="boolean" default="false" />

    <!---
    // this method is a variation on Sean Corfield's at http://corfield.org/blog/index.cfm/do/blog.entry/entry/Mixins

    // third arg of StructAppend may protect variables and methods from being
    // overwritten if they are already in the object.  Methods which already exist
    // within the child object may be 'extending' those of the mixin, so it's probably better to keep them.

    // AFAIK, only the public methods of the target class are mixed in
    --->

    <cfset structAppend( this, arguments.obj, arguments.overwrite ) />
    <cfset structAppend( variables, arguments.obj, arguments.overwrite ) />

  </cffunction>

</cfcomponent>