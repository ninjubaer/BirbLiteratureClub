/*************************************************************************
 * @description BSS Macro for miscellaneous tasks
 * @file BIRBLITERATURECLUB.ahk
 * @author .ninju. , Axetar
 * @date 
 * @version pre 1
 *************************************************************************/
#requires AutoHotkey v2
#SingleInstance Force
#MaxThreads 255
SendMode("Event")
SetWorkingDir("./../")
beeArr := ["Bomber", "Brave", "Bumble", "Cool", "Hasty", "Looker", "Rad", "Rascal", "Stubborn", "Bubble", "Bucko", "Commander", "Demo", "Exhausted", "Fire", "Frosty", "Honey", "Rage", "Riley", "Shocked", "Baby", "Carpenter", "Demon", "Diamond", "Lion", "Music", "Ninja", "Shy", "Buoyant", "Fuzzy", "Precise", "Spicy", "Tadpole", "Vector"]
configFile := "./settings/config.ini"
pToken := Gdip_Startup()
config := Map(
   "boost", Map(
      "keyDelay1", 0,
      "keyDelay2", 0,
      "keyDelay3", 0,
      "keyDelay4", 0,
      "keyDelay5", 0,
      "keyDelay6", 0,
      "keyDelay7", 0,
      "check1", 0,
      "check2", 0,
      "check3", 0,
      "check4", 0,
      "check5", 0,
      "check6", 0,
      "check7", 0,
   ),
   "mutation", Map(
      "BomberBeeCheck", 0,
      "BraveBeeCheck", 0,
      "BumbleBeeCheck", 0,
      "CoolBeeCheck", 0,
      "HastyBeeCheck", 0,
      "LookerBeeCheck", 0,
      "RadBeeCheck", 0,
      "RascalBeeCheck", 0,
      "StubbornBeeCheck", 0,
      "BubbleBeeCheck", 0,
      "BuckoBeeCheck", 0,
      "CommanderBeeCheck", 0,
      "DemoBeeCheck", 0,
      "ExhaustedBeeCheck", 0,
      "FireBeeCheck", 0,
      "FrostyBeeCheck", 0,
      "HoneyBeeCheck", 0,
      "RageBeeCheck", 0,
      "RileyBeeCheck", 0,
      "ShockedBeeCheck", 0,
      "BabyBeeCheck", 0,
      "CarpenterBeeCheck", 0,
      "DemonBeeCheck", 0,
      "DiamondBeeCheck", 0,
      "LionBeeCheck", 0,
      "MusicBeeCheck", 0,
      "NinjaBeeCheck", 0,
      "ShyBeeCheck", 0,
      "BuoyantBeeCheck", 0,
      "FuzzyBeeCheck", 0,
      "PreciseBeeCheck", 0,
      "SpicyBeeCheck", 0,
      "TadpoleBeeCheck", 0,
      "VectorBeeCheck", 0,
      "mutation", "Ability Rate",
   ),
   "ssa", Map(
      "mainPassive", "Pop Star",
      "PopStarCheck", 0,
      "ScorchStarCheck", 0,
      "GummyStarCheck", 0,
      "GuidingStarCheck", 0,
      "StarSawCheck", 0,
      "StarShowerCheck", 0,
      "pollenCheck", 0,
      "redPollenCheck", 0,
      "bluePollenCheck", 0,
      "whitePollenCheck", 0,
      "beeGatherPollenCheck", 0,
      "convertRateCheck", 0,
      "beeAbilityRateCheck", 0,
      "criticalChanceCheck", 0,
      "instantConversionCheck", 0,
   ),
   "settings", Map(
      "webhookCheck", 0,
      "webhookURL", "",
      "keyDelay", 0,
      "doublePassiveCheck", 0,
      "spendHoney", "0",
      "version", "v1.0.1",
      "startHotkey", "F6",
      "pausingHotkey", "F7",
      "stopHotkey", "F8",
      "activeTab", 1
   )
)

IniReadSettings()
IniWriteSettings()
IniReadSettings() {
   if (!dirExist("./Settings"))
      DirCreate("./Settings")
   ini := FileOpen(configFile, "rw"), content := ini.Read(), ini.Close()
   loop parse content, "`r`n" {
      if !!RegExMatch(A_LoopField, "i)(?<=\[)\w*(?=\])", &out) && key := out[] || !A_LoopField || SubStr(A_LoopField, 1, 1) = ";"
         continue
      fields := StrSplit(A_LoopField, "=")
      if fields.has(2) && config.Has(key) && config[key].Has(fields[1])
         config[key][fields[1]] := fields[2]
   }
}
IniWriteSettings() {
   writeText := ""
   for k, v in config {
      writeText .= "[" k "]`n"
      for i, j in v {
         writeText .= i "=" j "`n"
      }
   }
   ini := FileOpen(configFile, "w"), ini.Write(writeText), ini.Close()
}
if !FileExist("blc.lnk")
   FileCreateShortcut(A_WorkingDir "\lib\AutoHotkey64.exe", "blc.lnk",, A_WorkingDir "\lib\BIRBLITERATURECLUB.ahk",,A_WorkingDir "\Images\logo.ico")
wr := ComObject("WinHttp.WinHttpRequest.5.1")
wr.Open("GET", "https://api.github.com/repos/ninjubaer/BIRBLITERATURECLUB/releases/latest", 0)
wr.send()
recentVersion := StrReplace(StrReplace(StrReplace(StrReplace(JSON.parse(wr.ResponseText)["tag_name"] ?? "v1.0.0", "v", ""), ".", ",",,,1), "."), ",", ".")
currentVersion := StrReplace(StrReplace(StrReplace(StrReplace(config["settings"]["version"], "v", ""), ".", ",",,,1), "."), ",", ".")
versionText := (recentVersion > currentVersion ? "outdated" : config["settings"]["version"])
mainIcon := Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxMAAAsTAQCanBgAAAY3SURBVFhHtVdrc9NGFD27kiXLdt4hJJAQHiE8SwvTTvutTP8B39sf1x/Ah84w084w029Q6APaMjwDDUmIQ162Y1uyJVnanpXlEic2odP0aGTZuyvds/eee68s4ruLCnsQBnW0muuIVAb5wRkIIdKZw4dMr12Ighqs+VOwpkfR8DbS0f8HPQkY9gjC4hrk3ByE9BCGzXTm8NGTQCaThfLo9kePYPsNhF4xnTl89CSgYTkTCDe2IHaqyDIkTW87nTlc9CVgGCaUfQRxzklEKFvbaLWCdPbw0JeAhpMbg58pIKYW5MUL8BtFZkaMGAqxUlA8/yt6pmEH6/Y6ysNrmN+kJ65cg/jjVzw/swE/T++QiM7OJEMDBREKWE0LBW8Ak9tTyPD4EPQlUJEVrHy0hln5GXIrJWRWV2koYFgs+Nc+hTLNdKUGPcIjFB5qxjqqxSVcLF5O596PviEoOSVMmHOwVB6t49OI83my2oEoVWC+XkxXdUCNwICtBjAenYHnuOn4wejpAUYXzyaewJwd5AqFgDuLVQj4nrYFZUjEGZNf9SHbpzIgIwNGbGOnuYoTi6cx2hiDdUAo9hFwpYtn009gHGUUVQ52xuHjtbvb5Vib1OKTNJiBA0OYiftbykeIBiJ+6jOMfUbMxdTLYzjuTif39sI+Ar+f+Q3O+BhN2v/0gF5qz3DeEcMJLZlIjnsVJMRvvnJRVqvwwau/go8fXoUlrPaNe9ClAY87UOMiMd4P2mAuUigETcjgLZrRWxp7gw31F1bjxyjGTxJJTslzibcMijUUrfbNPdBFQAmdWv1LQ5aGZ+oRji3UMfbLJsYf1TFdDDHhx+kKoCVCknnFMLSNho0AWeqiH7qsWZGFVviu2mnXJ1VQSli0MVWJkPlxFfHN+1C5aabkFPAqwsBqgHxE73BdJ2yBatAPEeyqBUMayVgvdBHISMayziLDWzuIY0qMp969XA+hXq7oQahbt6Bu36ZbHKCpGPtu+Ki3RTkS4c8LD7Bw/DkqVjmdfYcuETa9TdQH3kJNFmBEkvWfRtPTykvYdH/83d2EAJsFxI0bEFuvoeYLaK5HJM4pOoAJwnAKhNKHMC1sn7E53kI92kJuycH8xnnuvL33LgKN6hLszWUYuRxUncWkVm1XvyiCuDQJMXEU8a2f0tW8ef4s8PkxiFoN8e2nEFYW4soVwLaheK9aWEDr6jksfmFjVMwwaYewrB5ALoU49/ZC8oyuEJjsgNLzoAaHADYgfHkd4utvID65ytckispnMdoFtfIG2GIIRkjiq7NQ1SriFy84vgJx8RLEufMIHclC5qKIx6ioIqbFFbjTHuqynjyji0CsfdFgKt65k8RX3byJ+NtvIc5ypyb9GqTpNDsLFArttd//AJRZFceGqQeuWVuDevqUnrqVrImsdrXUqa01YfCbZWbRzDWSR3URoOa1lNNfKVwX6t49psguAloDVHwHimFK2KcZkKBSAdgzIlMiqwbZJwoJjRLewG+5yHvcANGlAc/dhqxTB5qKHpX6gSy9vIo5NqOlHaj7j5O1HYjr14HJEb64lCAeliGidxnkZyS2r+VRnTKSzGohQOi7rCMzmKwzhYl9pfjlwAKiCwYLK2NLaDXr3B5ttDB0bwvq56fUA5PesiCGBim6U4jOOlgbZDeUR5Pq56oymmIHje0yCu4A90HH++wcTQfD3gj98K6V7yOwUlhG7XKDLmMn3IU8U/EoC5GstKjHGJIhUYOSaWugZElWQGYm+0BBjJH6IJbxEM5LiZNbp9Mn9MaegLPO++z/dNVeuKbA6zETq6dsbMw5KM5a/J3Bht02rqG7YFXxDw2vip+ZoHcD2o19BIaCIcZJK7TLMQl0kWkYdDHJ6Kv+vRcDYkL3QAShj6zXDuP7sI+Ayf4+XByBL2rpyIdjQIwn2nFVCUHdw1DIenIA9hHQOLF+EkGVtZxvQv8GDVXFJjthmW/PMyuzyWYOwj4RduCzji+eeIXmpM+0LMBU2SSP+yGibnxVR6NUw4nlk5gMJtOZ96MvgQ6qZhXl8W3UhqrwCz4kczt5Z1BtAUQtFid2w2zVwWhpDEdqEx+08w4OJLAbMf8L+CJAZLArshrqF04jMtnGP9xgN4C/AcLOzDxPaqszAAAAAElFTkSuQmCC")
hBM := Gdip_CreateHBITMAPFromBitmap(mainIcon)
Gdip_DisposeImage(mainIcon)
TraySetIcon("HBITMAP:*" hBM)
DeleteObject(hBM)

main := Gui("+OwnDialogs -DPIScale +LastFound", "Birb Literature Club")
main.OnEvent("Close", (*) => ExitApp())
main.SetFont("s12", "Tahoma")
main.Add("Text", "x510 y10 c4598e7 ", "Github").OnEvent("Click", (*) => Run("https://github.com/ninjubaer/BIRBLITERATURECLUB"))
main.add("Text", "x325 y10 c4598e7", "Discord").OnEvent("Click", (*) => Run("https://discord.gg/ETcBHqBQsh"))
main.SetFont("s8")
main.Add("Text", "x547 y292 cblack", versionText)
startHKC := main.Add("Text", "x10 yp", "Start: " StrUpper(StrReplace(StrReplace(StrReplace(config["settings"]["startHotkey"], "!", "alt + "), "^", "ctrl + "), "#", "win + ")))
pausingHKC := main.Add("Text", "xp+120 yp", "Pause: " StrUpper(StrReplace(StrReplace(StrReplace(config["settings"]["pausingHotkey"], "!", "alt + "), "^", "ctrl + "), "#", "win + ")))
stopHKC := main.Add("Text", "xp+120 yp", "Stop: " StrUpper(StrReplace(StrReplace(StrReplace(config["settings"]["stopHotkey"], "!", "alt + "), "^", "ctrl + "), "#", "win + ")))
main.SetFont("s9")
tabs := main.Add("Tab2", "x10 y10 w580 h280", ["Boost", "SSA", "Mutate", "Details", "Settings"])
tabs.onEvent("Change", (control, *) => updateValue("settings", "activeTab", control.Value))
objWMIService := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" A_ComputerName "\root\cimv2")
For objOperatingSystem in objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
   Caption := objOperatingSystem.Caption, OSArchitecture := objOperatingSystem.OSArchitecture, Version := A_AhkVersion
tabs.UseTab("Settings")
main.add("GroupBox", "x20 y124 w180 h65 c9BB8ED")
main.add("GroupBox", "x20 y225 w180 h60 c9BB8ED")
main.add("GroupBox", "x20 y33 w180 h102 c9BB8ED")
main.add("GroupBox", "x20 y178 w180 h58 c9BB8ED")
main.SetFont("s12 cBlack")
main.Add("GroupBox", "x253 y32 w300 h249 cae6bc9", "Contributors")
main.SetFont("s10")
main.Add("Text", "x263 y55 cae6bc9", "Thanks to everyone supporting this project")
main.SetFont("s9 cBlack")
main.add("text", "x263 y75", "Huge thanks to Dyllian#4291 `nfor the beautiful drawings and marasorg for `nthe website")
main.Add("text", "x263 y120", "Thank you")
main.Add("Text", "x263 y122 c4598e7 +BackgroundTrans", "`nSP#0305 `nZaappiix#2372 `nBlackBeard6#2691 `nbaguetto#8775 `nRaychel#2101")
main.Add("Text", "x263 y207 cblack", "And finally thank you to all the gumdrops `nfor testing, suggesting and helping")
main.Add("Text", " x263 y260 cae6bc9", "Axetar                                                   .ninju.")
main.add("text", " x386 y260 c4598e7", "Devs")
main.SetFont("s8")
main.Add("Text", " x30 y53 w70 h22", "Start")
main.Add("Hotkey", " x90 y55 w100 h20 vhk1", config["settings"]["startHotkey"]).OnEvent("Change", (control, *) => updateHotkey(control.Value, "start", control))
main.Add("Text", "x30 y75 w70 h22", "Pause")
main.Add("Hotkey", "x90 y75 w100 h20 vhk2", config["settings"]["pausingHotkey"]).OnEvent("Change", (control, *) => updateHotkey(control.Value, "pausing", control))
main.Add("Text", "x30 y97 w70 h22", "Stop")
main.Add("Hotkey", "x90 y95 w100 h20 vhk3", config["settings"]["stopHotkey"]).OnEvent("Change", (control, *) => updateHotkey(control.Value, "stop", control))
main.SetFont("s12")
main.Add("Text", "x30 y176 cae6bc9", "Key Delay")
main.Add("Text", "x30 y31 cae6bc9", "Hotkeys")
main.Add("Text", "x30 y124 cae6bc9", "SSA")
main.Add("Text", "x30 y225 cae6bc9", "Webhook")
main.SetFont("s8")
main.add("Edit", " x30 y200 w130", config["settings"]["keyDelay"]).OnEvent("Change", (control, *) => updateValue("settings", "keyDelay", control.Value))
webhookInput := main.Add("Edit", "x30 y257 w160 h20 " (config["settings"]["webhookCheck"] ? "" : "Disabled"), config["settings"]["webhookURL"])
webhookInput.OnEvent("Change", (control, *) => updateValue("settings", "webhookURL", control.Value))
webhookCheck := main.Add("Checkbox", "x60 y242 checked" config["settings"]["webhookCheck"], "Enable Webhook")
webhookCheck.OnEvent("Click", (control, *) => updateValue("settings", "webhookCheck", control.Value))
webhookCheck.OnEvent("Click", (*) => webhookInput.Enabled := webhookCheck.Value)
main.Add("Text", "x120 y140", "Double Passive")
main.Add("Checkbox", "x120 y160 checked" config["settings"]["doublePassiveCheck"], "Enable").OnEvent("Click", (control, *) => updateValue("settings", "doublePassiveCheck", control.Value))
main.Add("Text", "x30 y140", "Honey Limit")
main.Add("Edit", "x29 y156 w65 h20", config["settings"]["spendHoney"]).OnEvent("Change", (control, *) => updateValue("settings", "spendHoney", control.Value))
tabs.UseTab("Details")
amControls := Map(), bsControls := Map()
main.SetFont("s8")
buttonAM := main.Add("Button", "x65 y45 w180 h18 Disabled", "Mutation/SSA")
buttonAM.OnEvent("Click", switchDetails)
buttonBS := main.Add("Button", " x355 y45 w180 h18", "Boost/Settings")
buttonBS.OnEvent("Click", switchDetails)
amControls["gbMut"] := main.Add("GroupBox", "x20 y35 w560 h250")
main.SetFont("s10")
amControls["titleMut"] := main.Add("Text", "x30 y80", "Mutation")
amControls["titleSSA"] := main.Add("Text", "x308 y80", "SSA")
main.SetFont("s8")
amControls["mutText"] := main.Add("Text", "x30 y100", "To start using auto mutations, you need to first select `nthe type of bee and mutation. Next, you need to make `nsure that the bee you are replacing is radioactive. Next,`nyou will need to place a royal jelly onto the bee. `nNow all you have to do it press start Hotkey " config["settings"]["startHotkey"])
amControls["gbSSA"] := main.Add("GroupBox", "x20 y35 w280 h250")
amControls["ssaText"] := main.Add("Text", "x308 y100", "Auto amulet will find you the perfect amulet you need, `nselect which attributes you want your amulet to have `nand let the macro run! For example: if I want a perfect `nsolo passive blue amulet, I would select Pop Star, `nBee ability Rate, blue pollen, critical chance, and `nconvert rate.")
bsControls["gbSettings"] := main.Add("GroupBox", "x20 y35 w560 h250 hidden")
bsControls["gbBoost"] := main.Add("GroupBox", "x20 y35 w280 h250 hidden")
main.SetFont("s10")
bsControls["titleBoost"] := main.Add("Text", "x30 y80 hidden", "Boost")
bsControls["titleSettings"] := main.Add("Text", "x308 y80 hidden", "Settings")
main.SetFont("s8")
bsControls["boostText"] := main.Add("Text", "x30 y100 hidden", "Auto boost will use whatever item you have in your `nhotbar every interval you set it too. For example: You `nhave glitter in slot 2, set your timer to 1800000, this is `nbecause it works in milliseconds, and it will use hotbar `nslot 2 every 30 minutes. Keep in mind that 1000 `nmiliseconds is equal to 1 second.")
bsControls["settingsText"] := main.Add("Text", "x308 y100 hidden", "Spend Honey: Use this to limit the honey you spend on `nrolling amulets. Enter the amount in using B, T, or Qd. `nEnable webhook: This Discord webhook takes a `nscreenshot when you get the amulet you were rolling `nfor. Double Passive: When the check box is not `nselected it will roll using the 10b option. If it is selected `nit will roll using the 500b option to gaurentee two `npassives. Hotkeys: Set your own hotkeys `nif needed. Simply type your new hotkey in `nthe box and press the button.")
tabs.UseTab("Mutate")
mutationControls := Map()
main.SetFont("s12")
beeArray := ["any", "Bomber", "Brave", "Bumble", "Cool", "Hasty", "Looker", "Rad", "Rascal", "Stubborn", "Bubble", "Bucko", "Commander", "Demo", "Exhausted", "Fire", "Frosty", "Honey", "Rage", "Riley", "Shocked", "Baby", "Carpenter", "Demon", "Diamond", "Lion", "Music", "Ninja", "Shy", "Buoyant", "Fuzzy", "Precise", "Spicy", "Tadpole", "Vector"]
Loop 3 {
   y := A_Index
   Loop 10 {
      main.Add("Picture", "x" A_Index * 50 " y" 45 * y " w45 h36 +BackgroundTrans", "./images/gui/bees/" beeArr[A_Index + (y - 1) * 10] (config["mutation"][beeArr[A_Index + (y - 1) * 10] "BeeCheck"] ? "BG" : "") ".png").OnEvent("Click", updateMutation.bind(beeArr[A_Index + (y - 1) * 10]))
   }
}
loop 4 {
   main.Add("Picture", "x" (A_Index + 3) * 50 " y" 180 " w45 h36 +BackgroundTrans", "./images/gui/bees/" beeArr[A_Index + y * 10] (config["mutation"][beeArr[A_Index + y * 10] "BeeCheck"] ? "BG" : "") ".png").OnEvent("Click", updateMutation.bind(beeArr[A_Index + y * 10]))
}
main.SetFont("cBlack s12", "Comic Sans MS")
main.Add("Picture", "x235 y228 w130 h50 +BackgroundTrans", "./images/gui/rollbutton.png").onEvent("Click", start)
main.Add("Text", "xp yp+12 w130 Center +BackgroundTrans", "Start")
main.SetFont("s9")
main.Add("Radio", "x30 y243 Checked" (config["mutation"]["mutation"] = "Ability Rate"), "Ability Rate").OnEvent("Click", (control, *) => updateValue("mutation", "mutation", control.Text))
main.Add("Radio", "x130 yp Checked" (config["mutation"]["mutation"] = "Convert Rate"), "Convert Rate").OnEvent("Click", (control, *) => updateValue("mutation", "mutation", control.Text))
main.Add("Radio", "x370 yp Checked" (config["mutation"]["mutation"] = "Attack"), "Attack").OnEvent("Click", (control, *) => updateValue("mutation", "mutation", control.Text))
main.Add("Radio", "xp+66 yp Checked" (config["mutation"]["mutation"] = "Gather"), "Gather").OnEvent("Click", (control, *) => updateValue("mutation", "mutation", control.Text))
main.Add("Radio", "xp+66 yp Checked" (config["mutation"]["mutation"] = "Energy"), "Energy").OnEvent("Click", (control, *) => updateValue("mutation", "mutation", control.Text))
tabs.UseTab("Boost")
main.SetFont("s11")
main.Add("GroupBox", "x20 y35 w205 h245 c9BB8ED")
main.Add("Text", "x65 y33 cae6bc9", "Boost")
main.SetFont("s11")
main.Add("Picture", "x260 y32 w287 h256", ".\images\gui\Filler.png")
main.SetFont("s11", "Tahoma")
main.Add("Text", "x35  y60 w50 h20", "Slot 1")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check1"]).OnEvent("Click", (control, *) => updateValue("boost", "check1", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay1"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay1", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 2")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check2"]).OnEvent("Click", (control, *) => updateValue("boost", "check2", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay2"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay2", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 3")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check3"]).OnEvent("Click", (control, *) => updateValue("boost", "check3", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay3"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay3", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 4")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check4"]).OnEvent("Click", (control, *) => updateValue("boost", "check4", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay4"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay4", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 5")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check5"]).OnEvent("Click", (control, *) => updateValue("boost", "check5", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay5"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay5", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 6")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check6"]).OnEvent("Click", (control, *) => updateValue("boost", "check6", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay6"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay6", control.Value))
main.Add("Text", "x35  yp+30 w50 h20", "Slot 7")
main.Add("Checkbox", "x80 yp w20 h20 Checked" config["boost"]["check7"]).OnEvent("Click", (control, *) => updateValue("boost", "check7", control.Value))
main.Add("Edit", "x100 yp w105 h20 Number", config["boost"]["keyDelay7"]).OnEvent("Change", (control, *) => updateValue("boost", "keyDelay7", control.Value))

