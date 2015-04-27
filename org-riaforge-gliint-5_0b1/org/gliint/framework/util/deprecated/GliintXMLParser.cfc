<cfcomponent name="GliintXMLParser" output="false">
<!---
  org.gliint.framework.context.GliintXMLParser.cfc

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
  <cfset variables['instance']['configSource'] = "" />
  <cfset variables['instance']['resources'] = false />

  <!--- ------------------------------------------------------------------------------>

  <cffunction name="init" access="public" returntype="org.gliint.framework.context.GliintXMLParser" output="false">
    <cfset variables['instance']['resources'] = structNew() />
    <cfreturn this />
  </cffunction>


	<cffunction name="getCommandHandlerConfigData" access="public" returntype="struct" output="false">
		<cfargument name="id" type="string" required="true" />
    <cfargument name="source" type="string" required="false" default="#getConfigSource()#" />

    <cfset var x = ""  />
    <cfset var arr = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var r = "" />
    <cfset var cd = structNew() />

    <cfset x = parseXML( arguments.source ) />

    <cfif isNotEmptyXML( x ) >
      <!--- if x is not a blank document, we'll try to process it --->
       <cftrace type="information" text="GliintXMLParser getCommandHandlerConfigData from #arguments.source#">

      <cfset variables['instance']['resources'][arguments.source] = reconfigHash( arguments.source ) />

      <cfset cd = parseCommandHandlers( XMLsearch( x, "gliint/commandHandlers/commandHandler[@name='#arguments.id#']" ) ) />

		</cfif>

		<cfreturn cd />
	</cffunction>


  <cffunction name="createConfigData" access="public" returntype="struct" output="false">
    <cfargument name="configData" type="struct" required="false" default="#structNew()#" />
    <cfargument name="source" type="string" required="false" default="#getConfigSource()#" />

    <cfset var x = ""  />
    <cfset var arr = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var r = "" />
    <cfset var cd = duplicate( arguments.configData ) />

    <cfif (not structKeyExists( cd, 'commandHandlers' ) ) >
      <cfset cd['commandHandlers'] = structNew() />
    </cfif>

    <cfset x = parseXML( arguments.source ) />

    <cfif isNotEmptyXML( x ) >
      <!--- if x is not a blank document, we'll try to process it --->
       <cftrace  type="information" text="GliintXMLParser creating configuration data for #arguments.source#">

      <cfset variables['instance']['resources'][arguments.source] = reconfigHash( arguments.source ) />

      <!---
      we really do want the overwrite attribute to be 'true',
      so child configuration data can overwrite a parent's
      --->
      <!--- as of version 5, global properties are placed in ColdSpring
       cfset structAppend( cd['properties'], parseProperties( XMLsearch( x, 'gliint/properties/property' ) ), true ) / --->
      <cfset structAppend( cd['commandHandlers'], parseCommandHandlers( XMLsearch( x, 'gliint/commandHandlers/commandHandler' ) ), true ) />

      <!--- now do imports --->
      <cfset arr = XMLsearch( x, 'gliint/import' ) />
      <cfloop condition="i lt arrayLen( arr )" >
        <cfset i = i + 1 />
        <cfset r = arr[i]['xmlAttributes']['resource'] />
        <cftrace  type="information" text="GliintXMLParser parsing import for resource #r#" />
        <cfset cd = createConfigData( cd, r ) />
      </cfloop>

    </cfif>

     <cftrace  type="information" text="GliintXMLParser completed creating configuration data for #arguments.source#">
    <cfreturn cd />
  </cffunction>


  <cffunction name="parseXML" access="private" returntype="xml" >
    <cfargument name="resource" type="string" required="true" />

    <cfset var k = true />
    <cfset var x = "" />
    <cfset var validation = structNew() />
    <cfset var p = expandPath( arguments.resource ) />

    <cfif ( not fileExists( p ) ) >
       <cftrace  type="error" text="GliintXMLParser: file #p# is not available" />
      <cfset k = false />
    </cfif>

    <cftry>
      <cfset x = xmlParse( p, true ) />
      <cfcatch type="coldfusion.xml.XmlProcessException" >
        <cftrace  type="error" text="could not parse file #p#, file contents are NOT added to configuration data! (coldfusion.xml.XmlProcessException)" />
        <cfset k = false />
      </cfcatch>
    </cftry>

    <cfif ( k and ( not isXML( x ) ) ) >
       <cftrace  type="error" text="the xml from #p# is not well-formed XML, file contents are NOT added to configuration data!" />
      <cfset k = false />
    </cfif>

    <cfif k >
      <cfset validation = xmlValidate( x, '/org/gliint/resources/gliint.xsd' ) />
      <cfif ( validation.status is false ) >
        <cftrace  type="warning" text="Gliint XMLParser validation error for #p#" />
      </cfif>
      <cfreturn x />
    </cfif>

    <cfreturn xmlNew( true ) />
  </cffunction>


  <cffunction name="parseProperties" access="private" returntype="struct" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var st = structNew() />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var name = "" />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset name = arguments.arr[i]['xmlAttributes']['name'] />

      <cfset st[name] = "" />
      <!--- try shortcut syntax first --->
      <cfif ( structKeyExists( arguments.arr[i]['xmlAttributes'], 'value' ) ) >
        <cfset st[name] = arguments.arr[i]['xmlAttributes']['value'] />
      </cfif>
      <!--- using full syntax will overwrite --->
       <cfset st[name] = parseValues( XMLsearch( arguments.arr[i], 'value' ), st[name] ) />
    </cfloop>

    <cfreturn st />
  </cffunction>


  <cffunction name="parseCommandHandlers" access="private" returntype="struct" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var st = structNew() />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var i = 0 />
    <cfset var a = arrayNew(1) />
    <cfset var ch = structNew() />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />

      <!--- ch is a single commandHandler config --->
      <cfset ch = structNew() />

      <cfset ch['name'] = ""/>
      <cfif ( structKeyExists( arguments.arr[i].xmlAttributes, 'name' ) ) >
        <cfset ch['name'] = arguments.arr[i].xmlAttributes['name'] />
      </cfif>

      <cfset ch['access'] = "public" />
      <cfif ( structKeyExists( arguments.arr[i].xmlAttributes, 'access' ) ) >
        <cfset ch['access'] = arguments.arr[i].xmlAttributes['access'] />
      </cfif>

      <cfset ch['class'] = "" />
      <cfif ( structKeyExists( arguments.arr[i].xmlAttributes, 'class' ) ) >
        <cfset ch['class'] = arguments.arr[i].xmlAttributes['class'] />
      </cfif>

      <cfset ch['factory-bean'] = "" />
      <cfif ( structKeyExists( arguments.arr[i].xmlAttributes, 'factory-bean' ) ) >
        <cfset ch['factory-bean'] = arguments.arr[i].xmlAttributes['factory-bean'] />
      </cfif>

      <cfset ch['factory-method'] = "" />
      <cfif ( structKeyExists( arguments.arr[i].xmlAttributes, 'factory-method' ) ) >
        <cfset ch['factory-method'] = arguments.arr[i].xmlAttributes['factory-method'] />
      </cfif>

      <cfif ( len( ch['class'] ) + len( ch['factory-bean'] ) + len( ch['factory-method'] ) eq 0 ) >
        <cfset ch['class'] = "org.gliint.lexicons.gliint.Null" />
        <cfset ch['name'] = "null"/>
      </cfif>

      <cfset ch['method'] = structNew() />
      <cfset ch['method']['name'] = "execute" />
      <cfset ch['method']['args'] = structNew() />
      <!--- try shortcut syntax first --->
      <cfif ( structKeyExists( arguments.arr[i]['xmlAttributes'], 'method' ) ) >
        <cfset ch['method']['name'] = arguments.arr[i]['xmlAttributes']['method'] />
      </cfif>
      <!--- using full syntax will overwrite --->
       <cfset ch['method'] = parseMethod( XMLsearch( arguments.arr[i], 'method' ), ch['method']['name'] ) />


      <cfset ch['comment'] = "" />
      <cfset a = XMLsearch( arguments.arr[i], 'comment' ) />
      <cfif ( arrayLen(a) gt 0 ) >
        <cfset ch['comment'] = a[1]['XmlText'] />
      </cfif>

      <cfset ch['properties'] = parseProperties( XMLsearch( arguments.arr[i], 'properties/property' ) ) />
      <cfset ch['preprocess'] = parseProcess( XMLsearch( arguments.arr[i], 'preprocess' ) ) />
      <!---cfset ch['process'] = parseProcess( XMLsearch( arguments.arr[i], 'process' ) ) / --->
      <cfset ch['postprocess'] = parseProcess( XMLsearch( arguments.arr[i], 'postprocess' ) ) />
      <cfset ch['messages'] = parseMessages( XMLsearch( arguments.arr[i], 'messages/message' ) ) />

       <cfset st[ch['name']] = ch />

    </cfloop>

    <cfreturn st />
  </cffunction>


  <cffunction name="parseMessages" access="private" returntype="struct" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var st = structNew() />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var message = "" />
    <cfset var hint = "" />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset message = arguments.arr[i]['xmlAttributes']['name'] />

      <!--- optional hint --->
      <cfset hint = "" />
      <cfif structKeyExists( arguments.arr[i]['xmlAttributes'], 'hint' ) >
        <cfset hint = arguments.arr[i]['xmlAttributes']['hint'] />
      </cfif>

      <cfset st[message] = hint />
    </cfloop>
