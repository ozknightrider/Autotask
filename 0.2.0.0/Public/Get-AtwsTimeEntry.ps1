﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Get-AtwsTimeEntry
{
  <#
      .SYNOPSIS
      This function get a TimeEntry through the Autotask Web Services API.
      .DESCRIPTION
      This function get a TimeEntry through the Autotask Web Services API.
      .EXAMPLE
      Get-AtwsTimeEntry [-ParameterName] [Parameter value]
      Use Get-Help Get-AtwsTimeEntry
      .NOTES
      NAME: Get-AtwsTimeEntry
  #>
	  [CmdLetBinding(DefaultParameterSetName='Filter')]
    Param
    (
                [Parameter(
          Mandatory = $true,
          ValueFromRemainingArguments = $true,
          ParameterSetName = 'Filter')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Filter ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $id
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $TaskID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $TicketID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $InternalAllocationCodeID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('TroubleTicket','ITServiceRequest','SalesLead','ProjectRequest','Activity','ProjectTask','UnassignedTask','ProjectMilestone','ProjectActionItem','CompanyTask','TravelTime','ProjectPhase','ClientTask','PersonalTime','VacationTime','SickTime','PaidTimeOff')]

        [String]
         $Type
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $DateWorked
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $StartDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $EndDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $HoursWorked
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $HoursToBill
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $OffsetHours
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $SummaryNotes
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $InternalNotes
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $RoleID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $CreateDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ResourceID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $CreatorUserID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $LastModifiedUserID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $LastModifiedDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $AllocationCodeID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ContractID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [boolean]
         $ShowOnInvoice
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [boolean]
         $NonBillable
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $BillingApprovalLevelMostRecent
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $BillingApprovalResourceID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $BillingApprovalDateTime
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $ContractServiceID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $ContractServiceBundleID
 ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('id','TaskID','TicketID','InternalAllocationCodeID','DateWorked','StartDateTime','EndDateTime','HoursWorked','HoursToBill','OffsetHours','SummaryNotes','InternalNotes','RoleID','CreateDateTime','ResourceID','CreatorUserID','LastModifiedUserID','LastModifiedDateTime','AllocationCodeID','ContractID','ShowOnInvoice','NonBillable','BillingApprovalLevelMostRecent','BillingApprovalResourceID','BillingApprovalDateTime','ContractServiceID','ContractServiceBundleID')]
        [String[]]
        $NotEquals ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('id','TaskID','TicketID','InternalAllocationCodeID','DateWorked','StartDateTime','EndDateTime','HoursWorked','HoursToBill','OffsetHours','SummaryNotes','InternalNotes','RoleID','CreateDateTime','ResourceID','CreatorUserID','LastModifiedUserID','LastModifiedDateTime','AllocationCodeID','ContractID','ShowOnInvoice','NonBillable','BillingApprovalLevelMostRecent','BillingApprovalResourceID','BillingApprovalDateTime','ContractServiceID','ContractServiceBundleID')]
        [String[]]
        $GreaterThan ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('id','TaskID','TicketID','InternalAllocationCodeID','DateWorked','StartDateTime','EndDateTime','HoursWorked','HoursToBill','OffsetHours','SummaryNotes','InternalNotes','RoleID','CreateDateTime','ResourceID','CreatorUserID','LastModifiedUserID','LastModifiedDateTime','AllocationCodeID','ContractID','ShowOnInvoice','NonBillable','BillingApprovalLevelMostRecent','BillingApprovalResourceID','BillingApprovalDateTime','ContractServiceID','ContractServiceBundleID')]
        [String[]]
        $GreaterThanOrEqual ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('id','TaskID','TicketID','InternalAllocationCodeID','DateWorked','StartDateTime','EndDateTime','HoursWorked','HoursToBill','OffsetHours','SummaryNotes','InternalNotes','RoleID','CreateDateTime','ResourceID','CreatorUserID','LastModifiedUserID','LastModifiedDateTime','AllocationCodeID','ContractID','ShowOnInvoice','NonBillable','BillingApprovalLevelMostRecent','BillingApprovalResourceID','BillingApprovalDateTime','ContractServiceID','ContractServiceBundleID')]
        [String[]]
        $LessThan ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('id','TaskID','TicketID','InternalAllocationCodeID','DateWorked','StartDateTime','EndDateTime','HoursWorked','HoursToBill','OffsetHours','SummaryNotes','InternalNotes','RoleID','CreateDateTime','ResourceID','CreatorUserID','LastModifiedUserID','LastModifiedDateTime','AllocationCodeID','ContractID','ShowOnInvoice','NonBillable','BillingApprovalLevelMostRecent','BillingApprovalResourceID','BillingApprovalDateTime','ContractServiceID','ContractServiceBundleID')]
        [String[]]
        $LessThanOrEquals ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('SummaryNotes','InternalNotes')]
        [String[]]
        $Like ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('SummaryNotes','InternalNotes')]
        [String[]]
        $NotLike ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('SummaryNotes','InternalNotes')]
        [String[]]
        $BeginsWith ,        

        [Parameter(
          ParameterSetName = 'By_Parameter'
        )]
        [ValidateSet('SummaryNotes','InternalNotes')]
        [String[]]
        $EndsWith
    )



          

  Begin
  { 
    If (-not($global:atws.Url))
    {
      Throw [ApplicationException] 'Not connected to Autotask WebAPI. Run Connect-AutotaskWebAPI first.'
    }
    Write-Verbose ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)

  }   

  Process
  {     

    If (-not($Filter))
    {
        $Fields = $Atws.GetFieldInfo('TimeEntry')
        
        Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
        {
            $Field = $Fields | Where-Object {$_.Name -eq $Parameter.Key}
            If ($Field.IsPickList)
            {
              $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value}
              $Value = $PickListValue.Value
            }
            Else
            {
              $Value = $Parameter.Value
            }
            $Filter += $Parameter.Key
            $Filter += '-eq'
            $Filter += $Value
        }
        
    }

    Get-AtwsData -Entity TimeEntry -Filter $Filter }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
