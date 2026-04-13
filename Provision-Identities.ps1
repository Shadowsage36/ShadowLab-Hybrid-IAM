<#
.SYNOPSIS
    Automates the creation of Organizational Units and Users for the ShadowLab IAM environment.
    
.DESCRIPTION
    Sets up a hierarchical OU structure and provisions users with enriched 
    attributes (Department, JobTitle) to support Hybrid Sync and RBAC.
#>

# 1. Define the OU Structure
$OUs = @("Finance", "IT", "Marketing", "Executive")
$BaseOU = "OU=ShadowLab,DC=shadowlab,DC=local" 

Write-Host "--- Starting Directory Provisioning ---" -ForegroundColor Cyan

# 2. Create OUs
foreach ($OU in $OUs) {
    $FullPath = "OU=$OU,$BaseOU"
    if (!([adsi]::Exists("LDAP://$FullPath"))) {
        New-ADOrganizationalUnit -Name $OU -Path $BaseOU -ProtectedFromAccidentalDeletion $true
        Write-Host "[+] Created OU: $OU" -ForegroundColor Green
    }
}

# 3. User Data (The Ghost Employees)
$Users = @(
    @{First="John"; Last="Doe"; Dept="Finance"; Title="Accountant"},
    @{First="Jane"; Last="Smith"; Dept="IT"; Title="Systems Engineer"},
    @{First="Alex"; Last="Vance"; Dept="Executive"; Title="CEO"}
)

# 4. Provision Users
foreach ($User in $Users) {
    $SamAccountName = ($User.First[0] + $User.Last).ToLower()
    $UPN = "$SamAccountName@shadowlab.local" 
    
    $UserParams = @{
        Name = "$($User.First) $($User.Last)"
        GivenName = $User.First
        Surname = $User.Last
        SamAccountName = $SamAccountName
        UserPrincipalName = $UPN
        Path = "OU=$($User.Dept),$BaseOU"
        AccountPassword = (Read-Host -AsSecureString "Enter password for $SamAccountName")
        Enabled = $true
        Department = $User.Dept
        Title = $User.Title
    }

    try {
        New-ADUser @UserParams
        Write-Host "[+] Provisioned: $($UserParams.Name) in $($User.Dept)" -ForegroundColor Green
    } catch {
        Write-Warning "[-] Failed to create $($UserParams.Name): $($_.Exception.Message)"
    }
}

Write-Host "--- Provisioning Complete ---" -ForegroundColor Cyan