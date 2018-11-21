cd src
#(Get-Content Swastika-IO.sln) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content Swastika-IO.sln
#Get-ChildItem -Path *Mix*.csproj* -File -Recurse | ForEach-Object -Process {
#    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
#    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
#}

Get-ChildItem -Path *.sln -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}
Get-ChildItem -Path *.cs -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}
Get-ChildItem -Path *.cshtml -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}
Get-ChildItem -Path *.csproj -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}

Get-ChildItem -Path *.json -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}
Get-ChildItem -Path *.html -File -Recurse | ForEach-Object -Process {
    (Get-Content -LiteralPath $_.FullName) | ForEach-Object { $_ -replace "Mix", "Sio" } | Set-Content $_.FullName
    Rename-item -LiteralPath $_.FullName -NewName ($_.name -replace "Mix","Sio") -Verbose
}
#Get-ChildItem -Path Mix* -Directory | ForEach-Object -Process {
#    Rename-item -LiteralPath $_.FullName -NewName ($_.Name -replace "Mix","Sio") -Verbose
#}

$OldText = "Mix"
$NewText = "Sio"

Get-ChildItem $Path -Recurse | %{$_.FullName} |
Sort-Object -Property Length -Descending |
% {
    Write-Host $_
    $Item = Get-Item $_
    $PathRoot = $Item.FullName | Split-Path
    $OldName = $Item.FullName | Split-Path -Leaf
    $NewName = $OldName -replace $OldText, $NewText
    $NewPath = $PathRoot | Join-Path -ChildPath $NewName
    if (!$Item.PSIsContainer -and $Extension -contains $Item.Extension) {
        (Get-Content $Item) | % {
            #Write-Host $_
            $_ -replace $OldText, $NewText
        } | Set-Content $Item
    }
    if ($OldName.Contains($OldText)) {
        Rename-Item -LiteralPath $Item.FullName -NewName $NewPath
        #Write-Host $NewPath
    }
}

#Get-ChildItem -recurse -name | ForEach-Object { Rename-Item $_ $_.replace("Mix","Sio") }

# Get-ChildItem -Path *ESX* -Directory | ForEach-Object -Process {Rename-item -Path $_.Name -NewName ($_.name -replace "ESX","VMWARE") -Verbose}

