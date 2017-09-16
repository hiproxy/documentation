title: Introduction
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Type of configuration file

Hiproxy can use *hosts* to make simple request proxy. And `rewrite` can be used for complex configuration rules which use similar syntax of Nginx.

### hosts

It has same syntax as `hosts` of OS. As additinal, it supports configurating port number. You can only configure host with corresponding IP and port in *hosts*. It does not support detailed routing and modification to request/response. Read [hosts](../configuration/hosts.html) for more.

### Example for hosts

```bash
# comment
127.0.0.1 example.com

# ip + port
127.0.0.1:8800 blog.example.com life.example.com
```

### rewrite

You can make complex configuration in *rewrite* in some complex situation. That includes detailed routing, and modification to request/response. The syntax of *rewirte* configuration is very similar to that of Nginx. Read [rewrite](../configuration/rewrite.html) for more.

### Example for rewrite

```bash
# global variables
set $port 8899;
set $ip   127.0.0.1;
set $online 210.0.0.0;

# domain name configuration
domain example.com {
  location / {
    proxy_pass http://$online/;
  }

  location /blog/ {
    proxy_pass http://$ip:$port/blog/;
    proxy_set_header from 'hiproxy';
    set_header proxy 'hiproxy';
  }
}
```

## Configuration file location

hiproxy recommends you place configuration files in the particular **project root directory** (*hosts* file named `hosts` and *rewrite* file named `rewrite`). Projects are placed in workspace so that the hierarchy structure is line below:

```bash
workspace
  ├── app-1 # Project1
  │   ├── hosts   # hosts file
  │   ├── rewrite # rewrite file
  │   └── src     # codes
  │   └── ...     # other files
  │
  ├── app-2 # Project2
  │   ├── hosts   # hosts file
  │   ├── rewrite # rewrite file
  │   └── src     # codes
  │   └── ...     # other files
  │
  └── app-3 # Project3
      ├── hosts   # hosts file
      ├── rewrite # rewrite file
      └── src     # codes
      └── ...     # other files
```

The benifit is that these configuration files can be commit to code repository for sharing with team members, and cost saving. Furthermore, hiproxy can find the files by itself.

## Finding configuration files

If you follow the rules above to place the files (with their special names), and hiproxy use `workspace` directory as workspace, it can find the configuration files of the three projects without spcifying by manual.

If you do NOT follow the rules, place the files to different directory or not use default names (`hosts` for *hosts* file and `rewrite` for *rewrite* file), you have to specify the files while hiproxy starts.

Read [Find Configuration File](./find_conf.html) for more.


## Update configuration files

Hiproxy support two proxy methods: [PAC(Proxy-Auto-Config)](https://en.wikipedia.org/wiki/Proxy_auto-config) and general proxy.

General proxy method is default one. You can use `--pac-proxy` for swithing to PAC while starting.

The Deifferent proxy methods deal updating configuration file in different way.

If it's running in general proxy mode and the configuration file was updated. You can just refresh the browsing page to make it valid.

But if it's running in PAC proxy mode, and one or more new domain ware added. You should refresh the browser's proxy file by manual since the `.pac` file is not updated immediately. If you want detail, you can visit <chrome://net-internals/#proxy> then click `Re-apply settings`.

## Merge proxy rules

The rules in all configuration files should be merged into a bit rules tree. That is, after configuring the proxy, all the rules in the configuration files are equal at the time the request is processing. **The rules in different domain would not affect each other. The rules in the same domain should be merged and later rule should overwrite previous one if they are same route.**

For example, there are two configuration files, `workspace/blog/rewrite` and `workspace/docs/rewrite`. Their content are below:

```bash
# workspace/blog/rewrite

domain hiproxy.org {
  location /blog/ {
    proxy_pass http://127.0.0.1:8000/;
  }
}

domain blog.hiproxy.org {
  location / {
    proxy_pass http://127.0.0.1:8000/;
  }
}
```

```bash
# workspace/docs/rewrite

domain hiproxy.org {
  location /docs/ {
    proxy_pass http://127.0.0.1:9000/;
  }
}
```

After merging:

```bash
# merged rules

domain hiproxy.org {
  location /blog/ {
    proxy_pass http://127.0.0.1:8000/;
  }
}

domain hiproxy.org {
  location /docs/ {
    proxy_pass http://127.0.0.1:9000/;
  }
}

domain blog.hiproxy.org {
  location / {
    proxy_pass http://127.0.0.1:8000/;
  }
}
```

