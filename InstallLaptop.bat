@echo off
setlocal enableextensions 

cd C:\Users\User\Desktop\Install-Laptop

echo Setting ExecutionPolicy to Bypass..
PowerShell.exe -Command "& Set-ExecutionPolicy -Scope CurrentUser Bypass" ;

echo Default option is "Y", press "Enter" to continue.
set choice=Y
set /p choice="Do you want to run the Debloat script? (Y/n): "
if /I "%choice%" EQU "Y" (
	PowerShell.exe -Command ".\Scripts\Win11Debloat-master\Win11Debloat.ps1"
	)
if /I "%choice%" NEQ "Y" (
    echo Proceeding..
	)

echo Default option is "Y", press "Enter" to continue.
set choice=Y
set /p choice="Do you want to run the pre-install script? (Y/n): "
if /I "%choice%" EQU "Y" ( 
	PowerShell.exe -Command ".\Base\PreInstall.ps1"
	)
if /I "%choice%" NEQ "Y" (
	echo Skipping script..
	)

echo Default option is "Y", press "Enter" to continue.
set choice=Y
set /p choice="Do you want to run the standard install script? (Y/n): "
if /I "%choice%" EQU "Y" (
	cd C:\Users\User\Desktop\Install-Laptop\Standard
	PowerShell.exe -Command ".\InstallStd.ps1"
	)
if /I "%choice%" NEQ "Y" (
	echo Skipping script..
	)

echo Default option is "N", press "Enter" to continue.
set choice=N
set /p choice="Do you want to install the SynchroNet Apps? (y/N): "
if /I "%choice%" EQU "Y" (
	cd C:\Users\User\Desktop\Install-Laptop\SynchroNet
	PowerShell.exe -Command ".\InstallSynchro.ps1"
	)
if /I "%choice%" NEQ "Y" (
	echo Skipping script..
	)

echo Default option is "N", press "Enter" to continue.
set choice=N	
set /p choice="Do you want to run the post-install script? (y/N): "
if /I "%choice%" EQU "Y" (
	cd C:\Users\User\Desktop\Install-Laptop\Base
	PowerShell.exe -Command ".\PostInstall.ps1"
	)
if /I "%choice%" NEQ "Y" (
	echo Skipping script..
	)
	
echo Scripts finished..

echo Setting ExecutionPolicy to AllSigned..
PowerShell.exe -Command "& Set-ExecutionPolicy -Scope CurrentUser AllSigned" ;
