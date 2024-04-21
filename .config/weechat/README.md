# Weechat configuration

`config.conf` doesn't contain the configuration itself, but rather the `/set` commands to set the corresponding WeeChat configuration options. Hence, `config.conf` will not apply by simply copying this folder to the WeeChat config folder; see next section on how to apply this config to your WeeChat install.

## How to use

Run the following command in the WeeChat client:
```
/exec -sh -oc cat config.conf
```
