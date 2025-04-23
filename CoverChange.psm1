

function getGameMenuItems{
	
	param(
		$getGameMenuItemsArgs
	)
	
	
	 $currentLang=(Get-Culture).Name
	if ($currentLang -match '-') { $currentLang = $currentLang.Split('-')[0]}
 
	$message = @{
    "it" = "Cambia copertina"
    "en" = "Change cover"
    "de" = "Cover ändern"
    "es" = "Cambiar portada"
    "fr" = "Changer la couverture"
	}
 
  if ($message.ContainsKey($currentLang)){
	
	 }else{$currentLang= "en" }
	
	
	
	

    $menuItem = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem.Description = $message[$currentLang]
    $menuItem.FunctionName = "coverchange"
	$menuItem.Icon = "$PSScriptRoot"+"\icon.png"
	
	$menuItem1 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem1.Description = "Batch"
	$menuItem1.FunctionName = "coverchange2"
	$menuItem1.Icon = "$PSScriptRoot"+"\icon.png"
    
	return $menuItem, $menuItem1
    #return $menuItem
}


function coverchange()
{
	param(
		$getGameMenuItemsArgs
	)
	


$Gamesel = $PlayniteApi.MainView.SelectedGames
$orderedGames = $Gamesel | Sort-Object -Property Name

#foreach ($Game in $Gamesel) { 
foreach ($Game in $orderedGames) { 

$u=$null
$cc=$null

$gamed = $PlayniteApi.Database.Games[$game.id]
$u=$PlayniteApi.Dialogs.SelectFiles("Image files (jpg, png, bmp, webp|*.jpg;*.png;*.bmp;*.webp;*)")





if (!([string]::IsNullOrWhiteSpace($u))) { $cc = $PlayniteApi.Database.AddFile($u, $gamed.Id)}
if ($cc -ne $null) {
	
	$PlayniteApi.Database.RemoveFile($gamed.coverImage)
	$gamed.CoverImage = $cc                            
	$PlayniteApi.Database.Games.Update($gamed)   

	}

}


} #endfunc






function coverchange2()
{
	param(
		$getGameMenuItemsArgs
	)
	


$Gamesel = $PlayniteApi.MainView.SelectedGames
$orderedGames = $Gamesel | Sort-Object -Property Name



$u=$PlayniteApi.Dialogs.SelectFiles("Image files (jpg, png, bmp, webp|*.jpg;*.png;*.bmp;*.webp;*)")





#>

$i=0
#foreach ($Game in $Gamesel) { 
foreach ($Game in $orderedGames) { 



$gamed = $PlayniteApi.Database.Games[$game.id]


if (!([string]::IsNullOrWhiteSpace($u)) -and ($i -lt $u.count)) { $cc = $PlayniteApi.Database.AddFile($u[$i], $gamed.Id)#}
if ($cc -ne $null) {
	
	$PlayniteApi.Database.RemoveFile($gamed.coverImage)
	$gamed.CoverImage = $cc                            
	$PlayniteApi.Database.Games.Update($gamed)   

	}
$i+=1

}#endif
}#foreach



} #endfunc







