// Application variables
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
#define APP_ID        "55EA9482-ECB1-439D-951C-798B8CC2D68D"
#define APP_Name      "Might & Magic Heroes 5.6"
#define APP_StartName "Might & Magic - Heroes 5.6"
#define APP_Version   "RC19f"
#define APP_Publisher "MMH55 team"
#define APP_URL       "https://www.moddb.com/mods/might-magic-heroes-55"
#define APP_Support   "https://discord.gg/khKPUrKxC4"
#define APP_SetupName "MMH55_" + APP_Version
#define APP_Language  "English"

// Files to check for previous installation
#define APP_CHECK1    "bin\H5_AIProcess_31j.exe"
#define APP_CHECK2    "bin\MMH55_64.exe"
#define APP_CHECK3    "data\MMH55-Stats.pak"