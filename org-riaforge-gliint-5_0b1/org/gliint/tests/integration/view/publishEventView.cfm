<cfset red = "FF3E3C" />
<cfset green = "57FF5D" />
<cfoutput>

<table style="border: 1px solid black;">
<tr style="border: 1px solid black;">
	<th>Publish Event Tests</th>
</tr>

<cfset test = ( structKeyExists( attributes.event, 'listener1' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event listener1 exists</td>
</tr>

<cfset test = ( attributes.event.listener1 eq 'listener1 is here' ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event.listener1 = "listener1 is here"</td>
</tr>

<cfset test = ( structKeyExists( attributes.event, 'listener2' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event.listener2 exists</td>
</tr>

<cfset test = ( attributes.event.listener2 eq 'listener2 is here' ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event.listener2 = "listener2 is here"</td>
</tr>

<cfset test = ( structKeyExists( attributes.event, 'count' ) ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event.count exists</td>
</tr>

<cfset test = ( attributes.event.count eq 2 ) />
<cfset style='style="border: 1px solid black; background-color: ###iif( test ,de(green), de(red) )#;" '/>
<tr>
	<td #style#>event.count = 2</td>
</tr>
</table>
</cfoutput>
<cfexit method="exittag">