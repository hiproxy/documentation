title: Applied to existing projects
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Global install hiproxy

If you haven't installed [hiproxy](https://github.com/hiproxy/hiproxy)，check [Installation](./installation.html).

All you have to do is to global install `hiproxy`, **Local install is NOT necessary**

## Add configuration files

Two rules of 'hiproxy':

* All projects in one Workspace;
* Put configuration files (hosts / rewrite) into specific project directory, submit them to the repository for version control and teamwork.

Therefore, all configuration files should be located in specific project directory. In terms of different projects, diverse configuration files can be added. While the 'hiproxy' on starting, those files will be found from workspace.

Recommended directory structure is as follows:

```
workspace
  ├── app-1 # Proj.1
  │   ├── hosts   # hosts file
  │   ├── rewrite # rewrite file
  │   └── src     # Source code
  │   └── ...     # other files
  │
  ├── app-2 # Proj.2
  │   ├── hosts   # hosts file
  │   ├── rewrite # rewrite file
  │   └── src     # Source code
  │   └── ...     # other files
  │
  └── app-3 # Proj.3
  │   ├── hosts   # hosts file
  │   ├── rewrite # rewrite file
  │   └── src     # Source code
  │   └── ...     # other files
```

Of course, to put all configuration files outside of the project directory, just specify the file's path via the start options:

```
-c, --hosts-file <files>   hosts files, format: <file1>[,<file2>[,...]]
-r, --rewrite-file <files> rewrite config files, format: <file1>[,<file2>[,...]]
```

> **TIPS**：
>
> * `-c, --hosts-file` and `-r, --rewrite-file` support **Simplified pattern matching**; e.g. `./*/*.conf`;
> * Supported syntax：`*`, `?`, `[abc]`, `[a-z]`, `[^a-z]`, `[!a-z]`;
> * Unsupported syntax：`**`.

### hosts

[hosts](../configuration/hosts.html) is similar to hosts, except it's located in the project directory, hiproxy will automatically find and resolve the hosts file named 'hosts' from the root directory of the project.

If the file name isn't `hosts`, just specify it via option `-c, --hosts-file`

### rewrite

[rewrite](../configuration/rewrite.html) is similar to `hosts`, it's also located in the project directory, hiproxy will automatically find and resolve the file named 'rewrite' from the root directory of the project.

If the file name isn't `rewrite`, just specify it via option `-r, --rewrite-file`

## Git commit

Git commitment is highly recommended, submit configuration files (hosts/rewrite) to the repository for version control and teamwork.

## Start service

The concept of hiproxy is based on **Workspace**. The proxy service of hiproxy should be started in the workspace. Assuming that all projects are located in `~/workspace/`, then this directory is the `Workspace`.

Enter this directory, start the proxy service, then hiproxy will find all the configuration files of all projects.

If service is needed before entering the workspace, just start proxy using the option `-w, --workspace <workspace>` in any directories.

```bash
# Enter any directories
hiproxy start -w ~/workspace/
```

**TIPS**: While on starting the proxy, use the option `-o, --open [browser-name]` to open a new browser window and configure the proxy automatically. Therefore, no manual configuring is needed.

## Development debugging

When the proxy is started, if the proxy rules are configured, all requests from the browser window will be handled by hiproxy.

No need to configure system hosts.
