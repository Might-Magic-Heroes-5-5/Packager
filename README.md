# Mod Packager

Made to provide easy to use packaging cappabilities for Heroes V mods.
Any contributions to this project are appreciated!

## Prerequisites
1. Install latest stable [Inno Setup](https://jrsoftware.org/isdl.php#stable)
2. Download this repository

## Configuration
![image](https://github.com/user-attachments/assets/86e33957-db00-441e-a3d8-7ee53ebb145f)

### Files 
Place your mod files in a folder called **files** in the main directory. This is what the packager will made the installer from.

### Details
Double click config/variables.iss to open it with Inno Setup editor.
```
// Application variables
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
#define M55_ID        "55EA9482-ECB1-439D-951C-798B8CC2D68D"                   ## Generate unique ID that will represent your mod. It must always be the same.
#define M55_Name      "Might & Magic Heroes 5.5"                               ## Full name of your mod
#define M55_StartName "Might & Magic - Heroes 5.5"                             ## Name of the Windows StartGroup folder that will hold mod shortcuts
#define M55_Version   "RC19f"                                                  ## Version of your mod
#define M55_Publisher "MMH55 team"                                             ## The author of the mod
#define M55_URL       "https://www.moddb.com/mods/might-magic-heroes-55"       ## (Optional) Website of your mod
#define M55_Support   "https://discord.gg/khKPUrKxC4"                          ## (Optional) Support link/discord or other link for your mod.
#define M55_SetupName "MMH55_" + M55_Version                                   ## File name of installer the builder will create.

// Files to check for previous installation                                    ## (Optional) if not set to empty string, the installer will scan
#define M55_CHECK1    "bin\H5_AIProcess_31j.exe"                               ## the target directory for those files and if found will cancel the installation.
#define M55_CHECK2    "bin\MMH55_64.exe"                                       ## Use those to prevent the user to create installations on top of already existing ones.
#define M55_CHECK3    "data\MMH55-Stats.pak"
```

### Shortcuts
Double click config/icons.iss to open it with Inno Setup editor.
To add desktop shortcuts use the example below:
```
Name: "{autodesktop}\Main Mod executable";    Filename: "{app}\path\to\executable.exe";
```
To add Windows StartGroup shortcuts use the example below:
```
Name: "{group}\MMH5.5 Play";                   Filename: "{app}\bin\MMH55.exe"
```

Full example
```
[Icons]
// Desktop icons
Name: "{autodesktop}\MMH5.5 (64bit)";          Filename: "{app}\bin\MMH55_64.exe";
Name: "{autodesktop}\MMH5.5 Editor (64bit)";   Filename: "{app}\bin\MMH55_Editor_64.exe";
// StartMenu icons
Name: "{group}\MMH5.5 Play";                   Filename: "{app}\bin\MMH55.exe"
Name: "{group}\MMH5.5 Play (64bit)";           Filename: "{app}\bin\MMH55_64.exe"
Name: "{group}\MMH5.5 Utility (ARMG)";         Filename: "{app}\bin\MMH55_Utility.exe"
Name: "{group}\MMH5.5 Utility (64bit) (ARMG)"; Filename: "{app}\bin\MMH55_Utility_64.exe"
Name: "{group}\MMH5.5 Editor (ARMG)";          Filename: "{app}\bin\MMH55_Editor.exe"
Name: "{group}\MMH5.5 Editor (64bit) (ARMG)";  Filename: "{app}\bin\MMH55_Editor_64.exe"
Name: "{group}\MMH5.5 Uninstall";              Filename: "{app}\unins000.exe"
```
### Wizard texts
To customize the text information provided by the wizard customize the files in config/text folder.

- information.txt is in control of the text provided on information page
- Messages.txt is more of a master control file for the whole wizard. The user has control over the fonts, their sizes as well as the content of some of Inno Setup predefined messages.

### Wizard images
Go to config/images folder and change the 3 images to one that repesent your mod in the best light.
- setup_file.ico - this is the icon for the intallation wizard. Must be an ICO file
- side.bmp - appears on the left side of the window during wizard launch. Must be a BMP file. Image Width/Height ratio: 2:3.
- top_right.bmp - appears on the top right side of all wizard pages after the first. Image Width/Height ratio: 1:1.

## Build and use the installer
Double click on main.iss and select build. Once the build process completes an executable will be created in the output directory. Use it to install your mod

![image](https://github.com/user-attachments/assets/647886d4-937b-47ff-a3d3-97d9da31f623)

## List of installer cappabilities
### Autodetect install folder 
Will detect Tribes of the East directory for ISO, GOG and Steam sources.

### Silent install
Can auto install your mod by running the following  command from CLI
```
MMH55_RC19.exe /VERYSILENT /SUPPRESSMSGBOXES
```
Install directory can be provided if necessary
```
.\MMH55_RC19f.exe /VERYSILENT /SUPPRESSMSGBOXES /DIR="D:/Games/my-toe-directory"
```
It can also be uninstalled silently
```
.\unins000.exe /VERYSILENT
```
