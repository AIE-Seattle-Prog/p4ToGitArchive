@echo off

REM Currently tested w/ HTTPS authentication
REM Uncomment this line to temporarily prefer this
REM git config hub.protocol https

for /F "delims=" %%i in (target.txt) do (
    echo ==================MIGRATING %%i=======================

    REM Clone the project
    git p4 clone //%%i/@all

    REM Move to the project folder (pushd)
    pushd %%i

    REM Print LFS stats
    git lfs migrate info

    REM Migrate the project to LFS
    git lfs migrate import --everything --include="*.jpg, *.jpeg, *.png, *.gif, *.psd, *.ai, *.tiff, *.tif, *.bmp, *.mp3, *.wav, *.ogg, *.aac, *.mp4, *.mov, *.mkv, *.FBX, *.fbx, *.blend, *.obj, *.mb, *.ma, *.a, *.exr, *.tga, *.pdf, *.zip, *.dll, *.aif, *.ttf, *.rns, *.reason, *.lxo, *.unity, *.asset, *.unitypackage, *.shadergraph"

    REM Create the repo on GitHub
    REM Replace 'AIE-Seattle-Prog' with the org/user you are creating repos in
    hub create AIE-Seattle-Prog/%%i

    REM Push the project to GitHub
    git push origin master

    REM Popd back to the original folder
    popd
)
