#!/usr/bin/env bash

source ./mcr-cli.sh

mcr_repo_ls_txt > repos.txt

# base images (windows)
mcr_tag_ls_txt windows > windows.tags.txt 
mcr_tag_ls_txt windows/nanoserver > windows.nanoserver.tags.txt 
mcr_tag_ls_txt windows/server > windows.server.tags.txt 
mcr_tag_ls_txt windows/servercore > windows.servercore.tags.txt 

# fwk images (in decreasing order of dependence on each other)
mcr_tag_ls_txt dotnet/sdk > dotnet.sdk.tags.txt 
mcr_tag_ls_txt dotnet/aspnet > dotnet.aspnet.tags.txt 
mcr_tag_ls_txt dotnet/runtime > dotnet.runtime.tags.txt 
# runtime-deps provides basic dependencies to the runtime (listed to show relationships and to show tag differences)
mcr_tag_ls_txt dotnet/runtime-deps > dotnet.runtime-deps.tags.txt 

# app images
mcr_tag_ls_txt mssql/server > mssql.server.tags.txt 
# https://hub.docker.com/_/microsoft-windows-servercore-iis
# teaser about this iis image: https://techcommunity.microsoft.com/t5/containers/contain-your-excitement-updates-on-windows-server-2022-and/ba-p/2820015
mcr_tag_ls_txt windows/servercore/iis > iis.tags.txt 
