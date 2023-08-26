:: Assume you have Rust and git installed

:: We use chocolatey for installing clang and prereqs
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install llvm -y
choco install ripgrep -y

:: Install Hack Nerd Font for support with neovim
choco install nerd-fonts-hack -y
:: Alternatively, 
:: git clone git@github.com:ryanoasis/nerd-fonts.git
:: ./nerd-fonts/install.sh Hack
:: rm -rf ./nerd-fonts

