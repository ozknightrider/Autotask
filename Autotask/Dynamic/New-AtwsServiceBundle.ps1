﻿#Requires -Version 4.0
#Version 1.6.2.11
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function New-AtwsServiceBundle
{


<#
.SYNOPSIS
This function creates a new ServiceBundle through the Autotask Web Services API. All required properties are marked as required parameters to assist you on the command line.
.DESCRIPTION
The function supports all properties of an [Autotask.ServiceBundle] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values. Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter. To get the ServiceBundle with Id number 0 you could write 'New-AtwsServiceBundle -Id 0' or you could write 'New-AtwsServiceBundle -Filter {Id -eq 0}.

'New-AtwsServiceBundle -Id 0,4' could be written as 'New-AtwsServiceBundle -Filter {id -eq 0 -or id -eq 4}'. For simple queries you can see that using parameters is much easier than the -Filter option. But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday). As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new ServiceBundle you need the following required fields:
 -Name
 -PeriodType
 -AllocationCodeID

Entities that have fields that refer to the base entity of this CmdLet:

BillingItem
 ContractServiceBundle
 ContractServiceBundleAdjustment
 ContractServiceBundleUnit
 InstalledProduct
 PriceListServiceBundle
 QuoteItem
 ServiceBundleService

.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.ServiceBundle]. This function outputs the Autotask.ServiceBundle that was created by the API.
.EXAMPLE
$Result = New-AtwsServiceBundle -Name [Value] -PeriodType [Value] -AllocationCodeID [Value]
Creates a new [Autotask.ServiceBundle] through the Web Services API and returns the new object.
 .EXAMPLE
$Result = Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle 
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle | Set-AtwsServiceBundle -ParameterName <Parameter Value>
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsServiceBundle to modify the object.
 .EXAMPLE
$Result = Get-AtwsServiceBundle -Id 124 | New-AtwsServiceBundle | Set-AtwsServiceBundle -ParameterName <Parameter Value> -Passthru
Copies [Autotask.ServiceBundle] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsServiceBundle to modify the object and returns the new object.

.LINK
Remove-AtwsServiceBundle
 .LINK
Get-AtwsServiceBundle
 .LINK
Set-AtwsServiceBundle

#>

  [CmdLetBinding(DefaultParameterSetName='By_parameters', ConfirmImpact='Low')]
  Param
  (
# An array of objects to create
    [Parameter(
      ParameterSetName = 'Input_Object',
      ValueFromPipeline = $true
    )]
    [ValidateNotNullOrEmpty()]
    [Autotask.ServiceBundle[]]
    $InputObject,

# service_bundle_name
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,150)]
    [string]
    $Name,

# service_bundle_description
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,200)]
    [string]
    $Description,

# unit_price
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitPrice,

# discount_dollars
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitDiscount,

# discount_percent
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $PercentageDiscount,

# period_type
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [String]
    $PeriodType,

# allocation_code_id
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $AllocationCodeID,

# active
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [boolean]
    $IsActive,

# create_by_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $CreatorResourceID,

# update_by_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $UpdateResourceID,

# create_date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [datetime]
    $CreateDate,

# Invoice Description
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,1000)]
    [string]
    $InvoiceDescription,

# update_date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [datetime]
    $LastModifiedDate,

# Service Level Agreement Id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String]
    $ServiceLevelAgreementID,

# Unit Cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitCost
  )
 
  Begin
  { 
    $EntityName = 'ServiceBundle'
           
    # Enable modern -Debug behavior
    If ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {$DebugPreference = 'Continue'}
    
    Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    
    $ProcessObject = @()
  }

  Process
  {
    $Fields = Get-AtwsFieldInfo -Entity $EntityName
    
    If ($InputObject)
    {
      Write-Verbose ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)  
      
      $CopyNo = 1

      Foreach ($Object in $InputObject) 
      { 
        # Create a new object and copy properties
        $NewObject = New-Object Autotask.$EntityName
        
        # Copy every non readonly property
        $FieldNames = $Fields.Where({$_.Name -ne 'id'}).Name
        If ($PSBoundParameters.ContainsKey('UserDefinedFields')) {
          $FieldNames += 'UserDefinedFields'
        }
        Foreach ($Field in $FieldNames)
        {
          $NewObject.$Field = $Object.$Field
        }
        If ($NewObject -is [Autotask.Ticket])
        {
          Write-Verbose ('{0}: Copy Object mode: Object is a Ticket. Title must be modified to avoid duplicate detection.' -F $MyInvocation.MyCommand.Name)  
          $Title = '{0} (Copy {1})' -F $NewObject.Title, $CopyNo
          $CopyNo++
          $NewObject.Title = $Title
        }
        $ProcessObject += $NewObject
      }   
    }
    Else
    {
      Write-Debug ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $EntityName) 
      $ProcessObject += New-Object Autotask.$EntityName    
    }
    
    Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
    {
      $Field = $Fields | Where-Object {$_.Name -eq $Parameter.Key}
      If ($Field -or $Parameter.Key -eq 'UserDefinedFields')
      { 
        If ($Field.IsPickList)
        {
          If($Field.PickListParentValueField)
          {
            $ParentField = $Fields.Where{$_.Name -eq $Field.PickListParentValueField}
            $ParentLabel = $PSBoundParameters.$($ParentField.Name)
            $ParentValue = $ParentField.PickListValues | Where-Object {$_.Label -eq $ParentLabel}
            $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value -and $_.ParentValue -eq $ParentValue.Value}                
          }
          Else 
          { 
            $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value}
          }
          $Value = $PickListValue.Value
        }
        Else
        {
          $Value = $Parameter.Value
        } 

        Foreach ($Object in $ProcessObject) 
        { 
          $Object.$($Parameter.Key) = $Value
        }
      }
    }    

    $Result = New-AtwsData -Entity $ProcessObject
  }

  End
  {
    Write-Debug ('{0}: End of function, returning {1} {2}(s)' -F $MyInvocation.MyCommand.Name, $Result.count, $EntityName)
    Return $Result
  }

}
