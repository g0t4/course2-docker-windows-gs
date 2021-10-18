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





###################################################################
## the rest of these are just examples
## NOT MEANT TO BE PRECISE - just a few text mining exercises:
###################################################################
# greps are broken out by line to be easier to remove
# -v = not matching
# remove -c on `uniq -c` if you don't want count
#
# usage:
# tags_for_osversions windows.nanoserver.tags.txt

# known issues
# preview tag for win10 
# _ vs - in revision KB tags

function tags_for_ltscs_all_image_txts(){
    # searches all .tags.txt files
    cat *.tags.txt | grep ltsc | sort | uniq
}

function tags_for_osversions(){
  image_txt=$1
  grep '^10\.' $image_txt \
    | cut -d '.' -f1-3 \
    | sort | uniq -c
}

function tags_for_builds(){
    image_txt=$1
    cat $image_txt \
        | grep -v '^10\.' $image_txt \
        | grep -v '[-_]amd64' \
        | grep -v '[-_]arm' \
        | grep -v '[-_]' \
        | sort | uniq
}

function tags_for_revisions(){
    image_txt=$1
    cat $image_txt \
        | grep -v '^10\.' $image_txt \
        | grep -v '[-_]amd64' \
        | grep -v '[-_]arm' \
        | grep '[-_]KB' \
        | sort | uniq
}