REM    Copyright 2014 Steve Francia
REM 
REM    Licensed under the Apache License, Version 2.0 (the "License");
REM    you may not use this file except in compliance with the License.
REM    You may obtain a copy of the License at
REM 
REM        http://www.apache.org/licenses/LICENSE-2.0
REM 
REM    Unless required by applicable law or agreed to in writing, software
REM    distributed under the License is distributed on an "AS IS" BASIS,
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM    See the License for the specific language governing permissions and
REM    limitations under the License.


@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\Dvim
IF NOT EXIST "%APP_PATH%" (
    call git clone -b 3.0 https://github.com/manjuist/Dvim.git "%APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating Dvim
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.vimrc" "%APP_PATH%\vimrc"
call mklink "%HOME%\.vimrc.bundles" "%APP_PATH%\vimrc.bundles"
call mklink /J "%HOME%\.vim" "%APP_PATH%\"

IF NOT EXIST "%APP_PATH%\.vim\bundle" (
    call mkdir "%APP_PATH%\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/Vundle.vim" (
    call git clone https://github.com/VundleVim/Vundle.vim.git "%HOME%/.vim/bundle/Vundle.vim"
) ELSE (
  call cd "%HOME%/.vim/bundle/Vundle.vim"
  call git pull
  call cd %HOME%
)

call vim +BundleInstall! +BundleClean +qall
