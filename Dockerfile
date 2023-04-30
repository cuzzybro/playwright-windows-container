FROM mcr.microsoft.com/windows:1809

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='SilentlyContinue';"]

RUN Invoke-WebRequest -OutFile nodejs.zip -UseBasicParsing "https://nodejs.org/dist/latest-v18.x/node-v18.16.0-win-x64.zip";
RUN Expand-Archive nodejs.zip -DestinationPath C:\Tools;
RUN rm nodejs.zip;
RUN Rename-Item "C:\Tools\node-v18.16.0-win-x64" c:\Tools\nodejs;
RUN Invoke-WebRequest -OutFile vim.zip -UseBasicParsing "https://github.com/vim/vim-win32-installer/releases/download/v9.0.1494/gvim_9.0.1494_x64.zip";
RUN Expand-Archive vim.zip -DestinationPath C:\Tools;
RUN rm vim.zip;
RUN Rename-Item "C:\Tools\vim\vim90" c:\Tools\vim\vim;
RUN [Environment]::SetEnvironmentVariable('PATH', ([Environment]::GetEnvironmentVariable('PATH', 'USER') + ';C:\\Tools\\nodejs;c:\\Tools\\vim\\vim\\'), 'USER')
# Uncomment to include nano via chocolatey
# RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# RUN choco install nano -Y

WORKDIR /automation

ADD . .

RUN npm i
RUN npx playwright install