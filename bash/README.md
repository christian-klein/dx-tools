### Add to .bashrc:

```
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
```

### Use .multialrc:
```
multitail -cS wps_log /mnt/dx-core-1/logs/WebSphere_Portal/SystemOut.log
```
If using alias file the -cS wps_log is added automatically.

Viewing all logs in one file:
```
$ multitail --mergeall *.log
```
Viewing all merged logs in different colors (except for api*.log) in one window:
```
$ multitail --mergeall -c- -Iw 'api-*.log' 10 -C -Iw 'laravel-*.log' 10 -Iw '/var/log/nginx/*log' 1000 -Iw '/var/log/redis/*.log' 1000 -cs -Iw '/var/l
```