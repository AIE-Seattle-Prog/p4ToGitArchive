@echo off

for /F "delims=" %%i in (target.txt) do (
    echo ==================DELETING %%i=======================

    p4 snap //... //%%i/...
    p4 changes -s shelved //%%i/...
    p4 obliterate -y //%%i/...
    p4 depot -d -f %%i
)
