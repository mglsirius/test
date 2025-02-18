:: Perform a Windows build.
:: Be sure to switch venv first!
call build-integration-helper-pyinstaller.bat

.\venv\Scripts\pip install pyinstaller
.\venv\Scripts\pyinstaller.exe pcleaner/main.py --paths 'venv/Lib/site-packages' ^
    --onedir --noconfirm --clean --workpath=build --distpath=dist_exe --windowed ^
    --name="PanelCleaner" --icon=pcleaner/data/custom_icons/logo.ico ^
    --copy-metadata filelock ^
    --copy-metadata huggingface-hub ^
    --copy-metadata numpy ^
    --copy-metadata packaging ^
    --copy-metadata pyyaml ^
    --copy-metadata regex ^
    --copy-metadata requests ^
    --copy-metadata safetensors ^
    --copy-metadata tokenizers ^
    --copy-metadata tqdm ^
    --copy-metadata torch ^
    --collect-data torch ^
    --collect-data unidic_lite ^
    --hidden-import=scipy.signal ^
    --add-data "dist_exe/WindowsExplorerIntegrationRegedit.exe;pcleaner/data/" ^
    --add-data "venv/Lib/site-packages/manga_ocr/assets/example.jpg;assets/" ^
    --collect-datas pcleaner

Copy "docs\What is _internal.txt" "dist_exe/PanelCleaner\What is _internal.txt"
xcopy "pcleaner\data" "dist_exe\PanelCleaner\_internal\pcleaner\data" /E /I /Y
cd "dist_exe\PanelCleaner\_internal\pcleaner\data"
for /d /r . %%d in (__pycache__) do @rmdir /s /q "%%d"
