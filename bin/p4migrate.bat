@echo off

REM Currently tested w/ HTTPS authentication
REM Uncomment this line to temporarily prefer this
REM git config hub.protocol https

for /F "delims=" %%i in (target.txt) do (
    echo ==================MIGRATING %%i=======================

    git init .\%%i\

    REM Move to the project folder (pushd)
    pushd %%i

    REM Clone the project
    git p4 clone //%%i/@all .

    REM Print LFS stats
    git lfs migrate info

    REM Migrate the project to LFS
    git lfs migrate import --everything --include="*.jpg, *.jpeg, *.png, *.gif, *.psd, *.ai, *.tiff, *.tif, *.bmp, *.mp3, *.wav, *.ogg, *.aac, *.mp4, *.mov, *.mkv, *.avi, *.FBX, *.fbx, *.blend, *.obj, *.mb, *.ma, *.a, *.exr, *.tga, *.tex, *.pdf, *.zip, *.dll, *.aif, *.ttf, *.rns, *.reason, *.lxo, *.abc, *.unity, *.asset, *.unitypackage, *.shadergraph"

    REM Create the repo on GitHub

    REM Set '%GIT_ARCHIVE_ACCOUNT%' with the org/user you are creating repos in
    REM (e.g., AIE-Seattle-Prog)
    gh repo create %GIT_ARCHIVE_ACCOUNT%/%%i --disable-issues --disable-wiki --private --remote origin --source .

    REM Set '%GIT_ARCHIVE_TAGS%' with a comma-separated list of topic tags
    REM (e.g., perforce-archive,production)
    gh repo edit %GIT_ARCHIVE_ACCOUNT%/%%i --add-topic %GIT_ARCHIVE_TAGS%

    REM Push the project to GitHub
    git push origin master

    gh repo archive -y

    REM Popd back to the original folder
    popd

    rmdir /s /q %%i
)
