<cfset structAppend( variables, attributes, true ) />

<cfset red = "FF3E3C" />
<cfset green = "57FF5D" />
<cfoutput>
<table style="border: 1px solid black;">
<tr style="border: 1px solid black;">
	<th>Notify Tests</th>
</tr>

<cfset test = ( structKeyExists( response, 'listener1' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener1 exists</td>
</tr>

<cfset test = ( response.listener1 eq 'listener1 is here') />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener1 = "listener1 is here"</td>
</tr>


<cfset test = ( not structKeyExists( response, 'listener2' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener2 does not exist</td>
</tr>


<cfset test = ( structKeyExists( response, 'listener3' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener3 exists</td>
</tr>

<cfset test = ( response.listener3 eq 'listener3 is here') />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener3 = "listener3 is here"</td>
</tr>


<cfset test = ( structKeyExists( response, 'listener5' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener5 exists</td>
</tr>

<cfset test = ( response.listener5 eq 'listener5 is here') />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>response.listener5 = "listener5 is here"</td>
</tr>

</table>
</cfoutput>
<cfexit method="exittag">