tabs.UseTab("SSA")
main.SetFont("s12", "Comic Sans MS")
main.Add("GroupBox", "x20 y35 w560 h245 ccda4de")
main.Add("GroupBox", "x20 y35 w135 h245 cae6bc9")
main.Add("GroupBox", "x20 y35 w265 h245 cae6bc9")
main.Add("Text", "x50 y33 cae6bc9", "Passives")
main.Add("Text", "x170 y33 cae6bc9", "Side Passives")
main.Add("Text", "x385 y33 cae6bc9", "Stats")
main.SetFont("s10")
main.Add("Radio", "x50 y66 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Pop Star"), "Pop Star").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Radio", "x50 yp+36 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Scorch Star"), "Scorch Star").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Radio", "x50 yp+36 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Gummy Star"), "Gummy Star").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Radio", "x50 yp+36 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Star Shower"), "Star Shower").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Radio", "x50 yp+36 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Guiding Star"), "Guiding Star").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Radio", "x50 yp+36 w100 h17 Checked" (config["ssa"]["mainPassive"] = "Star Saw"), "Star Saw").OnEvent("Click", (control, *) => updateValue("ssa", "mainPassive", control.text))
main.Add("Picture", "x23 y64 w20 h20", "./images/gui/popstar.png")
main.Add("Picture", "x23 yp+36 w20 h20", "./images/gui/scorchstar.png")
main.Add("Picture", "x23 yp+36 w20 h20", "./images/gui/gummystar.png")
main.Add("Picture", "x23 yp+36 w20 h20", "./images/gui/starshower.png")
main.Add("Picture", "x23 yp+36 w20 h20", "./images/gui/guidingstar.png")
main.Add("Picture", "x20 yp+35 w26 h24 +BackgroundTrans", "./images/gui/starsaw.png")
main.Add("Checkbox", "x183 y66 w100 h17 Checked" config["ssa"]["PopStarCheck"], "Pop Star").OnEvent("Click", (control, *) => updateValue("ssa", "PopStarCheck", control.Value))
main.Add("Checkbox", "x183 yp+36 w100 h17 Checked" config["ssa"]["ScorchStarCheck"], "Scorch Star").OnEvent("Click", (control, *) => updateValue("ssa", "ScorchStarCheck", control.Value))
main.Add("Checkbox", "x183 yp+36 w100 h17 Checked" config["ssa"]["GummyStarCheck"], "Gummy Star").OnEvent("Click", (control, *) => updateValue("ssa", "GummyStarCheck", control.Value))
main.Add("Checkbox", "x183 yp+36 w100 h17 Checked" config["ssa"]["StarShowerCheck"], "Star Shower").OnEvent("Click", (control, *) => updateValue("ssa", "StarShowerCheck", control.Value))
main.Add("Checkbox", "x183 yp+36 w100 h17 Checked" config["ssa"]["GuidingStarCheck"], "Guiding Star").OnEvent("Click", (control, *) => updateValue("ssa", "GuidingStarCheck", control.Value))
main.Add("Checkbox", "x183 yp+36 w100 h17 Checked" config["ssa"]["StarSawCheck"], "Star Saw").OnEvent("Click", (control, *) => updateValue("ssa", "StarSawCheck", control.Value))
main.Add("Picture", "x158 y64 w20 h20", "./images/gui/popstar.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/scorchstar.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/gummystar.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/starshower.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/guidingstar.png")
main.Add("Picture", "xp-3 yp+35 w26 h24", "./images/gui/starsaw.png")
main.Add("Checkbox", "x314 y66 w100 h17 Checked" config["ssa"]["whitePollenCheck"], "White Pollen").OnEvent("Click", (control, *) => updateValue("ssa", "whitePollenCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w100 h17 Checked" config["ssa"]["redPollenCheck"], "Red Pollen").OnEvent("Click", (control, *) => updateValue("ssa", "redPollenCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w100 h17 Checked" config["ssa"]["bluePollenCheck"], "Blue Pollen").OnEvent("Click", (control, *) => updateValue("ssa", "bluePollenCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w100 h17 Checked" config["ssa"]["convertRateCheck"], "Convert Rate").OnEvent("Click", (control, *) => updateValue("ssa", "convertRateCheck", control.Value))
main.Add("Picture", "xp-24 y64 w20 h20", "./images/gui/whitepollen.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/redpollen.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/bluepollen.png")
main.Add("Picture", "xp yp+36 w20 h20", "./images/gui/convertrate.png")
main.Add("Checkbox", "x440 y66 w135 h17 checked" config["ssa"]["criticalChanceCheck"], "Critical Chance").OnEvent("Click", (control, *) => updateValue("ssa", "criticalChanceCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w135 h17 Checked" config["ssa"]["instantConversionCheck"], "Instant Conversion").OnEvent("Click", (control, *) => updateValue("ssa", "instantConversionCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w135 h17 Checked" config["ssa"]["beeAbilityRateCheck"], "Bee Ability Rate").OnEvent("Click", (control, *) => updateValue("ssa", "beeAbilityRateCheck", control.Value))
main.Add("Checkbox", "xp yp+36 w135 h17 Checked" config["ssa"]["beeGatherPollenCheck"], "Bee Gather Pollen").OnEvent("Click", (control, *) => updateValue("ssa", "beeGatherPollenCheck", control.Value))
main.Add("Picture", "xp-24 y64 w20 h20", "./images/gui/criticalchance.png")
main.Add("Picture", "xp-10 yp+36 w35 h21", "./images/gui/instantconversion.png")
main.Add("Picture", "xp+4 yp+36 w30 h30", "./images/gui/beeabilityrate.png")
main.Add("Picture", "xp+6 yp+36 w20 h20", "./images/gui/beepollen.png")
main.SetFont("s12", "Comic Sans MS")
main.Add("Picture", "x360 y198 w140 h60", "./images/gui/rollbutton.png").onEvent("Click", start)
main.Add("Text", "xp yp+16 wp Center +BackgroundTrans", "Roll")
main.Add("Picture", "X292 y173 w105 h105 +BackgroundTrans", "./images/gui/leftside.png")
main.Add("Picture", "X478 y173 w105 h105 +BackgroundTrans", "./images/gui/rightside.png")
main.BackColor := 0xFEC6DF
tabs.Value := config["settings"]["activeTab"]
main.Show "x400 y100 h310 w600"
Hotkey(config["settings"]["startHotkey"], start, "On")
Hotkey(config["settings"]["pausingHotkey"], pausing, "On")
Hotkey(config["settings"]["stopHotkey"], stop, "On")
switchDetails(*) {
   static active := "am"
   active := (active = "am" ? "bs" : "am")
   for k, v in amControls
      v.Visible := (active = "am" ? 1 : 0)
   for k, v in bsControls
      v.Visible := (active = "am" ? 0 : 1)
   buttonAM.Enabled := (active = "am" ? 0 : 1)
   buttonBS.Enabled := (active = "am" ? 1 : 0)
}

updateValue(section, key, value) {
   config[section][key] := value
   IniWrite(value, configFile, section, key)
}

updateHotkey(newHotkey, function, control) {
   switch newHotkey, 0 {
      case "^", "!", "#", "", " ", "+":
         control.Value := config["settings"][function "Hotkey"]
      default:
         Hotkey(config["settings"][function "Hotkey"], , "Off")
         updateValue("settings", function "Hotkey", newHotkey)
         Hotkey(newHotkey, %function%, "On")
         %function%HKC.Value := (InStr(function, "ing") ? "Pause" : StrUpper(SubStr(function, 1, 1)) SubStr(function, 2)) ": " StrUpper(StrReplace(StrReplace(StrReplace(config["settings"][function "Hotkey"], "!", "alt + "), "^", "ctrl + "), "#", "win + "))
   }
}
start(*) {
   if config["settings"]["webhookCheck"]
      global webhook := Discord.Webhook(config["settings"]["webhookURL"])
   f := FileOpen("settings/log.txt", "w")
   f.Write("Logs:`r`n`r`n")
   f.Close()
   if (tabs.value > 3)
      return
   if (!Roblox())
      return MsgBox("Roblox not found`nMake sure roblox is open", "Roblox Not Found", "0x10")
   WinActivate "Roblox"
   if (tabs.Value == 2) {
      if !config["settings"]["spendHoney"]
         MsgBox(
            (
               'You have not set a honey limit.
               That means the macro will roll
               infinitely. To abort press ' config["settings"]["stopHotkey"]
            ),,0x1030
         )
      else if !RegExMatch(config["settings"]["spendHoney"],"i)(b|t|qd)")
         return MsgBox(
         (
            'The value entered in spendHoney is invalid!
            Make sure you use a valid unit such as b/t/qd'
         ),,0x1010
      )
   }
   if (tabs.Value == 1)
      return (%tabs.text%)()
   loop {
      While (n := (%tabs.Text%)()) = 0
         continue
      if n < 0
         break
      postFoundToWebhook()
      if (MsgBox("Do you want to keep this?", "Selection found", "0x4") = "Yes")
         break
   }
   switch n, 0 {
      case -2:
         Msgbox
         (
            'All the honey was spent!
            If you want to keep rolling, increase the value
            in the settings tab', , 0x30
         )
      case -1:
         MsgBox
         (
            'Unable to detect Y-Offset
            make sure nothing covers the screen
            and your graphics settings are correct', , 0x10
         )
   }
   Reload()
}
stop(*) {
   IniWriteSettings()
   Gdip_Shutdown(pToken)
   Reload()
}
Roblox() => ((n := WinExist("ahk_exe RobloxPlayerBeta.exe")) ? n : ((n := WinExist("Roblox ahk_exe ApplicationFrameHost.exe")) ? n : 0))
pausing(*) {
   if A_IsPaused
      Pause(0)
   else
      Pause(1)
}
mutate() {
   static ungifteds := Map(
      "Bomber", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAIcAAAAcCAYAAABLRqyKAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAqFJREFUaEPtkFGO2zAMBff+Z2z/eo8WMugF/UJKQzoqArcDvJ9ohrvJ1+DHz1+/7+449J+DR/02+mW6s3P/PI/6Xbpfpts9nUf9Lne+zJ32qTzqN7nzZe60T+VRv8mdL3OnfRef8D94Pu3/IaT/c/oAeGerM21J1unnfqZciLxzpiCiVj/THWGD6JafaUvSLn0AdFvtspk+JerILD+I3nWmLolaMssx0Y1opk9Ju/BDSKfVZjXLUqKGrtoff3BB1NHZiSVRO5tlKWkTfgjodNrQWR4S+TtnfzYlaiqzMylRQ2Z5SOpHD50dxyZUmrvumD1fiLxzprxQcQcVv+KeUJ96A3W//eihuuPQgmpDffVm7iDyx+w5ZJc7UH/WUO+E+up9u9FDZccRQLWjPvU8dxv7KMR7K/eENsRRSOOdi6cPndmplKp/QhrvzDzPzoZ6HtoQRyGNdy6ePnRn50Iqrod0xFF2NtTz0Ea96uzMC6mXPizQbtZSTyEdcZSdDfU8pFGnMzv1QuqlDwDaUk8hHXGUnQ31PKRRpzs7dyF10gcI6YkTQTriKDsb6nlIo053du5C6qQPENITJ4J0xFF2NtTzkEad7uzchdRJHyCkJ04E6Yij7Gyo5yENcbqkt9MHCOmJE0Ea78w8z86Geh7aEKeDv3u5nT4AKm3FHVCfep6dDfU8tKFelfRu+rBAu1VbcQfUp55nZ0O9k4pfcSukd/WhOzuXUmmoN6i4Jzsb9WbuoOIOqE+9QerqQ3d2bkrUkVkeUnFPdjbqVWYnpkQdmeUhqasPndkpRNTPZllK1R/sbNSjsxwR9bNZlpL6+lCZnSgT3Ypm+pRPayJPP9MdYZHoTjTTp6SNPsxmyVuI7vuZtqTT/a1mN/o/6Uxb8tp9ff0Bawn0Yl9dxboAAAAASUVORK5CYII="),
      "Brave", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGsAAAAjCAYAAACTtPQNAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAj5JREFUaEPtkUGOWzEMQ3P/M7a73qPFbxiMhpFkUk7SLvwAbmw+/sC5HQ6Hd/Lj56/faqAc/hXZn6IGE4dPkf0JTjBz+ATZH+AGU4d3kz3+JJg7vJPpo0+9wwY7j77jHgbsPPiOexiw8+CO63Q/xc7vie50w2bng45bdfk83lVkDgfVlonzYOKyw0GtxhYCjsvdLlCeyLpdoJW4/Yjrcr8K6jlWmXBc7naBkpL1u0ArcfsXrsP9VaA9IxcJ1+N+FyhjnD2n+8BxuKsG+ney4iSYK5k4O6jfUnsRx1G7Uo9Lk2CqZepNcb71P3Qvln0uuMHMkqk3xfneJ7o4WtI68XIaTLVMnA7eWwVaidqNPaeLoyWtEy93grkSt1/BO2qglyh9pRPhvhvMfLEsFLC3cp1uBW84wUSJ0lc6D7g7Caa+WBYaHNfpVvCGE0y0rPqr+0js7gRzd9pLAdVXexWu7/YvOqe7y+D+NJi7014KqL7aq3B9t3/ROd1dBvenwdyd9lJA9dVehevGvupcVF521hH7qrNkd1T11V6F68a+6lxkXnamMHFa4qA76rhON8N1Y191HrDLQW3J1CuZDrK3cp1uhuvGvuo8YDcGFYkdN4UHp8FcidtnXN/tR9iNQUVG9aUel6bBXInbz1A3uNd1K16xcZHtKIH+nazoBlMtE4fhDSeYkHnFxoNsqwu0Z7KyGkxI7LgR3lEDXeYVG5FsLwvqOZlQBcqIV25d8F5Mdv9XMtn1mbiXBbXD4fABbrc/779X4uJ9GhcAAAAASUVORK5CYII="),
      "Bumble", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAIMAAAAhCAYAAAD6SRiDAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAqZJREFUeF7tkUFy3DAMBPP/Nzo3/8NZskAXBIFUD2X4sFFXzYXbDaeUPw8PDw85H38/v+gseXhXsv90OjvxMKHyG5X8H4yju7MzD47K7+Nv//j9eHxndurhRfW3Kb0fj+/Ozv33VH+X0vu7x3e7d6f6u5Tev3P8TvuuVH+T0vt3jt9p35Xqb1J6/85x2lLPQxvq/RbV/57S+3eO05Z6HtrMvPjuZ8qBzBszBZG18S2uh5DdNnZxqdQfIbSlnoc20aOzvJP9HmfqJVlLZvklO11ssqVif4TQlnoe2kRPmdr3P3hB1tHZiSVqE/3ZUrk/ApROcQe0iV717M9OyRpldmaK4kd3NTlYrR+boLgD2kRvzH4+kHljppxQ3IbiK+5A8an7/VsMdtYPLVD9Bm2it3Ibmd9mP6dUuY3oXzXUpd6BGKmzM0sqG+p57jb2lOK9K3egNNQlzgkf7c5OTVH9Bm2o56lsqOdRGuoS54SP7szOpSjugDbU81Q21PMoDXWjd7U06o+A2K1a6nloQz1PZUM9j9IQNzpkadgfIbSlnoc21PNUNtTzKA1xo0OWhv1RgPTEidCGep7KhnoepSFudMjSsD8KkJ44EdpQz1PZUM+jNMSNDlka9kcB0hMnQhvqeSob6nmUhrjESdkODdITJ0Ib6nkqG+p5lIa6xDnhIyl8obTUG3h/1VDPU9lQz6M01KXega3oReyuWsVtUJ96nsqGeoMqn3oHYrQ7OzdFae649ryksoneym0obkPxqfv9Wwx2149dkHV0duIE9TyVTfSU2YklShPd1eRgtn4IkLV0duIE9TyVTfToLL9E7aI/myRn6wdEsjtklp+gnqeyybz4FtdDyE4bm2xYHOvBD5DdHjOlM3v3eGfleX6rqWD33xG74z6//gEumkPZ4OiAJAAAAABJRU5ErkJggg=="),
      "Cool", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAE4AAAAeCAYAAACCJCjqAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAZxJREFUaEPlkFFqBDEMQ+f+Z2z/eo+WBQWCx5bkTAa6sw/05Seb5FB8ff/8qkB9PPZ7589xgtrjaL0zym5QfxT2G6PYDdY8But9USpF0PXfEet9lhTo+u/G/L70jVFIpQ9E/okUPhT5L1K4gXgzBlqbbNccaBa0G4cn4Qaym1mg22Q7skCX0B4d3kC8p4KaJOuyoEahHTrcTLzlBvWSrOME9RLq0+FG4h126z+4L6hLhxvp3nF91xt0fOrS4Ua6d1zf9QYdn7p0uInVG6ozzysnw+3M3smlw02s3lA9Na9we9Sjw02s3lA9Na9we9Sjw02s3lA9Na9we9Sjw02s3lA9Na9we9SLw5OwgdX9qqfmFW5PelK4yOp+1VPzCrcnPSlcZHW/6szzyslwO7OXulFIpYt097u+6w06vuVaUqDjz+5O3/UGHd9yo1SK4E7f9V5El/muN7D9KHaDNSVZxwnqJVnHCeolLT/KblCXZF0W1CRZlwU1SrsTCyqo2WQ7skC3yXZkgS5Z6sVSFqhLZPvmQGuT7ZoDzeLcPY4/sYJSp7pKWnYAAAAASUVORK5CYII="),
      "Hasty", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGUAAAAfCAYAAAD+xQNoAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAidJREFUaEPtkEFu5TAMQ//9z9jZzT06yIApFJm2SCtAsugDuOjXIwP388vL+frz9zsGP8t0+78Quv/Ubv/tPPKu+A/d+Xi3/1YefVf3493+W3n0Xd2Pd/tv5dF3dT/e7b+VR9/V/Xi3/1YefVf3493+W3n0Xd2Pd/tvRX2X6q0Yet3RnX7usEC1YDsx0KawDgv0H6p7xdC5Y1DtZ7cKahKsPwsqA8xlgf5Dda8YOncMOv3sV0FtCetVQfUC81igX1AcBvXj0HAU6PYZzuaOiz8H4s4q0C8oDoP6ceiOYLaNuqt6Lu6u659QPw7dEcy2UXdVz2Vn1+1M3Xi4I5hto+6qnsvOrtuZuvFwRzBbwrqroEZh/hGct9jdcnpTLx7uCGansI4S1KewzhkoFrsbam/pLY8CTj+7TjCxhPVioEnsdtXe0lseBZx+dp1gooR1Y6CV7PYOqm51b338QO2r3onrM/LGGZyX7HROqm51bz9e7aveieuvyFvKnutHcjf3V7f/lEKB2lecSPTVzgp3z/Uzs/7s9wuStEDtK04k+mqnwtl0XMasP/v9giQtUPuKE4m+2qlwNh13Rt7IgTYiixPUvuJEoq92Kpy96Co+I2/kQBuRxQlqX/VOHN9xFPfA9Rl5IwfaiCxOcPqqmz3XVYL6FNefkXfO4MyxZILTz64TTAwwtwqqS1jvDBQJ1j+CM8eSCW4/+2pQn8I6OVBl2MYRnCW0/ufzD8zPNsDAy/P9AAAAAElFTkSuQmCC"),
      "Looker", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAH8AAAAaCAYAAACehIP6AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAmdJREFUaEPlkEEO20AMA/P/N7a3/qNFDG6wliWRolMUhQfgxeLQcV5vfvz89XvP8fChPO6/eNwHNzzuv3jcBzc87r943Ac3/M//hfXbLekG8X0xqI3Jtvag1jJxYpf1K7KdPahRKi8+32+jD75LfFcV1GWyjSyol6j92Ou6HdlOFtRbMq8KFP2D7xLfwwKNkrldoKUo3dipeoxspwu0ksypAkX74LvEd6iBXpI5SqBfYL14zzoK2Y4S6ClZvwoU/sF3ifvdO/51t+vEW7xPUHfU3pvYZf2DsTBkuq/21d5C6Ved+Hy/TZnuqP3Y67ofxsKQ6b7aV3sLpZ914rOVQzBwNhRn73S9E5Yk4m4zZ79XnQzm7Hcl0EY4vuLsna53wpJE3G3msXsF8+KdBdqIbGcSzFxQeycsScTdZh67VzAv3vdU90MUyfxpMHVB7Z2wJBF3m3nsXsG8eF/B+aC7MaLrBnMnlM4FSxJxt5nH7hXMi3e3U5G5TjB3QulcsCQRd5t57F7BPHZfqL1I9Nxg7oTSuWBJIu4289i9gnnsvoi9rrvjOCrWtiWJuNvM2e9VJ4M5+73qLCbdHcdR2HflbUsaMN1X+2pvofSVziJ2WX/hOArWriUNmO6rfbW3UPpKZ2faf+M4CtZulNxg7sKdLh6nxG7X/3Zv5286au/NpPshSm4wl5L1lUAvyRwl0C+ovZ1vOGqgp0y6H6LkBnMlmdMFGiVzu0BLmXR3HC86LNBKpv2DKLnBXEvmZUFdJtvIgnrJtL/4llcF9RbHkX8AC+YombsHtTHZ1h7UWhxn4brRi0GNMvNerz9qxhOhNJ3r7QAAAABJRU5ErkJggg=="),
      "Rad", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEgAAAAdCAYAAAAJrioDAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAXZJREFUaEPlkEFuwzAMBP3/N6a3/iO1gxVA0Ky0IyVwjQ6wl3SGUbo1Hl/fT3dK/hfVP8KdTtya4e/IP5pOZ26H/RuiODudug3o/Vmenc7dAvR2JAdmu78AejuSEyvtlaB3Izmx0l4JejeSEyvtlaB3Izkx2+aumtQpqntt1d9f0W8gOUHb7I+mzKa64Ux5DZITM21uRlM2pGrd6UQNkgOzncPM7dyQ6URNFdDp1Fsh35Hdnk/cF1VAp1NvhXwHcQ+Qn2UynfgI7ne5XgQ1WXanfJrqZm/KTrheBDVZJtMJRHXHmfITrhdBDZGJW5F7Mp044XoR1BCZuBW5J9OJE64XQQ2Sd6jfoJ3ru14ENUjeoX6Ddq7vehHUIHmH+g3aRL/XuF4ENUgWq40+6hL9XuN6EdQgWaw2+qhL9EeN6zWiP2yQHKAdcQ+iP2qIe4B8JAdo90l/xR35+OGNmc5tstdzG1XjTidqkJygbfbJdKJL1TlTHti2H1BTEa+OTpipAAAAAElFTkSuQmCC"),
      "Rascal", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAHQAAAAeCAYAAAD99TobAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAotJREFUaEPtkVFu3EAMQ/f+Z2z/co8WG9AAR9KMyPGkiwJ+AD+y4qMD+3Xx6/fXnzvBzMOHSN+BP85uMPXwAdI34A9zJ5h7+Mek988fZTg07HoPZ0nvnz/KcBC44z6cIb17/iDDQeCO+3CG9O75gwwHgTvuwxnSu+cPMhwEdt3oVUHVotrhoGZR7XBQk6k2YlCVSA4PDQcB1439LtAkKn8WKC2VOwuUKZWzCrSW1OeR4SCw40anC7QlldcF6pTK6QJ1SuWsAm1J6vLAcGjY9RSc7Z0u/pzCe06g38LdTD2Wd4Opo6jPUHsO6mbsrboOzmbqsLgbTB1FfYbaU3H31J4DP7/bTh0W3WDiR1CfpfZUTu/t4PwPqcOiE+jbVJurQCup+u/gbHFioyM+owu0ktRh0Q0mLKodJdCnVM4VVFp2PZW4rwZ6SeqwOBwKnG5F9J1gYknlcVCb4vYd4rYTTJSkDovDocDpVkTfCSZaKpeDWonTdYnbTjBRkjosDocJbv/C9dx+Rdy4gnNC7bm4u04/dVgcDhPc/oXruf0VcWu2p3R2cHedfuqwOBwmuP0L1+G+6qxQ9pTODu4m9zsndVgcDgvuOvhpCfdVp0PZVDou7h73Oyd1WBwOC+46+GkJ91WnQ9lUOi7uHvc7J3VYHA4Nrud033BfdTqUPe6sehdKz9l7w/3OSR0Wh0OD6/1k3+mc7MberKt0GKefOiwOh4YdT3Viz+0qgV5S9ZVAL1G7sbfqvkkdFoeDgOvGvhNMJKpuF6hLKq8L1JKqrwYTJanD4nAQ2HGjowb6lMqJQVWm2pgFypLKUwK9JHVYHA4CJ11Odf+WPkD8P2JQs6h2rlT3b2mC0nn473i9/gKMQCySepdzSgAAAABJRU5ErkJggg=="),
      "Stubborn", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAKEAAAAfCAYAAACPka2zAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAA09JREFUeF7tkFFu20AMBXP/M7Z/vUcLOVyFpR53h7Q2KFwP8H6kGUbxh+fHz1+/6SzBPNvfyc7v2Hn75fE/Hp2liGfaO9n5HTtv/xfEH5DO8iXd7m52fsfO2y9P5ceruJ5udzc7v2Pn7Zen+sN1fmD/Nzr9Xez8jp23X5rv+uG+6++s2PkdO2+/NN/1w1X+TsUd0IZ6HXbe3sUz3/xM+xe3HRLE29lMP1m9V9BGefFZ3CMEqC4+i3uEDdQtP9OWZF187t8NsvfxeZxpXyyFJ4i3s5l+snqvoE306CyfojoyyzHqhprpU1SXzZIT5dDZiS+Q1EDdVTP9ZPVeQZvoVWYnUlRDZyeWqHY2y1JUk82SE+VUZmc+UYKfaWXULTXTT1bvFbSJXnV2RqL8yuxMimrILJcoP5slJ8qpzM58oaRslpSo3Ki4A9pE7y73oOJX3IOKv8uNqPaYvb6AXSVmswRRaSvugDbUG0R/1lBvEP1ZQ70B9aM3cyOdtuRHOZvpSypdxR3Qhnoe2lDPQxvqDahPPUWn7TQnMfYzZUqlqbgD2lDPQxvqeUhDHAVpvDPzFN2201zwR+ixil9xB7Shnoc21POQhjgK0hEno9t2Gok/RI5V/Io7oA31PLShnoc0xFGQjjgZ3bbTpPhjq4O73AFtqOehDfU8pCGOgnTEyei2nSbFH1sd3OUOaEM9D22o5yENcRSkI05Gt+00Kf7Y6uAud0Ab6nloQz0PaYijIB1xMrptp0nxx1YHd7kD2lDPQxvqeUhDHAXpiJPRbTtNij+2OrjLHdCGeh7aUM9DGuIoSOOdmafotrKRDxf4hrQV96DiHnh/1lDPQxvqeWhDvQH1qafotpfGPzgfAqrdv+JTb1DxK+5Bxa+4B9SnnqLbXhr/wO/xMqHqHzzrz5pd7sEzbtW3x5LoznzqHVTcSLeVjX/YmZ2ZckdTmZ24oFw6O5GiGjo7MUV1ZJZLKm6k26aNf1GZ5UtUO2bKBeXS2YkLyiWzfIrqyCxHqH42y1KqvqfbThv/kswyjLpxzF5LlE9m+QXlxWdxjxCguvgs7hEWUXfUTJ/SaQbdFjVeUjOtRedWbPxMeZA9f0X8/6pm2pJud9BtO82bN2/evDIfH38AUtg2DwH1yK8AAAAASUVORK5CYII="),
      "Bubble", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAHYAAAAgCAYAAADHcIz7AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAnlJREFUaEPtkUtuxDAMxXqE3v9UvUzXbW3IhUaRHT4n6gcYAtp4yIcA8/LkyZP/xvvb6wc9S578B7I/kJ5N/Bkqv6l6+/b9Mbp7NvOrVH7PT23fvh/Hd86mfoXKb6ncbpTux/Hds7kfp/I7Krcbpfu747vd3VR+R+V2o3T/yviV9i4qv6Fyu1G6f2X8SnsXld9Qud0o3b8yTlvqeWhDvR0qtxul+1fGaUs9D20yL77F6yEg6+JbvB5CdtvYxUul/gihLfU8tIkePcuXZB05y0/Z6WKTXSr2RwhtqeehTfSUs4kpWUPPJpaoTfRnl8r9EaB0ijugTfTUs5mUzFfOZqYofnRXJwer62MTFHdAm+jd5TYUX3EHik/d799isHN9aIHqN2hDvUH0Vw31BtE/a6hLvQdipJ7NLKlsqOehDfU8SkNd4hzw0e7Z1BTVb9CGeh7aUM+jNNQlzgEfXTmbS1HcAW2o56EN9TxKQ93onV0a9UdA7FYt9Ty0oZ6HNtTzKA1xo0MuDfsjhLbU89CGeh7aUM+jNMSNDrk07I8CpCdOhDbU89CGeh6lIW50yKVhfxQgPXEitKGehzbU8ygNcaNDLg37owDpiROhDfU8tKGeR2mIS5yU7dAgPXEitKGehzbU8ygNdYlzwEdS+IXSUm/g/VVDPQ9tqOdRGupS74Gt6IvYnbWK26A+9QaKr7iNKp96D8Ro92xuitJUuY0rrurb8xTFp+73bzHYvT52QtbRs4kDmUvPJqZkDT2bWKI00V2dHMyuDwGylp5NHMhccpYvyTpylp+idtGfnSRn1wdEsh1ylh/IvPgWr4eArItv8XoI2Wljc7zXj0+t155vMF41wQAAAABJRU5ErkJggg=="),
      "Bucko", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAHAAAAAgCAYAAADKbvy8AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAmtJREFUaEPtkVFu20AMBX2E3v9UuUy+G8jgwqsnkjukVNQyMgB/zBlmhTwG319//tKx5Jd3wvtH0bETH8stvlH/KdWxMx/Frb5vfmx37NRHcLtv0wd3x87dntt9V/fB3e7dud13nXnwmfZdud03nXnwmfZdud03nXkwbak302mu4H/93TZnHkxb6s10mg3tdEwLqfjqrvwI7848pvmUZIG21Ju5osnGkgNdL3MzvDvemH4Eiw60pd5MtVGfjKU7Ok7krfDuZGPZHiQ5VLqKO6g06tKxfMfK0b3nELw7ZCx/4UmdsXMuFXdQaairnudme93pnlK5s3Q9oTp2KqTqb9CGeoOVN9+aPf193lWp3kl9XVbHzqT8y4Z6FO+e/jbmGTSo3kl9XXbGToVU/Q3aUI+i91ZjGabbh828ODN2zqXiDkhDnCp6czWWYbp92IWLBdplLfVmSEOcKnpznmj/DCHdNuzCBYC21JshDXGq6M0xtn6S7VZ027ALFxDSE0chDXGq6E3vLnEiLu/CBYT0xFFIQ5wq9Cb1lMu7cAEhPXEU0hCnCr2pXubOdJqNsAsXENITR6EN9SiVexV30Gk2wmZeHJYLKi31BrOfNdSjVO6pu/IH1Sb102WCdqu24m5Qn3qDlTffyrxB1d+oNqmvy+7YuZBKU3E3qKue5672HtVG/axZeip0x86leB0dO+Hi+WQs30Ec5YqGjuUvPKk6dmqJ19KxEyFesxpLdxDHo9NpsxrL9ngiHTtRwrtDxvIUr4vGkgPUU67qojH9iCdHY8lpvNtjTHkS/Z4xN96YFlL1Z7qtdjqm/fI5PB4/vz7zRV50RIMAAAAASUVORK5CYII="),
      "Commander", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAALAAAAAbCAYAAADcbAVzAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAA0tJREFUeF7tkkFu21AMRHOE3v9UvUzXLRiQxojmn5nvuLba6AGzsOaRVAJ9XFz8N/z6+eM3S2oXFwdO8W30j5UlRy6+Oaf5JvBF3OToxTfmFN8DvgR7Ede7+D6c4nvYeYm3vujF6dj5dv4ap3iJi3+SU3w7Z/143/HPecfNZ/Cu937VXXrnb74AHu5JZUl38TfmUwYmJ5I1pfv4G/MpA5MTydpimsekNjJ5+AyTtcU0H8l6vLsCXUzWlO4ffmPxLPAAS+ojk79KjlgzqY5M/io58uWbwTQzJfU7JpclxyjTHEuOjUw+JrUl00zlVqb7ZXC5kxy7Y3KfkVw/MvnPSK6nrDxnV3ec5OjI5Kvk6B2TOyX1kcmv3Mp0v8xh+YJdZ+V1Z+UFu87K687KCxzHQe3BfuUEjhM4HjorT/XBrnPnjQ8fZHlkQLmqL9BjruOpvkCPua6nUHtY11Gu6hHlqr5QDt2jhneghxrKVX2B3o6bjw6ovkBvx81H2+COaQ/rOspVPcJc1nWUR3ep4R3ooYZyVV+4XqBc1ReuF7gueio5coN1HeWqHmEu6zrKpT0b3IUeaihX9YXrBcpVfeF6geOi4yTHbrCuo1x3T8B2YbeTHD9Aeza4Cz3UUK7qC9cLlKv6wvUC5WLvJkdvsK6jXHdPwHZht5McP0B7NrgLPdRQruoL1wuUq/rC9QLlqj5AZ/JY12Eu6yaYj91OcvwA7dngLvRQQ7mqL1wvUK7qC9cLlOvswR2Ty7qOct09AduF3U5y/ADtabnJzi7lqr5wvUC5qi9cL2Au6xD0Jpd1HeWqHmEu63ahu2jZcJ0db+WqvnC9QLmqL1wvUK6zB3dMLus6ylU9olx3j4LewXIUkke8fHTHs5zA9QLlqr5wvUC5zh7cMbms6yhX9YhyVR+oPpB7UHCToyOTv0qO3OE4gesFylV94XqBclUfoDN5rOsoF/uVEzzqseTIHY7zlEPFNDMl9ZFne4FyVV+4XuC46DjJsRus6zguOm5ydGTye1IdcT15KDWbaUcka4rru16gXNUXrhe4LnoqOXKDdR3XRc9Jji2ZZiqpLNlxT4P70q4XKFf1hesFO+6j7Nx41MVk/ZK/LXjVnYuLF/Px8Qc9OALjd7IiiAAAAABJRU5ErkJggg=="),
      "Demo", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGIAAAAhCAYAAAAiaX7MAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAf1JREFUaEPtkEFuwzAMBPOE/v9V/UzObSSsDJoh5SVlBi2gAfZQZ4Zp/Gg8v79+rtbFTS3Wi78a0s2dWC+aHU5s7sB6wZHhzGYV6+VGh1ObFaIvVftMsyHIvFTdsN1mQvaFZruNw8oLXWnv4i/8D7ew8kPubPWgXeJ1+rkclBOWNwYlhXVPDpr/Qxiyre68QZ9idcyQd6zP9aCGsO5YM+X+MEC0lT4zZC5Wwy7a9y8ksXpvZtAfBoj02mWH3MTyK4evnWJ1s5lRfxgg0rMu6zW0O4aPT1jeGJQ3Im4j4p8+l8HxMADbs96A9bU3cxuW34aPTarcxuFEQw3bM46GaaQz8ySrDR6ZSO/KbRxONNSwPeNomEY6M09S1TCOy1L8gu21Fx3OvMF6kqqGcVyW4hdMr53McOoN1pNUNYzjshS/YFrprAznTjCOpqphHJeVmG21lx3OnWAcTVXDOC4rMdtqLzucO8E4mqqGcVxWYrZlvQyZ21UN47hk42gXcSPIu+ztqoZxXDKxbpgu6rNk7lY2rDc4nEwYbRqZhiFzt7JhvcHh6DCzfoiA7VivEXEHlY32GPf0R3b9CInVM0NuEnEH1Y12r5aK5PqBINad2ZC5RP3GJxrtzxYOxnq4gHXTGvQp/6nxRstdvBnre+SgXZLpPtU0dKcHbbPZgMfjFx+rIJIe+p3tAAAAAElFTkSuQmCC"),
      "Exhausted", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAKcAAAAdCAYAAADPR3z/AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAA4pJREFUeF7tkVFy20AMQ3OE3v9UvUy+29kY64FWIEHKqi13/GbwYzxCivI1+P7968/R/Aw8mVc991155f+qy+4958sfCSaewque+67w97r6Nwvfk4tuMPEUXvXcd4W/19W/WfieXHSDiafwque+K/y9rv7NwvcMi4vxLu95Ffh7Xf2bhe8ZFhfjXd7zKvD3uvo3C98zLC7Gu7znVeDvdfVvFr5nWDwAb1Z2K65y+Lc1UEqo+xkoIR13UPXZU4G2QXkq0EPUzQyUUwn3w+JBqrvsZe7qVYLTEHUTBSc7Kg5T8dnJAv2OclSgS5S/BmoZtTGCOv4mYfEgvBttV5zJ6laD8xB1EwUnG1y/4nzuK8HZD6pXgb5DuVFwkqLuXHB6IyxOgLfVftatsOtuKs6kuhN5rl9xvusHUc+3WaDvOMsZsNcJzm8oIQpOWkT3/PvaKTp+x3W4raxTON/1VXinslV1j3iZm3prmQUnLdSG+s3Rvem4GbyjtrJO4XzXV+GdytaZLveRw4QuFy44aaO2ZqBYuncdN4N31FbWKZzPfeRU6Ox03IFzXb8S+ly44OQQam8EtaV7d9R1wcmdrFNUfHacG9G577gD57p+JfTD4h/Az+o+r3tbddmrBGd3sk5R9dnjoLZ07la3E0xscP1K6IfFyfBzjjyve1tx2akGp3eyTtHx2V0DJaTjr24nmNjg+pXQD4uT4edwUFu6d851/YQ95WadousP+IaDWvKI2wkmNrh+JfTD4kT4GWugWLp3znX9hD3lZp2i6zN86zaq3mB1O8HEBtevhH5YnATvz2eo3xzdG+e6fsKecrNO0fUVlQ12Mm/QcSt0t0I/LE4i2uff107xiI+fNhzZUb7rVzpuBG9EOxWH6biO7lboh8UJ8Lbaz7oVdrs+ftrg+gl7kev6CXvOzajsVBym4zq6W6EfFg/Cu9F2xZl03IFzXT9hL3IrzqDqOSo7FYep+q4f8I5zB6HLxZFgZkfFGbCXuVVv4lzuI2dQ8VanGpzvyLpBZWPAHgf1DuVmwZnkiLdz17IbzGyoOEzFZSfzJhWXnWpwukO5LjjdoLwsOJN0/YG6UYEeom4qwfkNJXSCmTuuV1RuKg5TddmrBGcS5c9Ase/FvQtOUs64WQPNom5dcHpDCZ1g5k7WZfCdunX9ylGXg/rw3/QI/EwVaJdHvfsMlJd83w8fPnz43/j6+gs/eMHKtVHkiAAAAABJRU5ErkJggg=="),
      "Fire", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEIAAAAjCAYAAAAg/NwXAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAWBJREFUaEPtkEFuwzAMBPOE/v9V/UzPLcoQhkKv5KFF1I2hAfbC7JCOHovFnq/Pj++K+Lr3Rf2pM/F1Etq7lPYjZ+LrJJnuZcSPPBtfJ6G9S2k/cia+7n253R86y3oIZz2E858e4tJv+Yvj9EavF+ftbyOU18ZrT4Y/FkFvxN4ornRRjorX7/kQqj+KlGxYDL0Re6O4skN1jzInJqB+7I26Pai/67QDGhMTUD/2Rl1F1n3ptSKNiQmoT3s9zrhbt5VpTExAfdrrccbduq1MY2IC6tNej+jTSNmGxdAbtKeIbiZygQ2LoTdoTxHdTOQCGxZDb9CeIrqZyAU2LIbeoD1FdDORC2xYDL1Be4oZ15heAKA3aK/HjHvbh0j7UzKE3qC9HlP+lAyhN2hvBN2x67SDbVgMvUF7I+IOEinasBh6g/aOiHuOIiUbFkNv0B4h7urF6/d9iF/ivhivLRYvPB4/psRK+nR4DU4AAAAASUVORK5CYII="),
      "Frosty", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAHMAAAAdCAYAAACZvVPMAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAilJREFUaEPtkVFOw0AMRHsE7n8qLsM3KGhSOV6vPba3LGr7pPkgnjdRw03y9fnxvSKYe7MT6x9TCebegC3fRf5DOsHcy7P1u+iXV4O5l2frd9EvrwZzL8/W77L15U/I1u+59eVPyNbvufXlT8jW7/nolz96/7/B/l625zF4K0Y9Zvv6ubx5WJ4MaimsHRnUpliOFdTvRPeIwekORuh9L1CmWI4V1CksfxYoA1bXCup3onvE4HQHI/S+FygmVt8LNBfLiwL1gtWzgvoFpmNh9uXQcFyA3vcCZcDqMoFuUunizwG54wX1C0zHwuzLITZQKf7S73TxuE12N9s/MftyiA1UitU+Hk9h+2wvS2U360y78sAGKkXHPcj6bJ/tZansZp1pVx7YQKXY4bKO7MngXKK6lfGmPXlgA5Vih5vxdFcGlRTVDdZze+5xAZ39qpv1dF8HNYqqy3puzz0uoLNfdSuednRQC6l6B5Eb3VsvZ+jsV92qd6L9Mzi7VJyTyI3u7R8e0dmvulVPo3eYrWxfol3te7dfwkKTzn7VrXoW2a1sXzPzZ88vUKUGnf2qW3E85F60melazPzZ8wtUqUF3P+tn+wyZzUx3ht7QQW2ELhbp7mf9bJ8hsye7TN9Cb+igNkIXi3T3te9tsL0Tpif3ou5Btm+hN3RQG6GLRVbs6w020E2sPhPoU7L9GXrnDM42qXKBVft6Jwq0KZYTBaqL5Z1BhcLyj+AMbrcf5pB5p55qZlMAAAAASUVORK5CYII="),
      "Honey", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGYAAAAjCAYAAABmSn+9AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAi5JREFUaEPtk11KBEEMBj2C9z+Vl/FZWchATOfrVCbrH3RBXjZVGWnw5fAPeH97/fBjP2Om/UEwfdhpfxBMH3baHwTTh532B8H0Yaf9QTB92Gl/EEwfdtofBNOHnfYHwfRhp/2E3/x2l/bf2g4Cd/vYxTFti2ri73FMa5Hd8WPallbTkhPu9LFRY7oka+jYCUTWZ2O6pOW35IRuH/1qLEvJ/M7YmS1ZtxvLJNjHoqDTR5eO5QuZ2xk7I8kaMpanYDeK07GzC9/hZt5jbL3QcR9Ql3oPsBvF6djZBepdED86yvNQn3oXHR+5UZqOnV2g3gXxiROhDXEitPGedKM0HTv7BeJkVI3fKyeDNMSJdBrvpn4UpmNnv0CcjKqr9grSeOfO2BlJ6ZdCAemJk1F11V5RNX5/d+yUpPRLoYD0xMmoumqvqBq/n4ydk2z97RJAeuJkVF21V1SN30/Gzkm2/nYJID1xMqqu2iuqxu8nY+ckW3+7BJCeOBlVV+0VVeP3ynkW8jt+sSwBpCdORtX4vXIySEOcZyC/4xfLEkB76l0QnzgZpPHOznsG6Tf8x5clgPbUuyA+cTJI452d9wzSb/iPL0sA7aPXce3nBepFaOO9nUs9Rdr5g8sS0OmjS8fyBepFaOO9zljeYummR7t99KuxLKXjejqNd8lY1mZpp4fv9LFRY7qk6190G+/vxvRbLP30+N0+dnFM23KneTBtsjHtcDj8COe/7o/y/vb68QnSuxgWG0ZMUwAAAABJRU5ErkJggg=="),
      "Rage", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFgAAAAhCAYAAABduGw9AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAfRJREFUaEPtkEGO20AQA/2E/P9V+cyeE3iWg+20OD1kjzdBYBXAi1TVNvS4ufn/+fj545c6JDcO7EOqw4mbCvbhnOHMzQr20dzh1A2DfbDOcO4m0/1Q3e7tOPlQJ+3bcPKRTtq34eQjnbT/kr/6v09+rNvmjg1qC3Zvjr0fkUDu8qD9iSQtcNvs74ZMht1QhryEdWzQv9gKBZ02N7sh28JadTixhDXVkH1Svizodgqd27lxhhMU5itDfvbH5nDqpTi/kd3Kd9wnqrv08ovOcOqlOL/huE9UX/Um1M8PnY0D34T6W6oXURvFyVya+MDZiA9gN6shu6B6EbVRnMyliQ/cjQMm7I4y5BdUL6I22XNHj4yHCxyXkXtnOHFB9SJKk53O6KHxcIHjMnLvDCcuqF5EabLTGT00Hha4/sTtVF/1IkqTnc7oofGwwPUnbqf6qhdRmux0Rg+NhwWuP3Gb6FeN6kWURnEkOodOGzwqiX7VqF5EbRRnSzyiHjpt8Kgk+rtG9SbRrxrVK+kecTvHfRL9XeO4T1Rf9Uq6R9zuO/0T1/Xx+MLSW77Y0OnUJnuVO2GNOpygMF8Z8t6Hmrht9p3hRAnrlCFfwppqyD4pX27otLlRh3wLa+OYM8INuVkN+hdboeCVbRx7P6IX0b2duzxo4PH4DT7bt99rsU12AAAAAElFTkSuQmCC"),
      "Riley", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFgAAAAgCAYAAACW5L+YAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAfJJREFUaEPtkMFtxDAMBK+E9F9Vmsk7gQD6QNOUuUPZxj0ywH6s2RXk1z8P8fP99avGKv8Qsh+pxiZkOt3uXR+Df3QnNiNBusT9aOJDOrGpEtLxruJ/LPEh3djcZdy9/xjdh3R7KnfvP8bKQ1a6FXduP8rKQ1a6FXduP8rKQ1a6FXdun3HFvbveyiDtEp+4ntiLMe2UTsez66yM0S7xibsRO7OYPoX6kV1nZYx2iU/cQfSrWG0K9TcOvh/ZHRR0eqSz4qqxegpxPQffj3RjUyWkd4eregPieg6+H+nGpkpIT3VVb4P4xB2krv9IYxMypK+6ihNRO96r3EHq+o8kVkeQDdVVnAjpeLfyU89/pLEJGdJX3ejR2MwU1Z9604ME4maQvuJGpxObmqL6U296kEDcDNJX3Oh0Y3NTKv/0/PQwgfoe0lXc6HRjc1Mq//T89DCB+h7SVdzodGNzU6rO2Rl69ID6HtJVXMW5itlds+9vSiGh0xmQnuoqzhX4e/xds+9vSiGh0xmQnuqq3hXEu2JM2yNJCZ0e6aiu6l1BvCvGtD2SlNDpkc4drurNiP0Y0/ZIUkKnRzorrhqrI7KdETs+IosJtEt84g6iX8VqmGxrxI6PyGIC7RKfuBuxM4vpLfAekgO0S3ziemIvxrQl6s3X6w+J3C1L/cEIJgAAAABJRU5ErkJggg=="),
      "Shocked", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAJsAAAAeCAYAAAA7HGznAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAA1FJREFUeF7lkkFuI1kMQ3OEuf+p+jK9nkYMfkSlokRKTgbT9gO4sR4J/II/GL9//fNvFShjnum+Cu/2Ddr3nj+UE1Qkm86r8W7fQL43Cm5QLZn6r8i7fQPrvVlygzpl4r4q7/YN5HulEPgp91V5t28g39seCRNvuv1qvNs3aN/bHp/kJ7f/Ft7tG7TvbY9P8pPbfwvv9g3a97bHJ6m28+850EawnRhoY9hWDLSSiZ9d5VewnRhoK9jeCbs/Sof2+CR5exJMWLA+C3QbtlEFlRtbr3M72A4LdBu24QT1LyxpAdudBDMtrNcFNQnrqqB6YeNUnoLtdEFNwrpuMPEFk2KgjWFbk2CmhHWcoF7COk5Qv6CcfGeOA9txgnoL67nBxBUmVkFFwrqfwfnG/8H9xHWzx9zunm/5PsHdcb1D9rvOxH3AClVQKfmODn6+4XoH13e9g/LiVvTy7/E2Zboz8SfuJ1P/QS5VgU6ZuAe343oH13c9F7aXfzt5FBZsNpxOdDovsuncyCMxUG64XkZ14r1yGE4nOp3nkvdUUBux6Tud6HReZNNpyYPVqOMwVCfeK4eheuq+IW+qoDaC7UyCmRuuF9l0JM6o4zBUJ94rh6F66r4hb8ZU90fRhPWnwdQN14tsOhZqWN0rVCfeK4eheuq+IW+e4PyguylydxvMXXCczKZjoYbVvUJ14r1yGKqn7hvyJtt1nArW3QRzFxwns+lYqGF1r1CdeK8chuqp+wZ30/UyubcN5i44TmbTsVDD6l6hOvFeOQzVU/cN7mb2Ojey6bhstjcdCzWs7hWqE++Vw3A60ek8l8nexI1sOg5x192WnfZYEDtVV90rnE50Ou/g+q7nMtnLrvIPm47LdDf6t057bHB6jsNwOtHpvIPru95BeXGr8w5T/5NNx2W63fr5eIIzxfUdh+F0ojN18XOJ62ePuerO+MmO6x0mfnapz6RJMHPD9TJuJ3qToF7COk5Qv+A4me/ouEG9hfXcYOIKE52gTpm4kUknuk5Qk7CuCqoXHIex6eWOCmoWrO8E9TtM7oJaydQ/TDvR7wLdhm1UQeWG62W+q1cF+gi2E8OcR7EjF3KgSb6jh58kscMCbQzbioFWMvUj227u5UD7j/n4+AMgLanBe64DzwAAAABJRU5ErkJggg=="),
      "Baby", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFoAAAAiCAYAAADf2c6uAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAhlJREFUaEPtkEFuAzEMA/O//v/eV/Tawgu6UGVZomRvYhQZgJeYwxXyePMCPr4+v9lAeVPB+kPZYOIYTrzpF/3nZYOZl3LaPSbyyGow9RJOusVFH1oN5p7OKXeEVA+ters55Y6QlUNX3F2ccAPFyqEr7i5OuIFi5dAVdxd33LBjc/BWRquu9qygGmJ5+jedSwyoOJLBWRnMurofBZqL5TGBPiXb1wzOymDF1U4UaFMshw0mpmT7HbMvh4ZHh6rHkNnW3WwwY5LpSsy+HFoJ5rbB7uverm4j05WYfTlUDaa2wn6D7XV0P3Iy3ca0Kx8qwcx22O+wPUnGyXQb0658qAZTKawdL9AG2J4k62T60558WAnmQiyXCfQBtifJOmzf7bmPDtpjXMthg4kBtifJOmzf7bmPAVlX9zPBxADbk9zhRO+lj0pYn+112D7bk9zhRO+lj0pYn+112D7bk+xwtOe9XYSFANZnOhLZ9xy2J6k4jZk3+/0PVMmB9ZmORPY9h+1JKk5j5s1+/wNVmpBx2V5H9j2H7UkqTke7OqiN0EWF9iKX7XVk33PYXifb12hfB7URq1wJ5qbc1dc9r9vIdC20r4PaiFWuBHMurKN72S4bTKSxtlrwbGMJ2WAqxHLZYGLA6jKBXsLaa8GzjSWwwUQKa4cJ9AGrp3/TucQFSpuWNAuULVj7Pdb7JR3E6ff9G95/9BPg/uTH4wfvJAO1f48SJgAAAABJRU5ErkJggg=="),
      "Carpenter", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAKAAAAAeCAYAAACrDxUoAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAA0ZJREFUeF7tkkGO21AMQ+d+vf++p5htix/oZ/hlSaRcJ7ELP4CLhI+KMZ6vm5vT8uv7958qpt2cmMu+K/xHY7HJzYm49DvyD6/Epjcn4bLvR31w71Xuzfu55LvpPrTq3bwffI+XeUeXe+CbFHyXl3mfl3vg/4RX/N3x5pF3X8a7Htj/DsaUksjH73w3qbojwPs+pqRELn7nY8qGyI1iekq0mTGlJPLxO989KMsD8Per2CTEe/gZ85AB3+Fnn8egQXTDx9SQyGex6ULkRTE9JPJ9TE3xLn7GPORJWhwI/gaLTTZEro+pC5FXxWaUaJvFJhsiV4nNn0ROFNM3RG4Wm4REvo+pP5TlQVS38fc7XhRTFyKPxaYlis8c7CtvUDnYVTF9wyucLKb+UJZvAp8hew7FiVB3qjc4ysM+cyaqq3oT1VU8dCpvoT14AfgM2XMoTkRno7qqN6hc7KLeo7joVN7kSBf7zNnQHrwAfIbsOVif0dmhm/mKg1QudlHvUVx0Km/QcQfMZX3IrtEO8HdYbLLA+ozujvnYZw5SudhFvUdx0am8QccdMJf1IbtGTfA3lNhsgfUZ3R3zse/GTjxhvUdx0am8gXc7sRMLrA/ZNWqA99XYdIH1Gd0d87Hvxk48Yb1HcdGpvIF3O7ETC6wPwVFrKKDeRS9zWZ/R3TEf+27sxBPWexQXncobeLcTO7HA+hActYYC6l30Mpf1Gd0d87Hvxk48Yb1HcdGpvIF3O7ETC6xP2T0kqHfRy1zWZ3R3zMc+c1S6txQXncobdFyF3bd2DwnqTfz9zGd9Rnen+IqjgHeUW4qLTuVNOi5j9y0cKuOux1z0Mpf1GZ0dupWvOAp4R7mluOhU3qTjMv7pFo6rA95TXfsqBL3MZX1GZ6e66FWu2jNvorjoVN5E9Vk/UO6U4AE1Ng1RXcVjfQbuqq3qTbzPYrMFxUFUFz2M1Rsit4rNNigOBY+w2KQk2rHYdIH1GbhTY1NKtI1i+gbVm6gueoo/iDZRTA9RPQoeimKaTHSjis0WWJ+BOzU2lYj2GNNCOu5gr6v4A7/xMS2l474dfDiM1fThWZ/hd/jZ5zF4I93f77if4OzP9xHuP8rNR7n/Ac/I19dfQalyAjjLtkkAAAAASUVORK5CYII="),
      "Demon", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAH0AAAAgCAYAAAA/kHcMAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAApNJREFUaEPtkUFu5DAMBOd/+f89r8g1gQYthKaaYlMeBePABfRlWKXswo/Ox9fndzaoN/8F9pGzIb25KuyjqsMTN1eDfczK8MzNlWAfsjo8dXMVqh/Q+0pz82asfEDfqN3Nm7D68Va7mzfgzMc7076Kd/g37Obl/8czD76y9YOWEnX+dzsoB5jXB2UJ9p4dtClR43/3gzYii4TV1nfRoE9hnTLkT9jdD2oJ9g4b9BDWqMMTRyRpQrW1vjJkIaxRV+2ff1CE9bMhozC/MjzzSyokVHrvqkNOYf7O4c9OYZ0y5APMrQzP/JIKCZVedVWv4d0+nA8wrw/KQMVtVHzVZV4bzgOpOz0KqL3qdVTfezO3wfw2nCm73IbieyfyLFN/ehRQe8XxKI11Zp7lbIOfKNbL3IbiK45n2kyPAmqvOB6lsc7Ms+xqFIeRNfYeOYywsYfhKKD23qsOzwyonmVXoziMrMvuEWFjD8NRQOm9szI8NaB6ll2N4jCyLrtHhI09DEcBpbXOmeG5A4rj2dUoDiPrsntE2NjDcExQW++tDs8dUBzPrkZxGFmX3SPCxh6GY4Laem91eO6A4nh2NYrDyLrsHhE29jAcE9RW9VZYeXtXoziMrMvuEWFjD8NxQrWruBXsu+rbuxrFYWSNvUcOI2zsYTgG+Ebpqr7Kyrs7G9XrKL7iMMLGHoYjwftK01hpFFbe3dmoXkfxFYcRNvawOjyVonaq16i4nZ2N9youfh5QPU/Y2MPK8IwE65Uhp1Tczu7Gu+qQD6ieJ2zsoTo8UYK9MxuykKrf+IvG+9mQUSquJWzsQR3SZdibbNCnXKmJBj2k6nfCxh6iQX0p7O/YQUtZ6f6qafjOD9qUlaax0tz8Kx6PH63CVeI3orr+AAAAAElFTkSuQmCC"),
      "Diamond", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAJoAAAAeCAYAAADU3gfZAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAzBJREFUeF7tkktuG0EMBXW/3H+fU2SboCU28IbDT3EUB7EwBXCjV9U2ID1ubv4JP379/F2daW/zFW/e/L+cvmf9AdCzdMS7/c33IP2edZic5Zh32pvvgX7Hp+/Zj5OzJ25unpS/Dz9Oz565ueE/NPuoRP1Jd/P5lL+LdCjQZtrefC7lbyIdGrSbtjefSfmbSIcG7Ug7cTfaZGdqSdb4z/fZfCJy19l8iei9faaUXGmu4v/WPpvr/yUdANp2PfU26ndnSUrUkLP8SbT7MxUTvRGd6SGZ6z/XMwUTvUHO8hfpANC266m3UZ+cZSGRT87yUW9JS9RWZ9mJyKVnT5REHT174kU6ALTteuptKl83PZtPRO5Xnv3ZlKghZ/mByKNnT6REzeTsmRfpANC266k3Qd+s3vXe1N1nygnqLbxb+cTzTuZt3nErv3XTAaBt11Nvgr5Zveu9yl1M/QV11evcRef7PXI81FWvcxelnw4Q2lNvir6bvU0cxftXGvv4BHEU9aOm2yNIQxxP2aQDhPbUm6LvZm8TxzNtiE8cT9d0ewRpiOMpm3QAaNv11FO0oWfpAeJ4pg3xiRNRNbpFewRpiOMpm3QAaNv11NuoPznLDxDHM22IT5yIqtEt2iNIQxxP2aQDQNuup95C3enZEweI45k2xCdORNXoFu0RpCGOp2zSAaBt11NvcdXNfOJ4pg3xiRNRNbpFewRpiOMpm3QAaNv1V7zOXRCfOJ5pQ3ziRFSNbtEeQRrieMomHRq0Iy11qbdRP2uI45k2xCdORNXoFu0RpCGOp2zSoUE70lKXehv1s4Y4nmlDfOJ4uqbbI0hDHE/ZpEOBNrSlLvU26mcNcTzThvrEUdSPmm6PIA1xPGWTDgnqX+3soxDqbdTPGuJ4pg31qbfpXN0zx0Mb6m1K34/Ts2daaKNe5y6ITxzPtKG+9yaufXyAOB7aUG/h3ZMfCfTsCcSkU7fyvZe5xPFMm4nvXXKWnqCeMmm8Ozl74kUkkLMcM2nVnZ49cYA4nmnzrt+dZSeop0wb79Oz/EUkdGfpiGmv/uQsP0Acz7SZ+gvfZGd6yMTd/I3GX+Q8wyePxx8tS3wAQv3UjwAAAABJRU5ErkJggg=="),
      "Lion", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEoAAAAjCAYAAAAzK5zjAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAapJREFUaEPtkEFOxTAMRHs/7r/nFGxBLU6w7HE9adzyQXmSN5M3sZJtsVj8Cm8f7596JF5Ynviou+9/BP2Iux7yxI7beeIRd9//CPoRf/ohd7M+imR9FMn6KJL//lFl7yu76ISrO2zPjminRB2b2xHth1Qo4MoO24lG9BDUYUeu+Ob0sIjRHdbPRmoQ5I+MXPN6H2VddqTuQO7IyDWv9VHWq3CRt48cO0IXhsWwO1ivwfjWiTwN9GFYDLuD9RqMzzgW2IFhMcwOxkFkHX0eOQjX0UEPi2F2MA4i62XnEa6jgx4Ww+xgHETWy84jXEcHPSyG2cE4iKyXnUe4jg56WAyzg3EQWS87j3AdHfSwGGYH4yCyXnYe4To66GExzA7GQWS97DzCdXTQw2KYHYyDyDr6PHIQrqODHhbD7mC9BuMzDsJ1dNDDYtgdrNdgfMZBuI4OZua4LIB1rTfiSuxgPYvr6GBmjssCZlx2pO5gPYvr6GBmjssCRtwd62cjNciIq3EdHczMcVnAiNuwnWhEDxn1G66jg5k5LgsYcTW2Z0e0U650dq50Ftu2fQGyNGmZT0O2eQAAAABJRU5ErkJggg=="),
      "Music", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAF4AAAAeCAYAAACliqkCAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAiRJREFUaEPtkEFuxDAMA/u//v/eV/TaQgvZUFjKopwsui0yAC/mUIvN280v8v758RXjz1tceevfc9XHwjtnbr0KT/0v8fiZH8A7Z269Ck/9P3h89weuuvNKPPW/xOO7P8JuWLy+YbAPZvFagu0tXt8w2AezeF3CtiOu3DDYB7N4XcK2I67cMNgHG3ElhW1iXJtUPWNn8yfAPxbjSgrbxLg2qXrGFRuMayVX7TC6lMD8GNcmVc/obtBfxScpXd/ADYskPiQCczGuTqqe0dmgq8SnlI5roJ9Flh8iwDyMq5OqZ6gb1TMUx4j3Kh/dVegge4tkffY+qHqGulG9Dp2bqjs7NmBvkazP3gdVz1A3qtdBval6B7JR9m5kXfY+qHqGulG9DupN1TuQjbrvxqozqp7R2aA74nUb9Y7qHchG+D469jZYdUbVM7ob9GNckVH2ikNZDbHDuDY52zOu2GBcK1F2ikNZDbHDuDY52zN2NgbuMK4tUTaKQ6mG2Me4MjnbM3Y2CN4Y8TpF8RWHUg2xH/H6QOVUPWNnk4G3qnuKqziUaoj9iNcHKqfqGTubFZ17iqs4FGWIjur586TqGTubCvXm1d4BZaQ4huJVPRJ9dVOh3rzaO6COuk7mKU6k6yuo96K3clXvgDqqeiPeyVx0Ms/ouEbH+S13dp3BqjfinZWLXid+4gfMVeJzyhl3FTp4PCYovXILvU78xA+YW8WnKWd9no+vbxiNLAYNX8/hAAAAAElFTkSuQmCC"),
      "Ninja", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFsAAAAgCAYAAAB90wSbAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAidJREFUaEPl0EGO20AMRFHfL/ff5xTZJqMBGyhVSPanbMcB9AFurFcajx/aj18/f+vFx7hn97fq2R9rsqfunX30O+gfv/IlJtuJfVcf/Q7+x6dfYLKl7p199DvoH9eLx9uu7m6Z/1h6QdqubG6b/1h6QdqubG6b/1h+wcqm/tb5j+UXrGzqd736ff9V/s9lFzTt1bYy/rlfsG1Xdr7JLmhfNso+q3q1dTO5eEXbZON2dzGrqwbV5x51R8S6mV68puxZv7uY5VXYP9dnGjErYt1ML15TNvUk/M4Ods9WxKyIdbMuHv/VxB5N7CT03g75M39+tHuuEeumctrET+wk9N4deva5Riwx3mQzsZPQewnqTPfMI5aYLLpRt7Oa73YXs3MEdaZ75hFLTBbdqNvZI/f0Yn4Ooa8qV32eRSwxWXSjbmonF684h9BX7pbNPqsilpgsulE3tZOLV5xDKHKbXdA0YonJoht1naVuhTxCkdvsgqYRS0wW3ajrLHUr5BGS3PsFSyOWmCy6UddZYjT15QYhyb1fsDRiicmiG3WdJUZTX24QsnyjFySNWGKy6EZdZ4nR1JcbhJJ8ty4epxFLTBbdqOssMZr6coNQku/WxeM0YonJoht1naVuhTxCRb7d7YklJotu1L3KuistQkW+3e2JJSaLbtRN7eTiFecQaprsiSUmi27U7eyRe3oxP4dQ02RPLDFZdKNuZzXf6WXPv0d379/+KI/HH0CEg4aPCdmLAAAAAElFTkSuQmCC"),
      "Shy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEAAAAAfCAYAAABXscv8AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAX9JREFUaEPtj0GOhDAMBPnf/v++r5jrroKM1DHt2B3CcKEkHyauspjt5eXlxM/n9y8aU2SutF/D/9nRWJIy0zwCfmh1LA1R/UfxH1sdyymK+yjKh97lPor6kYqn3v46d37knbeXcedH3nF7xc2uxx/7w0Ki2/7dj2khqu/pWvyxPyzE31bGTlAUl3Fq8aFbXITdVcbOUBQXoZ1/9LNLE7BbytgZiuIiYecXo7EkhbVtbH3iimvPKWnnhdFYErKisWeK4jYk38vRmE5R3AOlUdyG6nf4GMeUE1XPozToZr7iDvGHomMVh6E06I78qlemcrDiMJQG3ZFf9SSyo9k+Qm3QZ022nyY7nO0j1AZ91mT7abLD2T5CbdBn3Wh3iexwto+42mAXvS8hO57tI6422EXvHalAwCZqs33ETNPAjo1pPSWJUOkqDmOmaWDHxrQeJraxNaXqVxzGTNPAjo1pZ5isjJ05UfU8M80Btji2jmFRZSynKC4y0xxgi2Nrx7b9Ayp4EcokgCQwAAAAAElFTkSuQmCC"),
      "Buoyant", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAJEAAAAiCAYAAABfhjv4AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAxhJREFUeF7tklFuGzEMRHP/c/QaPVsCxZTBcoeaGdkpalcP4I/5HrHw7sfk96/PT3UiOfxn0HdfPxRn4sThTZHfdRZ3Js4c3hD5PWdxd+LU4c2Q33EWH5k4d3gj5PebRSondrvD6yC/3yxSubDbHV4D+f1mkcqF3e7wGsjvN4tULihddlZe5hlNnlBaXB/h3qg+mlBbXF+h3uwm9BvLJUHpsrPyMm5T/W5Chzguwumru5pIIJ1bf88TSgtq0IR+Y7lcoHaql3Ga6rKJ7ILqIdy2+mwiu4BcdeLEBeSiCf3GcrlA7VQvozbVUyfyC6pXcbuVm3d5Yv0HyFMnTlxALprQbyDBnTgFcdyJ0lSn8wbP9iq73QrlZnU6b+K4A9nN4s7EmRbXHyiN4mQUX3EqO42Ccrc6nZf5ETeLOxNnWlx/oDRsX8n+qlG9ies7sNtsj3Aa1bsc3Zk4BXHcCWvYHqE2qjdw3B3YfbZHOI3qXY7uTpy7oHoZ1rB9h9rseMyt1FaZSO+wPcJpVG/7j1A71cuwhu071CZ7K1f1KrVTJ/I7bI9wGtXb/iMGSqs4FdawfYfaZK9zFQdRO2fixB22RziN6m3/GQOlVZwKa9i+w2myi3y273Ca7CKf7RFOo3pbDzJRWsWpsIbtO5wmu8hf7Tpyo3TMZ3uE06je1oNMlFZxKqxh+w6nyW71V7sVbpN91LA9wmlUb+tBJkqrOBXWsD3imU33O8Ntso8atkc4jeptPchEbRUnk/2uYftK9h9p0G8qbpd91LA9wmlUb+tBBk7nuAPFV5yM42ZyhyY0CbfLPmrYHuE0qnc5ujtxDuL4qqt6A9VD1DZPKDJuz3y2RziN6l2O7kycWoI6deLEBeSyiVQG3ZgTioV6o3rIZXuE08huFd2JMxKoVyZyCPJXE5kFujMm1hbojjpx4g7bI5ymunlCuYEEdeKEBbqTBznf4YLqdxO6zTNvDdA9ZSK/w/YIt6k+bJDUTST/JOh554SyzU/cHKC7c9D+O0qwPeJvNQfA+RMPD5E/oPMRHbY4H9HhIc4H1PHx8QUvb7rBcWos2wAAAABJRU5ErkJggg=="),
      "Fuzzy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGQAAAAiCAYAAACp43wlAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAepJREFUaEPtkVGOgzAMRHv/c+w19mytUk0QcU1sj02bjzxpPoCZByKPzv/f81kR6DZZtJ/LBLpNFu3nMoFuk2X/2MXYB7IY+0AW484DYdzMZiXS358WTGDc3o3sRQLFgNbzBooD6/mU1NiAcXs3shcJFANazxsoDqznU1JjA8bt3cheJFAMaD1voBjwdFTooQPG7d3IXiRQDGg9b6AY8HRU5NATTE2YHbOZ8Suft/eBHHqCqQmzYzZXVLoaUV+0/0aOPMHUhNkxG40qT4fxMZuPkSeYmjA7ZqNR5emwvvBODjzB1ITZMRtJheNMxhfehgcBGDezOZPdS7K+8D48CMC4mU0ns9Wo8lme4Z5VzsC4mU1D7iJbjUqf5RnuWeUMjJvZNNjdFZU+6ZK+4XpWzMK4v7WZUe1rXDnl9S0v7zDu6Cbat6j2da688vq2D+hE3ee+tZFdq29R7ZNo/h5UYj+AIer39mVv1vVQ7dPQ3tGDSvyHRZH+2TsyXdymqfZpyHecg8rvP8QKFANaLxJoDrROJNC40PYteLwPpKF1IoHGhbZvwePvHEhDvscbzAe0XiTQHGidSKBxYe6nD4uR7zoHlTdX9zvn50ygOdA6kUDjJrvfFLMPZCH2YSzGPpCFkIexD+THXB/G4/ECywP/t7THbOkAAAAASUVORK5CYII="),
      "Precise", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAIIAAAAfCAYAAAAr+xVgAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAopJREFUeF7tkVGO4zAMQ3P/c+w19mwzqMEErkrZlGRjm0UewB+bjy6a48XfPz8/Slr54f+FfXQ1mHgg3O5/6n9wJph5MNzuf7I/OBNMPXTc7v/pf3AlmHu4K9kPar2I+/CFVD5mxX34Miofs+I+fBnVj6m6fW/WffgHVD5QxPW69ry/G8G8PqiFYVt9UJuS8axjg1oIttMHtdwPPom4tjsKFBfmsKAuwza8QHGp9keBMoW5LLTcDkUiru2OAoXC+qNAm8LcWaBSKl0lUF2Y44UK7VDAejOX9b1A+YB1lUB3YY4S6BS1q/ZeKJ0X/Z6SlOSljQ3IOBbVV3snat/2Il0cf6D2Iqibb/e9kE0bmpD1TqKu2ld7J9HerK/2VKJ7V8eK0bQRgax3knEVp++MelHUXbWnkt7qxWgwIVFxX2Rcxek7o16UyK7tnsF1iLTfi6Ognqa6Z/1oMPOG0skS3bb9PqhIMH8WKrbDDVTesW4mmHpD6WTJbFvHBjUX5iihcjvcQOUd62aDuYvZfYXstvVsUKOwvhIqt8MNVN6xbjaYu5jdV1ixbTfO4PoD1lVC5Xa4gco71s0Gcxez+wort+2Wt8d6SqjcDjdQeafijti1+2L1trKndFxKcoDqOxV3RL+7cnvHrrI5u3fpxbAcoPpO1fe4066yqXQoaTFI9Z2q7xHdjfbUvoKy13dGvQ/SYpAV76gbau9E7dtepItjSqSzsvt23wvX4QZWvGM31EB3YY4S6BS1a3tqoFNYfxQqtcMNrHrH7swCbQpzZ4FKUbu2pwTqEOZ5oUI73MDKd+yWF9Rl2IYXKC7VPguqMmyDhZbb4QZWv2P3bFALw7b6oDYl663G/g6b4ziOX7J/80dqVOLBAAAAAElFTkSuQmCC"),
      "Spicy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGYAAAAgCAYAAADg3g0TAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAhVJREFUaEPtkUFuxCAQBPf/78g38raNvBpLqD1ANeAsB5fUF1M9Y+xXi9+f97uWULZh53dbRnnJXqLydXZ9r2XoBUmi+lV2e5/llBd0EvWHO3A+tuM+TOJ+6OeH/APlT3k++Ebc/WPunv8NVtxJZ1zmNA8XkM3XZ5pPETLa1Z4mtCqur3T7XWESnU8T9S4jPe20EpUL1KuB+ipVxQGy2TQxoonbUZ8kqheop2iv2s3EMqENkc1zEmOqOL66NFG/QD3F6qncSlQQTt9xTxyfuurVXOJkDPW01EpUmrgd9Xsd6lLvxPXu8i/ogFpCr+L6B06HutRzcee6fhcdWCaUFMc9cTrUpd4IzmzHtdHhrQXUK3E6xCXODHQ+9aagS6hX4nSIS5wZ6HzqTUMWEUdxOsQlziy9Hb3zpZBlxFGcDnGJM0tvR+98KWQZcRSnQ1zizKI7dE/rbDlkGXEUp0Nc4qygtqf2/DbIQuIoToe61JuhtqP2vMtIqey0usRRnA51qTeL7tGE1me0SHvUO7nLp94J9ZRyR5bQ+mTlI3Gc4viOe+C4B45PXfVarpJ1y4TGyAY4iTEpmU8TI5o4HXVpoo7JZhyJY49sEEnUq2Qdkqh3cXvqk0QVk804Esc+2bBWotYk6+gzzacIGelqp5WoWKyacyEbXCY0xEyXMDpfe5rQhlk9bznbv+BNbH/v7V/wBsbv/Hr9AXD5633YzoKgAAAAAElFTkSuQmCC"),
      "Tadpole", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAIoAAAAgCAYAAADNAODsAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAsZJREFUeF7tkVGOnEAMBXP/c+QaOdtEoIfWMsZdNrA9g6ak95OtMtPKny9fSvz7+3pdMZ378lSi//TOdO5j+MTfTLnl/2Q7enY69/Z84m+m2Ldd/j5/vDude2s+8TdXmPa+aR++iae9xzPtfdM+fBNPe49n2vumffgmnvYez7T3TfvwTTztPZ5p75v24Zug76HeuzHtd1/9YX8vmtQW0b1t0d/XKCDy/L/5rWGD6JadNES39Z2dlJxWFODvjKYME90gU74jcsmUY6Ib0aQP6XS+8ZOW04oO8LdGUzYkaul0Ykfk0unEkKjNpiyl2ng/mtScVnSCzvd8U5lO7IjcynTmkKghU35Ixffu0aTntKKTVL7p3cx/B3eh4lfchbvcIZceg1S+WXEXqE+9De9nDfU2Kj51qYe5/CCAfpN6FtpQz0Ib6m1UfOoSp4Q9eNVRf3M0ZTuoZ6EN9SykIU4EbayXucQpYQ+ePepv0SnfQT0LbahnIQ1xImjX9bIpyWlFAf5OZTqxg3oW2lDPQhriRNCOeN4ZTVlOKwrwdyrTiR3Us9CGehbSECeCdsTzzmjKclqRo3qD+tSz0IZ6FtIQJ4J2xPPOaMpyWpGjeoP61LPQhnoW0hAngnbE885oynJakaPaWz9rqGehDfUspCFOBO2IR5wyVxyt9tbPGupZaEM9C2mIE0Eb62UucUrYg92j1d76o4Z6G9bPGupZaEO9jYpPXephrjhY7a0/airuAvWpt1HxK+5Cxacu9TBXHKzeqPhn3MyvuAtn3Myn3kbFr7hDrjpG73gvczeihk4ndkQunU6kRB2Z8kMqvnePJj2nFQX4O5XpRErUkSnfEblkyhFRn01ZSrXxfjSpOa3oAH+LTvmQqLWLnDUMiDz/b35rWCS6E036kE7nGz9pOa1ogL9pF/19jX6Z3/wN/lt+0hDd1nc/e73+AzkTc7Nh7NmkAAAAAElFTkSuQmCC"),
      "Vector", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAHkAAAAjCAYAAACw76XYAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAoNJREFUeF7tkVFu3DAQQ3P/c/QaPVtSAfRidkKNSMlC14YfwB/rkZtBvh4eHu7G3z/f3zH4bHPWzsMGzvjnnLHx6Vz6tvjPmT3ijI1P5Ta3rR6y2v9kbnPbyiEr3Stwm/tWDlnpXoFb3Td7zGzvKtzqvpljckftXYlb3TdzzEznanzKjaf9He6Q62dyPweaDduKgdaFdVigl7BeDLQhvV7+Ht8olvwP14/kbi/QZdhGL6j8grks0LuwDgv0EtbrBRWOIztuJndHQW0I646C6hvMY4FOYX4V1LqwTi+ocJyC6mVyTw3qXVhHCepvMI8F+i+YqwR1CvN7QaWPWlC9jNpTvQPVz17lNhy3kf2qs8sdogwpDsPtqb7qHaheI+4qnV1+9ip3iDKkOIxdnehU3gzu9i5f9WRGg6P3Hrs60am8GZxtx40onehUnkw1WL2NyF03mHlDcVZw9h03ovQUx6IarN4qcm8mmHpDcVZw9h03ovQUx6Y32vs+Ivdmg7kXo/dVnH3HjSg9xbFho/nb8V2BdWeCuRej91WcfceNKD3FscmjLFAlWH8mmHsxel/F2XfciNJTHJs8ygJVYqVbsWv3wNl33IjSU5wp8nAONJmVbkXc/Z/bjhtROtGpPJs8HAPF4owNxq7dhru9y1c9mzwcA8XijA2Gu6t6jbirdHb5qjdFHj+CZxt1R/UOVD97ldtw3Eb2q47qNRzXJo+v/gDbU4J6F9ZRgnoX12/kjhrUKY5rk8fP+AG2WQW1Iaw7CqpdWOcIFArzq6DWxfVtdvxA3uwFugzb6AWVIazbgucurMMCvWSmY7FrPO6yQLNhWzHQLGY3ci8H2pDZ3sPDw3X5+voBPktbUTsF8SYAAAAASUVORK5CYII=")
   ), gifteds := Map(
      "Bomber", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFIAAAAYCAYAAABp76qRAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAVNJREFUWEftkFFuxCAQQ3P/M7Z/e4+2RB4EwWMGSrWo4kmWIvzM0l6Hw+Hf8/H5+mJBfYjC/olloG3JVu97/uNYoG7Fdm/rPWi7B4Pt3tV70HYPBtu9K/KgFQ9e/Yevvo8x9Bs9WfXWPYO6gnkWKDeqK3l6ZaC4RDfMS0FdI8sfVG8dC5QMc6LBFRXMKwOtgbkWKJmIk2HyM1Areh0+M5G7RnbeeWJ2g8+M8htMVoFa4Z0n2K5312g3u8Fng+erTYXJKlAz3rnBerWZ6X6zUYF6w85cejLrV29mOrVJqI0K1Bt25hKRmaM2nu9tZjq1SaiNCtQbduYSkZmjNp7vbWa62Q0+Q6jfaOjJXq92M/5ot3rDGPJN7gV6BfMsUDLeeWKm623w2WA7FigZ75xSXuQFKiXqr+7snAWKS3SjuobysjKol6Hune3+mnf+9uFweBPX9Q1g/aBw+xW9hwAAAABJRU5ErkJggg=="),
      "Brave", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEIAAAAYCAYAAABOQSt5AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAASxJREFUWEftkMFuwzAMQ/P/37jd+h/bjFCoLVMSGxc7NH4ADw0fFTTHZhPz9f34YUF9H9hH8IH62bA/zgL9c1H+6C0+xv4QYPVDKPsrqHff9n7lUOZY54N6gHkWKANZ11D7PqhmSuGPzLHOB/WA7/vf9qwnem5kvXUsUEaYyAJ9QnEqon1198ou7KzIApWiOBXZjai7sjFoZ6Mq0CeqXiG7EXVXNgbtqlEjc5R9j/ksUCZYl22sqwL9hD50ZI6yN8yNAm3C96pfBfoJfUiIvNV9o7rhe9WvAv2EPnRkjrJvrN7oe8WtnAlllDnKvrF6w5xXXPwcCLc2UoLJQNZ5Vm6Yo7gN7/tAe8IkFugTVe/pb/pACVE9o7/dB/UIEy1QUl5xV/nPd202t+U4fgFLUbz9w4OnCgAAAABJRU5ErkJggg=="),
      "Bumble", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAE4AAAAWCAYAAABud6qHAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAU1JREFUWEftkOFqAzEMg/v+z7j963tsuMjFuUpO7GZHB/eB4LAsJbnbxUa+vu8/LowuVog/7j/8wM79/uRN8YdFwf4oOnc79T2nHlagc69T33LqYQU69zr9Leyw7ALsgmz2Dp2+3XdIUYdlF2AZnzFh5UHmRY57UVh5YdWPglVHFWSlLOOzjlAxwPaisDaw4jFhRcNCJtgDam6w3KxL+dW5Uc2ouaHmA15wFOwBNTdYbtZV9XZmVI+ReU+8+CjYA2pusNysq+rtzPg8E1bXUcGsjGVUj9HxsoxRyfg8E1ZrsHBWpvZVpuNlGaOS8XkmrNZg4axM7atMx9uZUT1v0TmMZVSP0fF2ZtR8GS9gwsqT2fzoqX2j480y+ByYZZSwomEhE+wBtncUVh+wmdPxfM6ElRdW/ShYOdVA3I+5+O2wmdP1quzsuri4+GBut18WswjYSKaqVAAAAABJRU5ErkJggg=="),
      "Cool", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADUAAAAZCAYAAACRiGY9AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAPBJREFUWEftj0EOwkAMA/v/N8KNf4BSZavAOrEVIWihI/lQ2RNtl5OTHXK53u4oXu8K+q7Xn8ji868jvYeNpCMfhL5nbw9W+L+fGuU7fireivE6BTkWryHlRj3CiHdQfDaBtjE+myh7JiuMG9mdrOt6RtXVpQi7kfVdzyjdshRRbqBN1zNKtyxFlBto0/WM0h1lOhBQfLTpekbpjjIdCCg+2nQ9g7p0QFB8tOl6BnXpgMD8rO96BnNX2KjqR8d6/9zoekbVbYwRi88n0DbGZxNoG+OzCdY/EQ/GeF2CPIvXKcixeA1RNofjJ3/q5LgsywN7kFeaLWbJAgAAAABJRU5ErkJggg=="),
      "Hasty", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEMAAAAZCAYAAABq35PiAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAATFJREFUWEftkFEKAyEMRPf+Z2z/eo+WyESyNokja6ULPsiHzksiHpvNZojH8/WWwjGE9W7NnT7j5/vv8hlL9rNLljwmYcl+dsmSxyQs2c8uWfIYB93bFuKCd+cR9VdGB+F4QjOvoHzhuVKIK54jhbgS3Vu6DjNEyDzNNLdnvbO0eVvQCl4uhbgS3Vu6jgpsoY0i6pk5S7maF1RiC20UUc/MWZbMYfqrxBbaKLKe0XmMnzlMP/2onqe5V1BcGEe4MovpLbBi5mkWFbSUnsvO8jy299ISIevPMo8Zs1qP7SuwcuRl/VkWMWOWdUf6aDnysv4si5gxS11biHJYOfOyey/T+6ignciyFjuL7SmwDT1Pc6+gnPA8KcQurCeMuJXR4Tj+PXd770/Zn2HYnwH4jziOD3EtULXSjLJvAAAAAElFTkSuQmCC"),
      "Looker", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEcAAAAVCAYAAAAU9vPjAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAStJREFUWEftkFGOwjAMRHv/My5/e49FKePIcSYTt1sBgjxppDJ+cUu2xeJ//Nx+/0rw8y14m+9ZlyNYlyNYlyP41stJ/e+zl2PnYjDuYG4Jxg2sV77HPB+MGphXgvEDWibwC2OgNDDPAqUSu5EXMY8FSiXjpF/sUWdYf8bHozzrUR7rU3tTUkD5bN8ZPwajIcphs9TelOSY+XF+1C9YZz1zIv7MKFB3WNeRkhwzP86P+oVRh0eKnVGBusO6jpQUUD7bd4XPPI/NVaDusK4jJQWUz/Zd5c/24DEFe29HSgqoM6w/4+OxYbZnNGOkfJNmgV5hjgVKA/MsUCqsM2azUaBURn2DX6ACvSHrGVl/1BfUuYLNfTBqULOKX6IC/SnM3nfF97zify0+m227A+gND722WPfpAAAAAElFTkSuQmCC"),
      "Rad", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAC8AAAAZCAYAAAChBHccAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAPRJREFUWEftj0sOwyAMRHP/M7a73qMt1TgyBI+ngPqR8qRZhHk2ZDs5meByvd2jQPldeo/uBfpXCO9vH8mCkY9C71Yfpnqrofeqj1K91dB71Uep3mroveqjFM+cNqgpvTkfaDW0dChe69g3m/MOC/SanhgFI2/D5pUu6uf+XITtyPbT3koWqMNEe5T91GElHexgfhRoO9G5hzrZgqw3zGOBuhOde6iTLcj6wuiObK5AnWxB1hdGd2RzBepML3gy2tv5yOyLbLiQOTO90kV9enEhW6L2+KzwsyzQa2jpyDzrWaAe6LltoNbQ0qF45kSBdvKnbNsDTQvV7groXYIAAAAASUVORK5CYII="),
      "Rascal", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEkAAAAVCAYAAAAKP8NQAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAT5JREFUWEftkFFuhDAMRLn/Gdu/3qMFNI6C8YxtqFrtiieN1M08OyXLw8Pv8/H59R0F9cNG9EA+UN8a+Z3+QVigvyXpN1Ye4Xmk4iNlziuTfl/lAZRjnQ/qkMjfgvpEx92I/C2oT2R9LqxULjDH//bMvQ+UA5FngXLCO/63R3U78wIV6GXYXGefcqs7Ztg+dc+OCSpQW7DZzs6OW4HtS+8xgQVaGzVf3Xv3f/Cwfek9lweBeSzQTlQd/Nli3h0F2oCdD5SQDVuvAjUk87L5iHknC9QBOx8oIRu+MzvD3M4OQ82wTs3sZMKdTvWeyO/u2FA+25fekwmqvzoXEflqR/d8g+1j54NMUP3VLoL5dh4FyoErnZrZSYUV1ds8C7RB5MyBdqDqGZE/B9qAnQ9SYaXidLB9Pqj/nP++/0VZlh+5daO5yx/vzQAAAABJRU5ErkJggg=="),
      "Stubborn", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAE4AAAATCAYAAAA+ujs0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAARVJREFUWEftkGtuAjEMhPf+Z2z/cY9WXk1Q7J0xk1YgIfJJlsw8DOTYbDabT+Lr+/ZTB1ai8xxWuv/5npew+mf2w4H9cH/E/YHj0cZAlo/JdJZTrGRdxs362+pni1F6VJxzc7Z+HjB9aHVgJ1guBvYFJ6f8Wa+DiMYpME/lVRbrHaYFz8h2/ZW8pDtU9dUs1oTqY02wm6rPslgT3Q2sPuyYqwUqizWh+lgT7s3AzYbOPKU/pJbYIXVcZbEmVB9rwr0ZuNnQmaf0FlZytUBlsSZUH2vCvRm42dCZp/ST7hjWhPoCrHdCq7rbDZ6R7foqrzonIzAPrAvMn3t1EDlhfgzsBMvFwL7g5Dqded2tj2I/3OadOI5fwf0sSqC9Hl8AAAAASUVORK5CYII="),
      "Bubble", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEkAAAAVCAYAAAAKP8NQAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAT9JREFUWEftkEuOwzAMQ3OE3v9UvUzXnbqgAjsmJcdVPYvmAQQC8WMg28XFd3jcb08m2BcF9oNqIZbCzN6qjov9DE+IfsTM1qpOSDSa9ejMzqpOSDSa9ejMzqpOyMgo870O22S3iFWdkGhU+Wc7dmNCpINlTYh0jPq1YGmioPLPduymhFgDy9VCrGHEY0KEwwpHIdqg7gXWi7aYl9lR94K671jZE6IN6l5gvWiLeZkdtVPwvDc26gnRBnUvsF60xbzMjt09IdoTBZR/tqN2DOZlduzuCdGeMPCCZbyOykcdfO5kduzuCdGeMPCCZbyOyquO8jI7amcINWrMPMo6aqegvMyOug9h5UiI70T3o6fyBe+e3VFChMMKRyHawHJHIfqG+SZEOljWhEjHqF8LloaVimC7qF79vZr/fPuH2LY/ueUfITkRyNIAAAAASUVORK5CYII="),
      "Bucko", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEEAAAAYCAYAAACldpB6AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAStJREFUWEftkGFqxTAMg3uE3f9Uu8z7vT2DXJJUkpcUusHygSBYktPm2Gw2lNfnxxcT7P8Be4BWiD3Oo3ePP82E6KM8em/1o7/1EPsR3vypRwiY7zo/2Vlxtz9F9cHKX+0wwe5gc5dPMjMKNqcKKX+1o4TIyThTuZHMMSFyhYVHIdqh5gHrze5qZ67b4nK2n0UnRDvUPGA9t4uR+VawJC5jd6TphGiHmges5/KM3JG99sy45a+WZzpqh4N13I7qDutX5YBlXGc2z2B5trel8qRfLQ5YxnVU3nVGVNbtqDzpW/ON8mc7ak/A5i676uF4JYuVED+p5pU3CpETNksqTwmRKyw8CtEOlhuF6AnLhGB3qHngekH6rWBxWCEE26J67XmVqn93/2azAcfxDYcJNyqonJTiAAAAAElFTkSuQmCC"),
      "Commander", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGwAAAAVCAYAAACjSwvEAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAT5JREFUaEPtkdFtwzAMRD1C95+qy/S7LYVzATF3DGk1MhDwAQRk8h3lxEfTNE3TNM3tfH1+fPvCqAm45X/qj3Od7f9df6w13uaD2V5WbDYCDu+cxWYj4PAO81S/wkr+zJbe48qF5wXRRayv/Eov6zK8d+5jBWWCeVYYT1QdtJ5Tkn9hfqW3K8/wXmWfumMlr3aGVELmqot9X+3dlWewO9Q+HP9Q+1fyamdIJRS5fqZc1rfeK/KsMB6wnqFcHCeYFxW0gX9OUQlFbvZlWN96O/LMUR5zcZxgXlTQBv45RSUUudmXYX3r7cgzR3nMxXFC5XEMyXoPVILZF1Q7lev7r8gzR3nMxXFC5XEMyXoUC/vC6IGMV+mzPf+RZ4XxgPWMZ31fGE9kHRzvp/KS7Eet5jOo3NV9VXbc0TRN8xYcxw9BUf6LdGUnnAAAAABJRU5ErkJggg=="),
      "Demo", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEAAAAAXCAYAAAC74kmRAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAQ9JREFUWEftkEEOwjAQA/sE/v8qPsMZCLJXKXi9aXorGckH4nFQui0Wi+Bxvz2/g+o/UB+gD7Troh79HajXpHrk5T/C+gADD6wc9n1Q/aDcPtAO3UlmNuXjGs5hpwJlh/KOBNf8oFwGimZEyhy3defZbqTDzx2z3YdSeJM5bntmU/X4GcxsglJ4kzluO7NpuD7r3H0N22eX9mQOz12gBtk5cb3qnE9sP3qBcnjuAjXIzonrVed8YvvRC5TDcxeoQXZOXJ917r6G7bNLieurraLauD7rZjZBJbi+2iqqjeuzbmYTUHCBKlE+A2WH6xqzW3YqUDRq0Aea5cjuTD+67YMqZ2p0guo/XF9tF4sRtu0FfP9hlkPc3CgAAAAASUVORK5CYII="),
      "Exhausted", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFkAAAAUCAYAAADmzZEdAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAVFJREFUWEftkF2KAzEMg+cIvf+p9jL7vIuDFFIjeRKmeWo+MGT0Y5deh8PhsMjvz+vPDSKHp6g/l4PIMk/7u9n1++zOXcd27P0Uu36f3bnr2I69n2LX77M7V465bNbje3Yvs+PA6qzo1MaB1ai8p9h9q4dyXvVDc4NISc65rtJVboQd1Q3ufJJzHNjvTAcHmHFZt2dmd5Bz1T6VxdNS7cOzM6sFTu8Hx4Flucs6z+UzOVftczqekpXeyn6ne+OGqhee8pVOLQ/shtICpwerHjU3iDXyN3G6Nwp4uDqmPKW7HJ4N1QucPjLbo+YGsUb+Jk73RgE71THlKd3l8GyoXuD0zMo+PEtczvZnF5OcV/3QZnWXw7Mzu0/x5IbC5Ww/DDeIdJQWZL3qu2we2B2V4SDSuPOJ88ae8knOcWC/o4IcRBr5eyTnVT9w+uFwOHw11/UPeOYYDvc40vwAAAAASUVORK5CYII="),
      "Fire", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAC8AAAAVCAYAAADWxrdnAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAANtJREFUWEfljksOwjAQQ3sE7n8qLtM1UMmRHOp4XCJQVZ7kTfzJLJdhvd8eqVDpcN7X4eMqoXIe1JEjoXIeTntYwt8e37qq//7ushvss2BrotAA9wl7LNgdKsdCbI8KsxCTuBx7o0xj5FW9nxyPJ0mVsX4zR0JM4nJJf6PKWb8qO1pX9dNd3nBCvMeaBW483eUNJ8R7rFngxtNd3nBCvMeaBW483U1zkply66p+upvmJDPl1lX9dNdtlHxcfOE+PrLLO0qI7SkDBvfB0V3eYsHWRKEB7pOZ3YuyLE9hAqyH3nQhmwAAAABJRU5ErkJggg=="),
      "Frosty", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEMAAAAYCAYAAAChg0BHAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAS9JREFUWEftklEOwjAMQ3cE7n8qLsM3qJMzhdZNXEalgfokfzC/pN3Etlgshnjcb08l0P8b9uIs0C/DlHv5F44C/TJMuddVXzZjfQzHZT7GlIuI2Nl1UMt3o4467LGZOqgPmFOCukFxmVOCeqf+XcNmdrpFgM34oHqDeRYoB8yxQNlhfQnqHfbM0+2tYIHSkPWFyGHPlZ2ebH+0q9vZIAuUhqwvjM4rOz2Z3+vCOStZoDTM6qOZmilnZEsZ2cyZ3rpovpA5rM9mcoGgzES9eubZHbWTzqQCQZmJ+pEze56yo3Yyf+hihjITOSPn9fZE+z3mSb4kVagz5rFASen56h7zFFde6hmZMdcH1RvMs0BpyPqCsudAFh2fzCjYXh9Up/jmrp9nfQiw/hWO+GNs2wuEwCYyvT122wAAAABJRU5ErkJggg=="),
      "Honey", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEMAAAAXCAYAAABQ1fKSAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAARtJREFUWEftklEKw0AIRHOE3v9UvUy/WxJGcc3ouiFJadkHQnZ8SpEuk0mN1/PxXgtPSsX5C+YxDPMYhnkMw13HuPKY1d/XdSqLIkdyX2g3SO5dySOqfpQL2axSkSJHclZQFObYgtbAPCkoSpQLvf6GSJXCyAbLBJZ/01/JeoosqRRGNvzbcoePz4Ysz/YpIlYKI93lrH/E7xVUJcvxmRMtsHinN8P6R/xeQVVYHrmUisycbOYsv1dQG3wvc3dUZOZkM1f7GX7X0B4/zGBONsfyyF1hu1hWRWaHd1QGIkdyVlAUlgnZTFRQKFVvx8hyPBukZwuthihf6c35QitkxG2oDB1a7Mjmz9jvuWLnzzIPAea/wjCPAeqHWJYPTNs0VmisZN0AAAAASUVORK5CYII="),
      "Rage", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADwAAAAcCAYAAAA9UNxEAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAQ5JREFUWEftj20KwzAMQ3uE3f9Uu8x+bwvIpU1kKx90sDQPBG395OJtcSdez8fbC5S5YIfmgToH7EAW6P9PzUFTHb0OJvz64Ev/V7NcOTZngUJh/jHQClrcgpqCcmxuzvHdvuXkDgvUE8yzQIlhRRboTUTdnllPp8DEKFCb8fpq70gPjz62xAu0LrwdavdID48+0RL1gyPmskDZ8b4bqqcCnRNJVQu+mOcF2o733VA9FegcJakFUd+bRZ2E6qlA5yhpZO7Nok6it1eFWjIy92ZRJ9HTi/adiJYYyvFmUW905gWaT43Y4rBAOcG8PFALmJuCcUyN3LSwAdvrBdr8rINn51YHr2Nn5lbHXse2fQAeMHsKtMxyFgAAAABJRU5ErkJggg=="),
      "Riley", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADsAAAAbCAYAAADCifeFAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAQxJREFUWEftkVEKAjEMRPcI3v9UXsZvtTAp2912kk63IksfDKjzElLcFoub8Xo+3q1AuQ+1Rx4DtYrnePM/xY71Ar2LkdkpRA5Sj1bnphE5SD1anZtG5CD1aHWuRnSXeVU3soQ5ameYsw+qE16foM7oArVLWF8LlALWGdSx0gv0E6y/umMzCa/PAgvUKsxRu8SMnVloBVoT5qldYsbOseEv6rx1XqBnen8vYFJkgTpvnRfoBbWO+RlP8haw+UjnBXrBsWNugSeO9GoXYT8f3uWJI/1Ih49NbH4fVG0iInPULmF9K9Cq9LiZiMwctTPMOQY1pdfvOghfC9TuCmbv/yvWY+/I+lfvSuyx2/YBnv1ZGiDCi7wAAAAASUVORK5CYII="),
      "Shocked", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEwAAAATCAYAAAA6T+sJAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAR5JREFUWEftjkEOwjAMBPsE/v8qPsMZ5Mobhe06NpTmgDJSpMSetbMtFovFP/G43558vNWI6lcze2+6q/qZ2R8Hs/emu6qfmf1xMHtvuqv6mdkfB2rvlf9IZ+NDmdh7fFx5o+IY7LHLNe4rkOEswx6Ot8dkoVHdr40zNcYceP09QvWrNSObL7EQB1XN+MTr65HHwOuPtySqX60Z2fwQC/ZhfgPl+fUAeyMXsDfKwI2Oazv8BlG9RB9WSw2uKwewN3KB8qIc3Oi4tsNvENVTeAm/gfL8eoC9kQuUN8pVZhqRl+arQXsrV9Ujz68NVWPUfCPKVmYap/Im8fFW49t61AfssatqhqoBZKIsYA/H2+eIhv10iWA0/8q9i8Ustu0FJ8hag+5iC+cAAAAASUVORK5CYII="),
      "Baby", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADkAAAAXCAYAAACxvufDAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAQ5JREFUWEftj0GuwjAQQ3s/7r/nFGyhrTxRScaeSQiLQp9k6VM/Jz/LxcVJuT3uTy+ofwPvgXWgTuMbZ0rqB7FA/5jZ56XIXPo3j5z1j808K03mUuVYVwd1g+daoDREvUG9zAGqt7059e+aY+8FWoPqDHqGFVGgp2E7dd5otyF7K1WgdsG20Zmsy+xob2UU6GnYLjov6livduGlG9HhKtAK7LuhetapzU4orDDHvqtALbDvhupZpzY7obDCHLUd2Wz09pG/k5GYo3ZqM7Iz6j7ydzISc9RObaId/qQcnYxfLo0C/Y2RbmRTY17WbwZeoLp4/jHQCp5TByql16eXop6Od9cx0EJ6/VNyPXJZlhewx5CuoDB6OAAAAABJRU5ErkJggg=="),
      "Carpenter", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAFYAAAAUCAYAAAAXxsqQAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAATFJREFUWEftkEEOwjAMBPs//n/nFVxBrtZWMGvHKaWCkpEsJeuJm2aZTCaTybFcbte7L7ROxaH/dtZHZBz2sP/0qMLXPqxerC20ntCcOdGZrbBvMNSr+gw9152x9QMtbIZ+uNdrC+0Xep7vtwVlJesJvb7Q6xtdoQCbkc0d8Suu7KszR10sDZZRymLC6AWiXnWOz2Q/cnbExdJgGaUsAvFZoW2wTIl6PtfZUUEzD1uD5VkWFbQVvw8pi4D51UyJej6XfVbQzMPWYHmWRQVtxe9DyiJgfjVTot7oHEWc6KzPMxfLlKq3MiJXL5XNHPGzOYo40cwox9JgGaPqGXqJttB6gnlSaBssU/xZLbRf6Hl751FfiPLDyC6w9+Wih4jyd9h73q589eV+mfmwH+KcD7ssDzeoy7/9JX22AAAAAElFTkSuQmCC"),
      "Demon", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEkAAAAZCAYAAAB9/QMrAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAT9JREFUWEftkEtuxDAMQ3O/3n/fU3TbRgZp2A4lf8ZtF+MHEBiIT8rA1+Gwn4+vz+8yGB9K2kdqA+29UQ/TBur7Ej3EeSTQe4jzUDd/9Ui77qzy0rdH/nzUc78MqgrlMVASUdfSugzqCs5bl/OQEdFzOFeBklHOaHDigXIZKBnllIGmGZGUE+2pec/3+tm5scOviJaJcqId1akbZKXzfEPtzPoVXeFGOZxFgZpQMzLbRb7h7eDng969vnCjeu5FgZpQMzLbRb7h7eDng969pQ8anEeBmlAzstJ5vqF2Zv2KnuD14VFB9J2VzvMNtTPrV0TCaqdYveV1vR38zHiuEd1KUIgC9YFyGSgZb2682qlAyagZ8XYyFLxAcxnd+Y3OYF8GVYU3N6K9BIUyqLYS3V7tZohu7PrG4XA4HP6N6/oB1MAHfaxDJK8AAAAASUVORK5CYII="),
      "Diamond", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAE4AAAAVCAYAAADo49gpAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAARlJREFUWEftkEGOwzAMA/O//f+9r9jrtixkw1ZJR4r30lYDCGhGpJP6KIriLfn5vf21MVVEGC9uHFt/JaH/r0LffHl1cRfZujjAdsr5sdUEy2HY7lm4wG4fhPqrENtFPyrahcu8p+VXPTUWmWA5jK01qxDbhQ59EO3CZbL2s+Pd7nlA+YlVKPMyT6arsqP3z41Mzn52mAPKT6xCmQ9gY+sOc0BlR6+6wOdYlnmWA8pPrEJs998OqOzoVRf4HMsyz3JA+YlsmfkdB1R29KoLfI5lmWc5oPxEtsz8jgMq633kTNYDzLMcUH6iHejH1i+wne+2sXWHOaCyK3+2t8fOmfdja00q/CCaY6gu85lvGlG9q+cVRVF8PsdxB9aIjT8k7g9PAAAAAElFTkSuQmCC"),
      "Lion", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADEAAAAZCAYAAACYY8ZHAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAN1JREFUWEftjzEOwzAMA/O//n/vK7K2sCEHaiKSgpLBBXyAhpg8xd4Wi0XMa39/2tjnf1J9xFSPn+oyVdYjZmGWR9y6R1XOeKPjx6ILPvd9fw5JlQKUN3I0VjuIOuex6hVZADCvklWcA1kAME/tjLKKc6BkBPPUvshl+xo0VzICeZl9UUd5NFcyAnmZfVFHeTRXMoJ5al/ksn0NmisZwTy1M8oyDsyVjGBeJWNOg+YjzIwpnejM473zWOUHljVoPsLMmNKJzs54V/Vv5SPMjCmd6OwOat/T/1s8x7Z9AXGrhv+jRJzkAAAAAElFTkSuQmCC"),
      "Music", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAD4AAAAYCAYAAACiNE5vAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAASRJREFUWEftj10OwkAIhHs/7//uKXxVaaBBOsNCtFHT/RKSLvOz22UymZyPy+16l9Ejper7JIfeWS0/9BHf4PQ/nv1UxfN3VH4q81Ryevwt7HHskRVdP3dkmTgqvVDR4qg8ZhSs6Pq5A2Vsh0YtG2wv+FwcteR4Iwp19IhoUUc7BvNmHdXuF2MsRGf93EA7I+YFtGMwb6eDEgv8OdOM7AGidTOed/MpscQus9H1SjwLaGegDsO0bn6UKcOK0QXxLKCdgToQzMPylc4hrLh6YfYI1oNg3Z19i+6F+rmRPYD1IJCX5dleYPsdZeOTziNsjzQE8mZ509CoJadsfIK8/kI2al1Buo1aNthe8Dk/Ko/pmJnXX2zj96vJ4X3MI2TaZDIJLMsDBALefxQU5N8AAAAASUVORK5CYII="),
      "Ninja", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADgAAAAZCAYAAABkdu2NAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAARFJREFUWEftj0EOglAMRLmf9997CrfqkP6klM7wKWJAeUkT6JtBO1xcnIjb4/7E2GtKT+awbDmwp7uGT39vpH1UfXiXH/4W/kB2hHKHxx/HjlCOsTa/G/7Ps0PW7kHbt0ycMRRQDvi+H9M5PsQKa/egOTYWm6AciP34nhIDWSHbAbYHFac6CtmLMgtnO8D2oOJURyF7mYy7LAPYHlSc6ihkj0m/78lEKk51QPNsLDaFSb/vyUQqrqejxqJTlPTlLMP2oOIqHaBcV5Fl2B5U3FLHHmeonpZvms8yqltxSx17nKF6Wr5pPsuobsVVOkA5LQ2WUd2KUx3QPBuLTZHSkWVUt+JU5ye4Djw7f3GgPW5gGF7DP16uLG0rOgAAAABJRU5ErkJggg=="),
      "Shy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAC4AAAAcCAYAAAAeC42RAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAOZJREFUWEftkEEKwzAMBPO//v/eV/Ta4qINsmNpZSUpKfGAILCzssgymdyVx+v5bkcik4hzKu3BekTZwPLT8Q647OF7Hp+HZzjqcHzr+UoNXtZCXQjRhUD3rBG1wssA27GiRT0Sd/Ecb4fXAxFnBXI7Em/I5qxXiDgmKFsL2PJs18uGsBaxB7w8mw1hLWIPZHPWG6K3jD2QyVlnmMwjmZx1KphoLWOPsLygnYi/AtkrWHm2p4GjRyJOr9yOqBVeVmA5gBf1K9qyHlE27M0BvIh7COyx6DHwIu6l+MujC/PwX3KDv70sHz+ok39ACTgdAAAAAElFTkSuQmCC"),
      "Buoyant", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEUAAAARCAYAAACLkmHIAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAARFJREFUWEftkAsOwzAIQ3v/c+waO1s3IpMxZje06v59ElJkjEkyHSxwPs1zLMj/Tf6UWLD8LPKd6vHHpwh+/WN2+RQVovQRo5nc9z2x0OooPRMzHvwqgOk04MpIV31jrZ7JPt/FCpbGUk+GoH2H6jFd+XDsMM1Qeobtre5R3t5gBUunqld9BvMZSs+wPDarNKbL5WxAhWSdeRw1j2NDzZvOCu0G04w1XnkBoxqSdeZx1DyODTVfnVW+qpcucqohWWceZzS/ZRbHRsyKMF156SJDDSgt69VZxzNGHhw7WVMZSzqON9zMCpY7mM8Lls6oH6n4oicW2g2mGat0F2nzxeyxX73jE963ia+89DN5/4dM0wX5KAQpoLz79gAAAABJRU5ErkJggg=="),
      "Fuzzy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAGAAAAAaCAYAAABIIVmfAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAYlJREFUaEPtk1EOwyAMQ3v/c+waO9s2KjJlEQSHmLUfPKkqpbHjsO7Y3Jzn4/Xyrlq2ybIP9gbsg7+Q/eXfgP0DXMj+B1zMVYc/6ivv9Qdi7yioR9TXQ/ccwmxcYPjJAHLV7SaZflqb8bEguU/gwgAMP8llvfS+vLM1mpk6jafxgHW9xhkQv1GNvJd8o+sUNdDv9d2u9Z6lt+8Ba7zmsgebfeh5WSKeHmg/D2becB4RaGFrDwXVzHi3yHpE8talC+r3RQT6svtnIZmsbzZbVBvpF/LWxa11uYcMQbK+jExRD6Q+OxcFNGhd/p1VveXww/7MQGiAqaAfZnUsvN5TuVYMhPit6IvA6NvTT/myDyEyILv3P+jNl5qFeRC9gJZIT2a+LDKfzdTag5gSObD9mDCzWa/yPOU/LXRA/ZA6Rjb2fIXiKb4p/1Xh6rKLHmBEJuOK+QSZIdVjZcCCDql7oX2tRp5RvWB96vKHiGeplfqIrknaYEDLf3XPEbp/WUfziGZGuyGQO/jjeAOoVCXft/UFigAAAABJRU5ErkJggg=="),
      "Precise", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAD4AAAARCAYAAACFOx+nAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAANpJREFUWEftkNENwjAMRLv/HKzBbEWWzsh1fc41CD5SnmShnp+dhO3PXXk+9j0W4vXJD48FZU3YA2/7cGPpx199uGf2++0/hp2fC61rsEG21PPRXOcY2atcNauIe8uZLMSCcoDlRtVTs4rZWWnOgliIKZ1T9XKmnmMwbzRf9U+Zegmnu0xX0N4ePls6j+3xnBW0fnkF8+PyqqDRC1coXnZ8Pyto2vJI5yu7ThdomPWkOXW50/mzF2XMetKcutwZ+daPhfhE9iqXZbnQOjB02CDjqv8JvzxrcbbtBTgnGCCAzns2AAAAAElFTkSuQmCC"),
      "Spicy", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADEAAAAQCAYAAAC/bJePAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAALFJREFUSEvtjwEKhEAMA/f/77hv+DaPQpS6JmsDKyh3AwVJk3Rtf57I8lnXfrB6B697MOPnfuIub+YqR/chbgNJkr15sD4w0vvBaodpgdJ3cqlTMsPb43RKwuw8ouJVnQznzhB21ClnWZVnsDw+PapFTGdZlWewPD7rsKOqiOksq/KM7L/MKQPTq1rgeBXh3waSJptHIeaLwfrASO8HqxMVj41TNuvw1B8IphcW0Ddb+wIcIm+DuNHFxQAAAABJRU5ErkJggg=="),
      "Tadpole", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAAEMAAAAPCAYAAAC/UHJkAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAN5JREFUWEftkIsNwjAMRLv/HKzBbIWrrhal509IokrAkywR37NTsuzcb+vqFZXfQT3CXlSGMWOnYsg9sz/2/xgvfNVjIH8vRiWU37qjwpCdnyzxZtBXxdhQDorxiYoX9bNZIxUEasbbU3VnzLfcsxGGDi2X9Lg4e/PK5U+j2jPC8AlyVYwN1QM9rueBzMU5KmpH3ICovNoDPa7ngczFOSpqR9yAqLzaAz2u54GKG81LsoHqJd6eK+e9nS7ZAHJVjA8oD8XYUA6K8YmKF/WzWSMVJjDjziv+xxCu//BleQD5rEPzTtwCLwAAAABJRU5ErkJggg=="),
      "Vector", Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAADUAAAARCAYAAAB92+RQAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAAMxJREFUSEvtkAEOgzAIRXv/c+waO5srBhpH/4d2Zs00e0mjgcfHWv5cnedj2/T1Pqy4lOxY+vNud6lVi752KRS64lJ2ITtansLmugwUGC2xADta7vCed6OekPUF2vcFKCmoPlpDsF2n9/hgKlZGgn1eBHLZPHP1tefYZKKFsqMaXM5AbjQ747amPJloPXZUCzM8yI1mZ9wWHkqVrC+M5BjIjWZn3B20wJOGKKOegNwztTdESKWKeZnvPeay3nEO9QVWb6TCD3LFb/6QUl6G2tgE9Os35gAAAABJRU5ErkJggg=="),
   ), selection := []
   yOffset := GetYOffset(&fail)
   if fail
      return -1
   if (!selection.Length)
      for v in beeArr
         if config["mutation"][v "BeeCheck"]
            selection.Push(v)
   WinGetClientPos(&_x, &_y, &_w, &_h, "ahk_id" Roblox())
   WinActivate()
   click _x + Round(0.5 * _w + 10) " " _y + yOffset + Round(0.4 * _h + 230)
   Sleep(600 + config["settings"]["keyDelay"])
   pBitmapBee := Gdip_BitmapFromScreen(_x + _w // 2 - 200 "|" _y + yOffset + _h // 2 - 230 "|400|100")
   For k, v in selection {
      if Gdip_ImageSearch(pBitmapBee, ungifteds[v]) | Gdip_ImageSearch(pBitmapBee, gifteds[v]) {
         foundBee := k
         break
      }
   }
   Gdip_DisposeImage(pBitmapBee)
   if !IsSet(foundBee) || !foundBee
      return 0
   pBitmapMutate := Gdip_BitmapFromScreen(_x + Round(0.5 * _w - 320) "|" _y + yOffset + Round(0.4 * _h + 17) "|210|90")
   pBitmapMutateResize := Gdip_ResizeBitmap(pBitmapMutate, 420, 180), Gdip_DisposeImage(pBitmapMutate)
   hBM := Gdip_CreateHBITMAPFromBitmap(pBitmapMutateResize)
   Gdip_DisposeImage pBitmapMutateResize
   pIRandomAccessStream := HBitmapToRandomAccessStream(hBM)
   DeleteObject(hBM)
   ocrOut := ocr(pIRandomAccessStream, "en")
   neededMutation := StrSplit(config["mutation"]["mutation"], " ")[1]
   FileAppend("Bee: " foundBee "`r`nMutation: " Trim(ocrOut) "`r`nRequired: " neededMutation "`r`n`r`n", "settings\log.txt")
   if (inStr(ocrOut, neededMutation))
      return 1
   return 0
}
boost() {
   local last1 := A_TickCount, last2 := A_TickCount, last3 := A_TickCount, last4 := A_TickCount, last5 := A_TickCount, last6 := A_TickCount, last7 := A_TickCount
   loop
      loop 7
         if config["boost"]["keyDelay" A_Index] && config["boost"]["check" A_Index] && (A_TickCount - last%A_Index% >= config["boost"]["keyDelay" A_Index])
            Send(A_Index), last%A_Index% := A_TickCount
   sleep 10
}
SSA() {
   ssaConfig := config["ssa"]
   stats := {
      red: ssaConfig["redPollenCheck"],
      blue: ssaConfig["bluePollenCheck"],
      white: ssaConfig["whitePollenCheck"],
      gath: ssaConfig["beeGatherPollenCheck"],
      convert: ssaConfig["convertRateCheck"],
      ability: ssaConfig["beeAbilityRateCheck"],
      critical: ssaConfig["criticalChanceCheck"],
      instant: ssaConfig["instantConversionCheck"],
   }
   mainPassive := StrReplace(StrReplace(ssaConfig["mainPassive"], "star", ""), " ", "")
   sidePassives := {
      pop: ssaConfig["PopStarCheck"],
      scorching: ssaConfig["ScorchStarCheck"],
      Gummy: ssaConfig["GummyStarCheck"],
      Guiding: ssaConfig["GuidingStarCheck"],
      Saw: ssaConfig["StarSawCheck"],
      Shower: ssaConfig["StarShowerCheck"]
   }
   yOffset := GetYOffset(&fail)
   if fail
      return -1
   WinGetClientPos(&_x, &_y, &_w, &_h, "ahk_id" Roblox())
   if subHoney(config["settings"]["doublePassiveCheck"] * 500 || 10) < 0
      return -2
   send "e"
   Sleep(250)
   Click(_w // 2 + (config["settings"]["doublePassiveCheck"] ? -100 : 100), yOffset + _h // 2 + 30)
   MouseMove(_w // 2, _h // 2 + 150)
   Sleep(300 + config["settings"]["keyDelay"])
   pBitmap := Gdip_BitmapFromScreen(_x + _w // 2 + 20 "|" yOffset + _y + Round(0.4 * _h + 20) "|188|160")
   pBitmapResize := Gdip_ResizeBitmap(pBitmap, 376, 320), Gdip_DisposeImage(pBitmap)
   hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmapResize)
   Gdip_DisposeImage pBitmapResize
   pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
   DeleteObject(hBitmap)
   text := StrSplit(l := ocr(pIRandomAccessStream, "en"), "`n")
   FileAppend(l, "settings/log.txt")
   totalSidePassives := 0
   for i, j in sidePassives.OwnProps()
      totalSidePassives += j
   foundNum := 0, mainPassiveFound := 0, sidePassiveFound := !totalSidePassives
   for k, v in text {
      for i, j in stats.ownProps()
         if InStr(v, i) {
            foundNum += j
            break
         }
      if InStr(v, mainPassive) {
         mainPassiveFound := 1
         break
      }
      for i, j in sidePassives.OwnProps()
         if InStr(v, i)
            sidePassiveFound += j
   }
   requiredNum := 0
   for k, v in stats.OwnProps()
      requiredNum += v
   FileAppend("Found: " foundNum ", required: " requiredNum "`r`nmain passive? " (mainPassiveFound ? "Yes" : "No") ", Number of sidepassives found: " (sidePassiveFound = !totalSidePassives ? 0 : sidePassiveFound) "`r`n`r`n", "settings/log.txt")
   if (foundNum = requiredNum && mainPassiveFound && sidePassiveFound)
      return 1
   return 0
}
updateMutation(bee, control, *) {
   updateValue("mutation", bee "BeeCheck", !config["mutation"][bee "BeeCheck"])
   control.Value := "./Images/gui/bees/" bee (config["mutation"][bee "BeeCheck"] ? "BG" : "") ".png"
}
/**
 * @param {Number} amount 10 || 500
 */
subHoney(amount) {
   local out, unit
   if !config["settings"]["spendHoney"]
      return 1
   RegExMatch(config["settings"]["spendHoney"], "[\d\.]+", &out)
   RegexMatch(config["settings"]["spendHoney"], "i)(b|t|qd)", &unit)
   out := out[], unit := unit[]
   valueInB := toB(out, unit)
   if (amount = 10 && valueInB < 10) || (amount = 500 && valueInB < 500)
      return -2
   updateValue("settings", "spendHoney", toUnit(valueInB - amount, unit) unit)
   return 1
   toB(num, unit) =>
      num * (unit = "b" ? 1
         : unit = "t" ? 1000
            : unit = "qd" ? 1000000
               : 0)
   toUnit(num, unit) =>
      num / (unit = "b" ? 1
         : unit = "t" ? 1000
            : unit = "qd" ? 1000000
               : 1)
}

/**
 * @function GeyYOffset()
 * @param {VarRef} fail
 * @returns {Number} 
 * @author xspx
 * @url https://github.com/natroteam/natromacro
 */
GetYOffset(&fail?)
{
   static hRoblox := 0, offset := 0, topPollenBitmap := Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAACkAAAAKBAMAAADbdmpdAAAAFVBMVEUAAAASFRcTFhgUFxkUFxgWGRsXGht4cWVYAAAAAXRSTlMAQObYZgAAABd0RVh0U29mdHdhcmUAUGhvdG9EZW1vbiA5LjDNHNgxAAADWGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLycgeDp4bXB0az0nSW1hZ2U6OkV4aWZUb29sIDEyLjQ0Jz4KPHJkZjpSREYgeG1sbnM6cmRmPSdodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjJz4KCiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0nJwogIHhtbG5zOmV4aWY9J2h0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvJz4KICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+NDE8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogIDxleGlmOlBpeGVsWURpbWVuc2lvbj4xMDwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0nJwogIHhtbG5zOnRpZmY9J2h0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvJz4KICA8dGlmZjpJbWFnZUxlbmd0aD4xMDwvdGlmZjpJbWFnZUxlbmd0aD4KICA8dGlmZjpJbWFnZVdpZHRoPjQxPC90aWZmOkltYWdlV2lkdGg+CiAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogIDx0aWZmOlNvZnR3YXJlPlBob3RvRGVtb24gOS4wPC90aWZmOlNvZnR3YXJlPgogIDx0aWZmOlhSZXNvbHV0aW9uPjk2LzE8L3RpZmY6WFJlc29sdXRpb24+CiAgPHRpZmY6WVJlc29sdXRpb24+OTYvMTwvdGlmZjpZUmVzb2x1dGlvbj4KIDwvcmRmOkRlc2NyaXB0aW9uPgo8L3JkZjpSREY+CjwveDp4bXBtZXRhPgo8P3hwYWNrZXQgZW5kPSdyJz8+BUybogAAAEZJREFUeNqFzcEJgEAQA8A5Ud8bbMj+qxLxPHwosq8dSCIJUBqM50vXN21J14SkJNvpl85UP6LVHfrT0TBh6HNtH2oBgFIHi0UEEPtLIT4AAAAASUVORK5CYII="), topPollenFill := Gdip_CreateBitmap(41, 10)
   pGraphics := Gdip_GraphicsFromImage(toppollenfill), Gdip_GraphicsClear(pGraphics, 0xff121517), Gdip_DeleteGraphics(pGraphics) ;Bitmap from SP
   if (hwnd := Roblox()) = 0
      return fail := 1
   if (hwnd = hRoblox)
   {
      fail := 0
      return offset
   }
   else if WinExist("ahk_id " hwnd)
   {
      try WinActivate "Roblox"
      WinGetClientPos(&windowX, &windowY, &windowWidth, &windowHeight, "ahk_id" Roblox())
      pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 "|" windowY "|60|100")

      Loop 20 ; for red vignette effect
      {
         if ((Gdip_ImageSearch(pBMScreen, topPollenBitmap, &pos, , , , , 20) = 1)
            && (Gdip_ImageSearch(pBMScreen, topPollenFill, unset, x := SubStr(pos, 1, (comma := InStr(pos, ",")) - 1), y := SubStr(pos, comma + 1), x + 41, y + 10, 20) = 0))
         {
            Gdip_DisposeImage(pBMScreen)
            hRoblox := hwnd, fail := 0
            return offset := y - 14
         }
         else
         {
            if (A_Index = 20)
            {
               Gdip_DisposeImage(pBMScreen), fail := 1
               return 0 ; default offset, change this if needed
            }
            else
            {
               Sleep 50
               Gdip_DisposeImage(pBMScreen)
               pBMScreen := Gdip_BitmapFromScreen(windowX + windowWidth // 2 "|" windowY "|60|100")
            }
         }
      }
   }
   else
      return 0
}

postFoundToWebhook() {
   if !config["settings"]["webhookCheck"] || !config["settings"]["webhookURL"]
      return -1
   embed := EmbedBuilder()
   embed.setTitle("Found your selection!")
   embed.setColor(0xFEC6DF)
   embed.setTimeStamp()
   pBitmap := Gdip_BitmapFromScreen()
   Gdip_SaveBitmapToFile(pBitmap, "ss.png")
   Gdip_DisposeImage(pBitmap)
   attachment := AttachmentBuilder("ss.png")
   embed.setImage({ url: attachment.attachmentName })
   webhook.send({
      embeds: [embed],
      files: [attachment]
   })
   FileDelete("ss.png")
}

#include DiscordBuilder.ahk
#Include Gdip_All2.ahk
#Include Gdip_ImageSearch2.ahk
#include ocr2.ahk
#include JSON.ahk