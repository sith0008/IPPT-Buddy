@echo off
rem This file was created by pub v2.1.0-dev.5.0.flutter-a2eb050044.
rem Package: dartdoc
rem Version: 0.24.1
rem Executable: dartdoc
rem Script: dartdoc
dart "C:\src\flutter\.pub-cache\global_packages\dartdoc\bin\dartdoc.dart.snapshot.dart2" %*

rem The VM exits with code 253 if the snapshot version is out-of-date.
rem If it is, we need to delete it and run "pub global" manually.
if not errorlevel 253 (
  exit /b %errorlevel%
)

pub global run dartdoc:dartdoc %*
