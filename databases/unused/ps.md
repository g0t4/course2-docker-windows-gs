# process commands

From exploration of namespaces/containers.

```bash
ps -AH -o ppid,pid,args

-ww # if output cut off, wrap instead

wsl --system -d docker-desktop

watch -d -n0.5 'ps -AH -ww -o pid,ppid,ipcns,mntns,netns,pidns,userns,utsns,args | grep  -v grep |  grep  4026532700'

```
