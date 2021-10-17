#!/usr/bin/env bash

function mcr_repo_ls() {
    curl --silent -L \
        "https://mcr.microsoft.com/v2/_catalog"
}
function mcr_repo_ls_txt(){
    mcr_repo_ls \
        | jq -r ".repositories[]" \
        | sort
}


function mcr_tag_ls() {
    image=$1
    curl --silent -L \
        "https://mcr.microsoft.com/v2/${image}/tags/list"
}
function mcr_tag_ls_txt() {
    mcr_tag_ls "$1" \
        | jq -r ".tags[]" \
        | sort
}


mcr_repo_ls_txt > repos.txt

mcr_tag_ls_txt windows > windows.tags.txt 
mcr_tag_ls_txt windows/nanoserver > windows.nanoserver.tags.txt 
mcr_tag_ls_txt windows/server > windows.server.tags.txt 
mcr_tag_ls_txt windows/servercore > windows.servercore.tags.txt 

