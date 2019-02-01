# PowerDoc

PowerShell Module to build function and class documentation.

## About

This project was made to make it easier for PowerShell Developers to be able to build class and function documentation easier.  My goal was to add PowerDoc to the build process to document the code for public use.

## Install

You can install this module from the PSGallery. Install-Module PowerDoc

You can also download a copy of the source and either save it in your project folder, User Profile or System wide modules folder

## How to use

Generate a new file that you will use to build your docs.  You can referance my [Run-Build.ps1](https://github.com/luther38/PowerDoc/blob/master/Run-Build.ps1) for more information on how I use this module.
Import-Module PowerDoc

## Documentation Result

Currently PowerDoc as of v1.0.0 supports processing of PowerShell .ps1 files.  For Functions it will extract the documentation that is provided in the Help block.  Get-Help is what it would extract.  This has a custom extractor that will pick through the files for you.  

### Functions

Funtions will pull information from the Get-Help command and expose it in the files.  Write it once as your are working on your function and PowerDoc will convert that into documntation for GitHub or on a project site with HTML files.

[Basic Example]

PowerDoc is an example of what type of files you would be able to request.  Currently .md and .html files are generated.  This only documents the classes and functions though, if you have more you want to add you will need to adjust your files.

### Classes

Classes with PowerShell do not get picked up by the Get-Help Command.  PowerDoc will extract information on the Help Block like it would for a function.  It will also take a look at the class file and pull out the following.  ClassName, BaseClasses, COnstructors, Properties, and methods.

If a Method or Property are flagged as hidden it will be ignored for documentation.

## Exports

Currently you can pick from Markdown or HTML.

## Export Examples

[Start-PowerDoc.md](https://github.com/luther38/PowerDoc/blob/master/Docs/Public/Start-PowerDoc.md)

[Start-PowerDoc.html](https://github.com/luther38/PowerDoc/blob/master/Docs/Public/Start-PowerDoc.html)

