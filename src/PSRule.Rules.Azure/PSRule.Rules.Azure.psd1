# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# PSRule.Rules.Azure
#
@{

    # Script module or binary module file associated with this manifest.
    RootModule             = 'PSRule.Rules.Azure.psm1'

    # Version number of this module.
    ModuleVersion          = '0.0.1'

    # Supported PSEditions
    CompatiblePSEditions   = 'Core', 'Desktop'

    # ID used to uniquely identify this module
    GUID                   = 'bce66f73-3809-4740-b3c3-f52958e7ab51'

    # Author of this module
    Author                 = 'Microsoft Corporation'

    # Company or vendor of this module
    CompanyName            = 'Microsoft Corporation'

    # Copyright statement for this module
    Copyright              = '(c) Microsoft Corporation. All rights reserved.'

    # Description of the functionality provided by this module
    Description            = 'Validate Azure resources and infrastructure as code using PSRule.

This project uses GitHub Issues to track bugs and feature requests. See GitHub project for more information.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion      = '5.1'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    DotNetFrameworkVersion = '4.7.2'

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules        = @(
        @{ ModuleName = 'PSRule'; ModuleVersion = '0.0.1' }
        @{ ModuleName = 'Az.Accounts'; ModuleVersion = '0.0.1' }
        @{ ModuleName = 'Az.Resources'; ModuleVersion = '0.0.1' }
    )

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies     = @(
        'PSRule.Rules.Azure.dll'
    )

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport      = @(
        'Export-AzRuleData'
        'Export-AzRuleTemplateData'
        'Get-AzRuleTemplateLink'
        'Export-AzPolicyAssignmentData'
        'Export-AzPolicyAssignmentRuleData'
        'Get-AzPolicyAssignmentDataSource'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport        = @()

    # Variables to export from this module
    VariablesToExport      = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport        = @(
        'Export-AzTemplateRuleData'
    )

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData            = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('PSRule', 'PSRule-rules', 'Rule', 'Azure', 'Cloud', 'DevOps', 'Testing', 'Infrastructure')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/Azure/PSRule.Rules.Azure/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://aka.ms/ps-rule-azure'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'https://github.com/Azure/PSRule.Rules.Azure/blob/main/CHANGELOG.md'
        } # End of PSData hashtable
    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
