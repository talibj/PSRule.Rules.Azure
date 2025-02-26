# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# Validation rules for Key Vault
#

# Synopsis: Enable Key Vault Soft Delete
Rule 'Azure.KeyVault.SoftDelete' -Type 'Microsoft.KeyVault/vaults' -Tag @{ release = 'GA'; ruleSet = '2020_06' } {
    $Assert.HasFieldValue($TargetObject, 'Properties.enableSoftDelete', $True)
}

# Synopsis: Enable Key Vault Purge Protection
Rule 'Azure.KeyVault.PurgeProtect' -Type 'Microsoft.KeyVault/vaults' -Tag @{ release = 'GA'; ruleSet = '2020_06' } {
    $Assert.HasFieldValue($TargetObject, 'Properties.enablePurgeProtection', $True)
}

# Synopsis: Limit access to Key Vault data
Rule 'Azure.KeyVault.AccessPolicy' -Type 'Microsoft.KeyVault/vaults', 'Microsoft.KeyVault/vaults/accessPolicies' -Tag @{ release = 'GA'; ruleSet = '2020_06' } {
    Reason $LocalizedData.AccessPolicyLeastPrivilege;
    $accessPolicies = @($TargetObject);
    if ($PSRule.TargetType -eq 'Microsoft.KeyVault/vaults') {
        $accessPolicies = @($TargetObject.Properties.accessPolicies);
    }
    if ($accessPolicies.Length -eq 0) {
        return $Assert.Pass();
    }
    foreach ($policy in $accessPolicies) {
        $policy.permissions.keys -notin 'All', 'Purge'
        $policy.permissions.secrets -notin 'All', 'Purge'
        $policy.permissions.certificates -notin 'All', 'Purge'
        $policy.permissions.storage -notin 'All', 'Purge'
    }
}

# Synopsis: Use diagnostics to audit Key Vault access
Rule 'Azure.KeyVault.Logs' -Type 'Microsoft.KeyVault/vaults' -Tag @{ release = 'GA'; ruleSet = '2020_06' } {
    $diagnostics = @(GetSubResources -ResourceType 'microsoft.insights/diagnosticSettings', 'Microsoft.KeyVault/vaults/providers/diagnosticSettings' | ForEach-Object {
        $_.Properties.logs | Where-Object {
            $_.category -eq 'AuditEvent' -and $_.enabled
        }
    });
    $Assert.Greater($diagnostics, '.', 0).Reason($LocalizedData.DiagnosticSettingsLoggingNotConfigured, 'AuditEvent');
}

# Synopsis: Key Vault names should meet naming requirements.
Rule 'Azure.KeyVault.Name' -Type 'Microsoft.KeyVault/vaults' -Tag @{ release = 'GA'; ruleSet = '2021_03' } {
    # https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftkeyvault

    # Between 3 and 24 characters long
    $Assert.GreaterOrEqual($PSRule, 'TargetName', 3);
    $Assert.LessOrEqual($PSRule, 'TargetName', 24);

    # Alphanumerics and hyphens
    # Start with a letter
    # End with a letter or digit
    # Can not contain consecutive hyphens
    $Assert.Match($PSRule, 'TargetName', '^[A-Za-z](-|[A-Za-z0-9])*[A-Za-z0-9]$');
}

# Synopsis: Key Vault Secret names should meet naming requirements.
Rule 'Azure.KeyVault.SecretName' -Type 'Microsoft.KeyVault/vaults', 'Microsoft.KeyVault/vaults/secrets' -Tag @{ release = 'GA'; ruleSet = '2021_03' } {
    # https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftkeyvault

    $secrets = @($TargetObject);
    if ($PSRule.TargetType -eq 'Microsoft.KeyVault/vaults') {
        $secrets = @(GetSubResources -ResourceType 'Microsoft.KeyVault/vaults/secrets');
    }
    if ($secrets.Length -eq 0) {
        return $Assert.Pass();
    }
    foreach ($secret in $secrets) {
        $nameParts = $secret.Name.Split('/');
        $name = $nameParts[-1];

        # Between 1 and 127 characters long
        $Assert.GreaterOrEqual($name, '.', 1);
        $Assert.LessOrEqual($name, '.', 127);

        # Alphanumerics and hyphens
        $Assert.Match($name, '.', '^[A-Za-z0-9-]{1,127}$');
    }
}

# Synopsis: Key Vault Key names should meet naming requirements.
Rule 'Azure.KeyVault.KeyName' -Type 'Microsoft.KeyVault/vaults', 'Microsoft.KeyVault/vaults/keys' -Tag @{ release = 'GA'; ruleSet = '2021_03' } {
    # https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftkeyvault

    $keys = @($TargetObject);
    if ($PSRule.TargetType -eq 'Microsoft.KeyVault/vaults') {
        $keys = @(GetSubResources -ResourceType 'Microsoft.KeyVault/vaults/keys');
    }
    if ($keys.Length -eq 0) {
        return $Assert.Pass();
    }
    foreach ($key in $keys) {
        $nameParts = $key.Name.Split('/');
        $name = $nameParts[-1];

        # Between 1 and 127 characters long
        $Assert.GreaterOrEqual($name, '.', 1);
        $Assert.LessOrEqual($name, '.', 127);

        # Alphanumerics and hyphens
        $Assert.Match($name, '.', '^[A-Za-z0-9-]{1,127}$');
    }
}

# Synopsis: Key Vault keys should have auto-rotation enabled.
Rule 'Azure.KeyVault.AutoRotationPolicy' -Type 'Microsoft.KeyVault/vaults', 'Microsoft.KeyVault/vaults/keys' -Tag @{ release = 'preview'; ruleSet = '2022_03'; } {
    $keys = @($TargetObject);

    if ($PSRule.TargetType -eq 'Microsoft.KeyVault/vaults') {
        $keys = @(GetSubResources -ResourceType 'Microsoft.KeyVault/vaults/keys');
    }

    if ($keys.Length -eq 0) {
        return $Assert.Pass();
    }

    foreach ($key in $keys) {
        $rotationPolicy = $key.Properties.rotationPolicy;
        $autoRotateActions = @($rotationPolicy.lifetimeActions | Where-Object { $_.action.type -eq 'rotate' });

        $Assert.Greater($autoRotateActions, '.', 0).Reason(
            $LocalizedData.KeyVaultAutoRotationPolicy,
            $key.Name
        );
    }
}
