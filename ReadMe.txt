
##### AutoIt3 Script Starter

The problem is described in the article "AutoIt and Malware"
https://www.autoitscript.com/wiki/AutoIt_and_Malware

Use the AutoIt3-Script-Starter to avoid false virus positives.


### Usage Option 1

<Folder tree>
│
│   Starter.exe
│
└───AutoIt
        AutoIt3.exe
        AutoIt3_x64.exe
        Starter.a3x
        Starter.au3

AutoIt and script files should be located in a folder named AutoIt.

The Starter-file and the Script-file must have the same name (any name).


### Usage Option 2

<Folder tree>
│
│   Starter.exe
│   Starter.ini
│
├───AutoIt_Scripts
│       Script.a3x
│       Script.au3
│
└───AutoIt_v3.3.16.1
        AutoIt3.exe
        AutoIt3_x64.exe

<Starter.ini>
│
[Starter]
AutoItPath=AutoIt_v3.3.16.1\
ScriptPath=AutoIt_Scripts\Script.au3

The Starter-file and the INI-file must have the same name (any name).
If the folder path is specified, a trailing backslash is required.


### Priorities

64-bit-Starter will prefer AutoIt3_x64.exe, unless otherwise specified in the INI file.
Starter will prefer compiled .a3x, unless otherwise specified in the INI file.