<!---
<cfif not structIsEmpty(st)>
<cfdump var="#st#">
<cfabort>
</cfif>
--->
    <cfreturn st />
  </cffunction>


  <cffunction name="parseProcess" access="private" returntype="struct" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var p = structNew() />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfset p['responses'] = arrayNew(1) />
    <cfset p['rules'] = arrayNew(1) />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset p['responses'] = parseResponses( XMLsearch( arguments.arr[i], 'response' ) ) />
      <cfset p['rules'] = parseRules( XMLsearch( arguments.arr[i], 'rule' ) ) />
    </cfloop>

    <cfreturn p />
  </cffunction>


  <cffunction name="parseResponses" access="private" returntype="array" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var returnArr = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var r = structNew() />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var st = structNew() />
    <cfset var tempArr = arrayNew(1) />
    <cfset var tmp = 0 />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />

      <!--- r is a single response --->
      <cfset r = structNew() />
      <cfset r['name'] = arguments.arr[i]['xmlAttributes']['name'] />

      <cfset r['value'] = "" />
      <!--- try shortcut (attribute) syntax first --->
      <cfif ( structKeyExists( arguments.arr[i]['xmlAttributes'], 'value' ) ) >
        <cfset r['value'] = arguments.arr[i]['xmlAttributes']['value'] />
      </cfif>

      <!--- using full (element) syntax will overwrite --->
      <cfset r['value'] = parseValues( XMLsearch( arguments.arr[i], 'value' ), r['value'] ) />
      <cfset r['value'] = parseList( XMLsearch( arguments.arr[i], 'list' ), r['value'] ) />
      <cfset r['value'] = parseMap( XMLsearch( arguments.arr[i], 'map' ), r['value'] ) />

      <cfset r['class'] = "" />
      <cfset r['fields'] = "" />
      <cfset r['factoryBean'] = "" />
      <cfset r['factoryMethod'] = "" />
      <cfset r['method'] = "" />
      <cfset r['args'] = structNew() />
      <cfset r['properties'] = structNew() />

      <cfset tmp = structNew() />
      <cfset tmp = parseBean( XMLsearch( arguments.arr[i], 'bean' ), tmp ) />
      <cfif ( not structIsEmpty( tmp ) ) >
        <!--- flatten it out for now --->
        <cfset r['class'] = tmp.class />
        <cfset r['fields'] = tmp.fields />
        <cfset r['factoryBean'] = tmp.factoryBean />
        <cfset r['factoryMethod'] = tmp.factoryMethod />
        <cfset r['method'] = tmp.method.name />
        <cfset r['args'] = tmp.method.args />
        <cfset r['properties'] = tmp.properties />
      </cfif>

      <!--- optional sequence --->
      <cfset r['sequence'] = 0 />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'sequence') >
        <cfset r['sequence'] = arguments.arr[i]['xmlAttributes']['sequence'] />
      </cfif>

      <cfif r['sequence'] eq 0 >
         <!--- if it has no assigned sequence we'll just put it next in the return array --->
        <cfset arrayAppend( returnArr, r ) />
      <cfelse>
        <!--- it has an assigned sequence. We'll put it in the right place later
          for now, put it in a struct for safekeeping. If the struct already has an entry for this sequence,
          this one should appear after the first, as it appears in the xml
          - this is because the current xsd does not require unique sequence numbers
          - at minimum we must assure that one does not overwrite the other
         --->
        <cfloop condition="structKeyExists(st, r['sequence'])" >
          <cfset r['sequence'] = r['sequence'] + 1 />
        </cfloop>
        <cfset st[r['sequence']] = r />
      </cfif>

    </cfloop>

    <cfset tempArr = structSort(st,'numeric','asc','sequence') />
    <cfset sz = arrayLen( tempArr ) />
    <cfset i = 0 />
    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset r = st[tempArr[i]] />
      <cfif arrayLen( returnArr) gte r['sequence'] >
        <cfset arrayInsertAt( returnArr, r['sequence'], r ) />
      <cfelse>
        <cfset arrayAppend( returnArr, r ) />
      </cfif>
    </cfloop>

    <cfreturn returnArr />
  </cffunction>


  <cffunction name="parseRules" access="private" returntype="array" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var returnArr = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var r = structNew() />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var st = structNew() />
    <cfset var tempArr = arrayNew(1) />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset r = structNew() />

      <cfset r['conditions'] = parseConditions( XMLsearch( arguments.arr[i], 'conditions/condition' ) ) />
      <cfset r['commands'] = parseCommands( XMLsearch( arguments.arr[i], 'commands/command' ) ) />

      <cfset r['onMatch'] = "next" />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'onMatch') >
        <cfset r['onMatch'] = arguments.arr[i]['xmlAttributes']['onMatch'] />
      </cfif>

      <!--- note in this case salience is REQUIRED --->
      <cfset r['salience'] = arguments.arr[i]['xmlAttributes']['salience'] />
      <!--- bump in case of duplicates. bad xml writers! --->
      <cfloop condition="structKeyExists(st, r['salience'])" >
        <cfset r['salience'] = r['salience'] + 1 />
      </cfloop>
      <cfset st[r['salience']] = r />

    </cfloop>

    <!--- <cfreturn resequence( returnArr, st, 'salience' ) /> --->

    <cfset tempArr = structSort(st,'numeric','asc','salience') />
    <cfset sz = arrayLen( tempArr ) />
    <cfset i = 0 />
    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset r = st[tempArr[i]] />
      <cfif arrayLen( returnArr) gte r['salience'] >
        <cfset arrayInsertAt( returnArr, r['salience'], r ) />
      <cfelse>
        <cfset arrayAppend( returnArr, r ) />
      </cfif>
    </cfloop>

    <cfreturn returnArr />
  </cffunction>

  <!--- todo implement nested <conditions> elements
  to group expressions properly and also have the ability to perform short circuit evaluations --->
  <cffunction name="parseConditions" access="private" returntype="array" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var returnArr = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var c = structNew() />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset c = structNew() />

      <cfset c['conjunction'] = "" />
      <cfif structKeyExists( arguments.arr[i]['xmlAttributes'], 'conjunction') and ( i gt 1 ) >
        <cfset c['conjunction'] = arguments.arr[i]['xmlAttributes']['conjunction'] />
      </cfif>

      <cfset c['key'] = arguments.arr[i]['xmlAttributes']['key'] />
      <cfset c['operator'] = arguments.arr[i]['xmlAttributes']['operator'] />

      <cfset c['value'] = "" />
      <cfif structKeyExists( arguments.arr[i]['xmlAttributes'], 'value' ) >
        <cfset c['value'] = arguments.arr[i]['xmlAttributes']['value'] />
      </cfif>

      <cfset returnArr[i] = c />
    </cfloop>

    <cfreturn returnArr />
  </cffunction>


  <cffunction name="parseCommands" access="private" returntype="array" output="false" >
    <cfargument name="arr" type="array" required="true" />

    <cfset var returnArr = arrayNew(1) />
    <cfset var st = structNew() />
    <cfset var c = structNew() />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var tempArr = arrayNew(1) />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset c = structNew() />
      <cfset c['name'] = arguments.arr[i]['xmlAttributes']['name'] />
      <cfset c['bind'] = arguments.arr[i]['xmlAttributes']['bind'] />
      <cfset c['sequence'] = 0 />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'sequence') >
        <cfset c['sequence'] = arguments.arr[i]['xmlAttributes']['sequence'] />
      </cfif>

      <cfset c['args'] = parseProperties( XMLsearch( arguments.arr[i], 'arg' ) ) />

      <!--- about the same routine as with responses, see comments there --->
      <cfif c['sequence'] eq 0 >
        <cfset arrayAppend( returnArr, c ) />
      <cfelse>
        <cfloop condition="structKeyExists(st, c['sequence'])" >
          <cfset c['sequence'] = c['sequence'] + 1 />
        </cfloop>
        <cfset st[c['sequence']] = c />
      </cfif>

    </cfloop>

    <!--- <cfreturn resequence( returnArr, st, 'sequence' ) /> --->

    <cfset tempArr = structSort(st,'numeric','asc','sequence') />
    <cfset sz = arrayLen( tempArr ) />
    <cfset i = 0 />
    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset c = st[tempArr[i]] />
      <cfif arrayLen( returnArr) gte c['sequence'] >
        <cfset arrayInsertAt( returnArr, c['sequence'], c ) />
      <cfelse>
        <cfset arrayAppend( returnArr, c ) />
      </cfif>
    </cfloop>

    <cfreturn returnArr />
  </cffunction>


  <cffunction name="parseValues" access="private" returntype="any" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="dflt" type="any" required="false" />

    <cfset var v = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfif structKeyExists( arguments, 'dflt' ) >
      <cfset v = arguments.dflt />
    </cfif>

    <!--- there is at least one element value even though it could be blank --->
    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />

      <cfif ( sz eq 1 ) >
        <cfset v = arguments.arr[i]['XmlText'] />
          <cfset v = parseList( XMLsearch( arguments.arr[i], 'list' ), v ) />
          <cfset v = parseMap( XMLsearch( arguments.arr[i], 'map' ), v ) />
         <cfset v = parseBean( XMLsearch( arguments.arr[i], 'bean' ), v ) />
      <cfelse>
        <cfif ( i eq 1 ) >
          <cfset v = arrayNew(1) />
        </cfif>
        <cfset v[i] = arguments.arr[i]['XmlText'] />
         <cfset v[i] = parseList( XMLsearch( arguments.arr[i], 'list' ), v[i] ) />
         <cfset v[i] = parseMap( XMLsearch( arguments.arr[i], 'map' ), v[i] ) />
         <cfset v[i] = parseBean( XMLsearch( arguments.arr[i], 'bean' ), v[i] ) />
      </cfif>

    </cfloop>

    <cfreturn v />
  </cffunction>


  <cffunction name="parseList" access="private" returntype="any" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="dflt" type="any" required="false" />

    <cfset var a = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfif structKeyExists( arguments, 'dflt' ) >
      <cfset a = arguments.dflt />
    </cfif>

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfif ( i eq 1 ) >
        <cfset a = arrayNew(1) />
      </cfif>

      <cfset a = parseValues( XMLsearch( arguments.arr[i], 'value' ), a ) />
    </cfloop>

     <cfreturn a />
  </cffunction>


  <cffunction name="parseMap" access="private" returntype="any" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="dflt" type="any" required="false" />

    <cfset var st = arrayNew(1) />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfif structKeyExists( arguments, 'dflt' ) >
      <cfset st = arguments.dflt />
    </cfif>

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset st = parseEntries( XMLsearch( arguments.arr[i], 'entry' ), st ) />
    </cfloop>

     <cfreturn st />
  </cffunction>


  <cffunction name="parseBean" access="private" returntype="any" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="dflt" type="any" required="false" />

    <cfset var b = structNew() >
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />

    <cfif structKeyExists( arguments, 'dflt' ) >
      <cfset b = arguments.dflt />
    </cfif>

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfif i eq 1 >
        <cfset b = structNew() />
      </cfif>

      <!--- optional class --->
      <cfset b['class'] = "" />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'class') >
        <cfset b['class'] = arguments.arr[i]['xmlAttributes']['class'] />
      </cfif>

      <!--- optional fields --->
      <cfset b['fields'] = "" />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'fields') >
        <cfset b['fields'] = arguments.arr[i]['xmlAttributes']['fields'] />
      </cfif>

      <!--- optional factory-bean --->
      <cfset b['factoryBean'] = "" />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'factory-bean') >
        <cfset b['factoryBean'] = arguments.arr[i]['xmlAttributes']['factory-bean'] />
      </cfif>

      <!--- optional factory-method --->
      <cfset b['factoryMethod'] = "" />
      <cfif structKeyExists(arguments.arr[i]['xmlAttributes'], 'factory-method') >
        <cfset b['factoryMethod'] = arguments.arr[i]['xmlAttributes']['factory-method'] />
      </cfif>

      <!--- method --->
      <cfset b['method'] = structNew() />
      <cfset b['method']['name'] = "" />
      <cfset b['method']['args'] = structNew() />
      <!--- try shortcut syntax first --->
      <cfif ( structKeyExists( arguments.arr[i]['xmlAttributes'], 'method' ) ) >
        <cfset b['method']['name'] = arguments.arr[i]['xmlAttributes']['method'] />
      </cfif>
      <!--- using full syntax will overwrite --->
       <cfset b['method'] = parseMethod( XMLsearch( arguments.arr[i], 'method' ), b['method']['name'] ) />

      <!--- properties --->
       <cfset b['properties'] = parseProperties( XMLsearch( arguments.arr[i], 'property' ) ) />

    </cfloop>

    <cfreturn b />
  </cffunction>


  <cffunction name="parseEntries" access="private" returntype="any" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="dflt" type="any" required="false" />

    <cfset var st = structNew() />
    <cfset var i = 0 />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var key = "" />
    <cfset var value = "" />

    <cfif structKeyExists( arguments, 'dflt' ) >
      <cfset st = arguments.dflt />
    </cfif>

    <cfloop condition="i lt sz" >
      <cfif i eq 0 >
        <cfset st = structNew() />
      </cfif>
      <cfset i = i + 1 />
      <cfset key = arguments.arr[i]['xmlAttributes']['key'] />

      <cfset st[key] = "" />
      <!--- try shortcut syntax first --->
      <cfif ( structKeyExists( arguments.arr[i]['xmlAttributes'], 'value' ) ) >
        <cfset st[key] = arguments.arr[i]['xmlAttributes']['value'] />
      </cfif>
      <!--- using full syntax will overwrite --->
       <cfset st[key] = parseValues( XMLsearch( arguments.arr[i], 'value' ), st[key] ) />
    </cfloop>

     <cfreturn st />
  </cffunction>


  <cffunction name="parseMethod" access="private" returntype="struct" output="false" >
    <cfargument name="arr" type="array" required="true" />
    <cfargument name="name" type="string" required="false" />

    <cfset var st = structNew() />
    <cfset var i = 1 />
    <cfset var sz = arrayLen( arguments.arr ) />
    <cfset var a = arrayNew(1) />

    <cfset st['name'] = "" />
    <cfset st['args'] = structNew() />
    <cfif structKeyExists( arguments, 'name' ) >
      <cfset st['name'] = arguments.name />
    </cfif>

    <!--- there can be only one --->
    <cfif ( sz gt 0 ) >
      <cfset st['name'] = arguments.arr[i]['xmlAttributes']['name'] />
      <cfset st['args'] = parseProperties( XMLsearch( arguments.arr[i], 'arg' ) ) />
    </cfif>

    <cfreturn st />
  </cffunction>

  <!--- todo debug and implement resequence in GliintXMLParser --->
  <cffunction name="resequence" access="private" returntype="array" output="false" >
    <cfargument name="a" type="array" required="true" />
    <cfargument name="st" type="struct" required="true" />
    <cfargument name="field" type="string" required="true" />

    <cfset var tempArr = structSort(st,'numeric','asc','sequence') />
    <cfset var sz = arrayLen( tempArr ) />
    <cfset var i = 0 />
    <cfset var c = structNew() />

    <cfloop condition="i lt sz" >
      <cfset i = i + 1 />
      <cfset c = st[tempArr[i]] />
      <cfif arrayLen( a ) gte c[field] >
        <cfset arrayInsertAt( a, c[field], c ) />
      <cfelse>
        <cfset arrayAppend( a, c ) />
      </cfif>
    </cfloop>

    <cfreturn a />
  </cffunction>


  <cffunction name="reconfigHash" access="private" returntype="string" output="false" >
    <cfargument name="resource" type="string" required="true" />

    <cfset var q = queryNew( 'name,directory,size,type,dateLastModified,attributes,mode' ) />
    <cfset var p = resourcePath( arguments.resource ) />
    <cfset var d = getDirectoryFromPath( p ) />
    <cfset var f = getFileFromPath( p ) />

    <cfdirectory action="list" name="q" directory="#d#" filter="#f#" />
    <cfreturn q.size & '|' & q.dateLastModified />
  </cffunction>


  <cffunction name="hasConfigChanged" access="public" returntype="boolean" output="false">

    <cfset var hasChanged = false />
    <cfset var h =  "" />
    <cfset var resource = "" />

    <cfif ( len( getConfigSource() ) eq 0 ) >
      <cfset hasChanged = true />
    </cfif>

    <cfloop collection="#variables['instance']['resources']#" item="resource" >
      <cfset h = reconfigHash( resource ) />
      <cfif ( variables['instance']['resources'][resource] neq h ) >
        <cfset variables['instance']['resources'][resource] = h />
        <cfset hasChanged = true />
        <cftrace  type="information" text="#resource# configuration file has changed, will reconfigure">
      </cfif>
    </cfloop>

    <cfreturn hasChanged />
  </cffunction>


  <cffunction name="setConfigSource" access="public" returntype="void" output="false" >
    <cfargument name="configSource" type="string" required="true" />
    <cfset variables['instance']['configSource'] = arguments.configSource />
  </cffunction>


  <cffunction name="getConfigSource" access="private" returntype="string" output="false" >
    <cfreturn variables['instance']['configSource'] />
  </cffunction>


  <cffunction name="getInstanceData" access="public" returntype="struct" output="false" >
    <cfreturn variables['instance'] />
  </cffunction>


  <cffunction name="resourcePath" access="private" returntype="string" output="false" >
    <cfargument name="resource" type="string" required="true" />
    <cfset var suffix = listLast( arguments.resource, '.' ) />
    <cfset var p = listChangeDelims( expandPath( arguments.resource ),  '/', '.\' ) />
    <cfreturn listDeleteAt( p , listLen( p, '/' ), '/' ) &  '.' & suffix />
  </cffunction>


  <cffunction name="isNotEmptyXML" access="private" returntype="boolean" output="false" >
    <cfargument name="x" required="true" type="xml" />

    <cfset var properties = XMLsearch( x, 'gliint/properties/property' ) />
    <cfset var commandHandlers = XMLsearch( x, 'gliint/commandHandlers/commandHandler' ) />
    <cfset var imports = XMLsearch( x, 'gliint/import' ) />

    <cfif ( ( arrayLen( properties ) + arrayLen( commandHandlers ) + arrayLen( imports ) ) gt 0 ) >
      <cfreturn true />
    </cfif>

    <cfreturn false />
  </cffunction>

</cfcomponent>