# Basics

Install the module from PowerShell Gallery (the published module version may lag a few days behind this code tree):

```powershell
# Download and install the module
Install-Module Autotask

# Connect to the Autotask Web Services API and load the module
# The first time you connect a disk cache will be created
$Credential = Get-Credential
$ApiKey = "<the API identifier from your resource in Autotask>"
Import-Module Autotask -ArgumentList $Credential, $ApiKey

# Lots of entities has picklists that are unique to your tenant
# When a picklist has been changed you will want to refresh the disk cache

Import-Module Autotask -ArgumentList $Credential, $ApiKey, 'Account'

# Refresh more than 1 entity
Import-Module Autotask -ArgumentList $Credential, $ApiKey, 'Account', 'Contact'

# Use wildcards
Import-Module Autotask -ArgumentList $Credential, $ApiKey, 'Acc*'

# Refresh all entities with picklists
Import-Module Autotask -ArgumentList $Credential, $ApiKey, '*'

## Refresh EVERYTHING in the cache and script functions on disk
# Will download all entities and detailed field info for all entities
Update-AtwsDiskCache

# Will recreate all .ps1 scripts for any entity with a picklist
Update-AtwsFunctions -FunctionSet Dynamic
```

# Release notes

## Version 1.6.1.5 - New Cache Model

- IMPORTANT: Module structure and load method has changed. Pass Credentials to Import-Module using -Variable: Import-Module Autotask -Variable $Credentials, $ApiKey (Connect-AutotaskWebAPI is still there as a wrapper for backwards compatibility).
- FEATURE: New cache model. The module caches entity info to disk, not functions.
- FEATURE: SPEED! Module load time has improved a LOT! Not all entities change all the time. Entities that does not have any picklist parameters are pre-built and included in the module to speed up module load time.
- NOTE! On first load a complete cache of any entity containing picklists have to be downloaded from your tenant and saved to disk.
- FEATURE: You can use -IsNull and wildcards with UserDefinedFields (Finally!)
- FEATURE: Is is now a single module. You pass your credentials directly to Import-Module to load everything in one go. Old behavior with Connect-AutotaskWebAPI is supported for backwards compatibility using aliases.
- FEATURE: The module now uses built-in prefix support in Import-Module. Import the module multiple times using different credentials and prefixes for complex, cross-tenant work (requires using -Force with Import-Module).
- FEATURE: Get entities that are referring TO any entity. Get AccountLocation by querying for the right Account(s).
- FEATURE: PickList labels are added to any entity by default.
- FEATURE: Reload the module with a different prefix and different credentials to code against two different tenants simultanously.
- Changed version number scheme to follow API version number.
- Minor bugfixes.

## Version 0.2.2.5

- BUGFIX: Parameter ID was typed as Integer when the correct type is Int64. Fixed. Thank you, Harry P.!

## Version 0.2.2.4

- Support for API version 1.6. Parameter ApiTrackingID added to Connect-AutotaskWebAPI.
- New function Get-AtwsInvoiceInfo. Downloads detailed invoice information based on Autotask InvoiceId.

Note: Connecting to API version 1.6 requires a personal API tracking ID code. You can create one on the security tab on the automation user resource that you use to connect to the API. **Warning**: Be aware that from the moment you create an API tracking ID on an automation user, the tracking code is *required*, regardless with API version you try to connect to.

## Version 0.2.2.3

- BUGFIX: Timezone setup in GET functions didn't persist an important value. Fixed.

## Version 0.2.2.2

- IMPORTANT: TLS 1.2 is now the default for all API calls
- Datetime parameter in GET functions are explicitly cast to Sortable Datetime format including UTC offset to ensure local time is interpreted correctly by the API.
- Datetime properties on returned objects are changed to local time for easier coding. No need to handle timezone offsets manually anymore,
- When updating objects the API has a limit of 200 objects per API call. The module now handles this correctly.
- You can now specify object to modify by passing their -Id to SET functions instead of -InputObject
- Expand UserDefinedFields by default in SET functions when using -PassThru

## Version 0.2.2.1

- Fixed WebServiceProxy unauthenticated first call issue. Any API call now touches the API endpoint only once (previously the API was touched once unauthenticated and when that failed .Net automatically tried again with authentication and the call succeeded)
- Added caching of Fieldinfo pr entity. Significantly reduces the number of API calls in loops
- Added UDF expansion by default. Any UDF is added to an entity with a fieldname prefixed by # (hashtag). Udf names are freeform, and at least in our organization has a lot of spaces and punctuation. This way you will not forget to escape your UDF field names in your code. Speed gain: You can filter any collection of entities on UDF using standard Where-Object filters.

## Version 0.2.2.0

- Support TLS 1.2 in New-WebServiceProxy

## Version 0.2.1.9

- New parameter -AddPicklistLabel. Will add a text label to all fieldnames on an object that is a picklist field. Supports Where-Object filtering on textlabels for object collections.
- Parameter -passthru is supported for Set- and New- functions. Will pass any objects from the Autotask API to the PowerShell pipeline after modifying og creating the objects.

## Previous versions

We didn't pay enough attention to changes between releases before this.