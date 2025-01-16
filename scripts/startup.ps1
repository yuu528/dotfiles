$BAR_HEIGHT						= 32
$MAX_WORKSPACE_COUNT			= 10

$KOMOREBI_CONFIG_DIR			= '.config/komorebi'

$KOMOREBI_CONFIG_NAME			= 'komorebi.json'
$KOMOREBI_BAR_CONFIG_NAME		= 'komorebi.bar.json'
$KOMOREBI_BAR_SUB_CONFIG_NAME	= 'komorebi.bar.sub.json'

$KOMOREBI_CONFIG				= Join-Path $KOMOREBI_CONFIG_DIR $KOMOREBI_CONFIG_NAME
$KOMOREBI_BAR_CONFIG			= Join-Path $KOMOREBI_CONFIG_DIR $KOMOREBI_BAR_CONFIG_NAME
$KOMOREBI_BAR_SUB_CONFIG		= Join-Path $KOMOREBI_CONFIG_DIR $KOMOREBI_BAR_SUB_CONFIG_NAME

$GEN_CONFIG_DIR					= Join-Path $env:TEMP 'dotfiles_startup'
$GEN_KOMOREBI_DIR				= Join-Path $GEN_CONFIG_DIR $KOMOREBI_CONFIG_DIR

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$dotfilesPath = Split-Path -Parent $scriptPath

# copy misc files
Copy-Item -Path (Join-Path $dotfilesPath $KOMOREBI_CONFIG_DIR '*') -Destination $GEN_KOMOREBI_DIR -Recurse -Force
Remove-Item -Path (Join-Path $GEN_KOMOREBI_DIR 'komorebi*.json') -Force

# read komorebi configs
$komorebiObj = Get-Content -Path (Join-Path $dotfilesPath $KOMOREBI_CONFIG) | ConvertFrom-Json
$komorebiBarObj = Get-Content -Path (Join-Path $dotfilesPath $KOMOREBI_BAR_CONFIG) | ConvertFrom-Json
$komorebiBarSubObj = Get-Content -Path (Join-Path $dotfilesPath $KOMOREBI_BAR_SUB_CONFIG) | ConvertFrom-Json

# generate komorebi bar configs
$komorebiObj | Add-Member -MemberType NoteProperty -Name 'bar_configurations' -Value $()
New-Item $GEN_KOMOREBI_DIR -ItemType Directory -Force

Add-Type -AssemblyName System.Windows.Forms
$screens = [System.Windows.Forms.Screen]::AllScreens

$i = 0
foreach($screen in $screens)
{
	if ($screen.Primary)
	{
		$newBarObj = $komorebiBarObj.psobject.copy()

		$newBarObj.position.start.x = $screen.WorkingArea.X
		$newBarObj.position.start.y = $screen.WorkingArea.Y
		$newBarObj.position.end.x = $screen.WorkingArea.X + $screen.WorkingArea.Width
		$newBarObj.position.end.y = $screen.WorkingArea.Y + $BAR_HEIGHT
	} else
	{
		$newBarObj = $komorebiBarSubObj.psobject.copy()

		# position properties not working for sub bars
		$newBarObj.psobject.properties.remove('position')
		$newBarObj.monitor.work_area_offset.top = 50
		$newBarObj.monitor.work_area_offset.bottom = 50
	}

	$newBarObj.monitor.index = $i

	$newBarFile = Join-Path $GEN_KOMOREBI_DIR "komorebi.bar.$i.json"
	$komorebiObj.bar_configurations += @($newBarFile)
	Set-Content -Path $newBarFile -Value ($newBarObj | ConvertTo-Json -Depth 100) -Encoding UTF8

	$i++
}

# workspace setting
$komorebiObj | Add-Member -MemberType NoteProperty -Name 'monitors' -Value (New-Object System.Object[] $screens.Count)

for ($i = 0; $i -lt $screens.Count; $i++)
{
	$monitorObj = $komorebiObj.monitors[$i] = @{}
	$monitorObj.workspaces = @()
}

for ($i = 0; $i -lt $MAX_WORKSPACE_COUNT; $i++)
{
	$monitorIndex = $i % $screens.Count

	if ($screens[$monitorIndex].WorkingArea.X -lt $screens[$monitorIndex].WorkingArea.Y)
	{
		$layout = 'Rows'
	} else
	{
		$layout = 'BSP'
	}

	$komorebiObj.monitors[$monitorIndex].workspaces += @{
		name	= [string](($i + 1) % $MAX_WORKSPACE_COUNT);
		layout	= $layout;
	}
}

Set-Content -Path (Join-Path $GEN_KOMOREBI_DIR $KOMOREBI_CONFIG_NAME) -Value ($komorebiObj | ConvertTo-Json -Depth 100) -Encoding UTF8

# start komorebi
$env:KOMOREBI_CONFIG_HOME = $GEN_KOMOREBI_DIR
komorebic start --ahk --bar
