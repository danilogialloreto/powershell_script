Function Get-ExCommand 
{  
  <# 
   .Synopsis 
    This function emulates the Get-ExCommand function from the Exchange 
    Management Shell   
   .Description 
    This function emulates the Get-ExCommand function from the Exchange 
    Management Shell. It is useful when doing implicit remoting into a  
    remote Exchange server. 
   .Example 
    Get-ExCommand 
    Returns all of the Exchange functions 
   .Example 
    Get-ExCommand database 
    Returns only Exchange functions that contain the word database  
   .Parameter Name 
    The exact name of an Exchange cmdlet, or the partial name 
   .Notes 
    NAME:  Get-ExCommand 
    AUTHOR: ed wilson, msft 
    LASTEDIT: 01/17/2012 14:25:35 
    KEYWORDS: Messaging & Communication, Microsoft Exchange 2010 
    HSG: HSG-1-24-12 
   .Link 
     Http://www.ScriptingGuys.com 
 #Requires -Version 2.0 
 #> 
 Param ([string]$name) 
 If(!($name)) 
  {Get-Command -Module $global:importresults |  
   Where-Object { $_.commandtype -eq 'function' -AND $_.name -match '-'} } 
 Else 
  {Get-Command -Module $global:importresults |  
   Where-Object { $_.commandtype -eq 'function' -AND  
   $_.name -match '-' -AND $_.name -match $name} } 
} #end function Get-ExCommand

