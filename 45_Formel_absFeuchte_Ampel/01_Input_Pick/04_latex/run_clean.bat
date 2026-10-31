@echo off
del *.aux >nul 2>&1
del *.log >nul 2>&1
del *.out >nul 2>&1
del *.toc >nul 2>&1
del *.bbl >nul 2>&1
del *.blg >nul 2>&1
del *.bcf >nul 2>&1
del *.run.xml >nul 2>&1
del *.minted >nul 2>&1

if exist _minted rmdir /s /q _minted >nul 2>&1
