title: Introduction
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

hiproxy is a lightweight, extendable network proxy based on Node.js, the main purpose is to resolve the hosts management and proxy request problem that multiple developers encountered in development. And there is no need to modify system hosts and start Nginx service.

hiproxy supports hosts file, and the syntax is extended for hosts, it now supports port number. Besides, hiproxy supports configuration file using syntax similar to that for Nginx.

## Why hiproxy

In front-end development, if developers usually encounter some of the following problems:

1. While debugging online page issues, if both local development and back-end running ability for projects (Node.js/Java project) are required, __it may costs a lot for a front-end developer to build a back-end environment locally__.
2. If multiple front-end projects exist, __with one domain__, __some projects__ need to request __online__ resources, __other__ projects request __local__ resources.
3. In order to resolve the cross-domain problems, local development needs to __modify Response Header__.
4. While developing https site locally, __certificate is not trusted__.
5. With system __hosts__ changed，__it won't take effect immediately__.

We can use Nginx to resolve the problems above. Nginx is excellent and also a very good friend of our front-end developer. The configuration file style of Nginx is very intuitive, and the configuration efficiency is high.

However, when using Nginx, we also need to use hosts to send the related requests to the local Nginx service.

In addition, in most cases, the Nginx configuration file will not be submitted to the repository, so other members of the team will copy each others' configuration file, therefore the efficiency is relatively low, and once a configuration file has been modified, other configuration files will not be updated in time. For the configuration of multiple domains, they are placed in a unified directory, and then being included in the main configuration, which is also inconvenient.

__hosts__, __revers proxy__, __https__ and __cache__ Will these trivial things be solved in a unified way?

So there is hiproxy.

## Feature

* Nginx-styled configuration file format supported, configuration is simple and intuitive
* Hosts and extensions supported, as well as port number
* Plugins extending `rewrite` commands, CLI commands and page supported
* HTTPS certificate auto-generate
* Proxy auto-config
* Background start and log file output
* Configuration file auto-find
* Browser window auto-open and proxy auto-config
* Node.js API provided
* ...

## Concept

After rethought many of the existing development models and summed up some of the encountered problems, hiproxy is developed based on the following two concepts:

* **Workspace**：hiproxy works in Workspace, the configuration files for all projects in the workspace are resolved by hiproxy. *The workspace can be specified via option `-w, --workspace <workspace>`, or directly into the workspace to start the proxy service*.
* **Shared configuration file**: Configuration files are submitted to the repository, and team members share them. Previously, hosts and Nginx configurations were generally not submitted to the repository, and the team members were locally maintained, costly and inefficient.

## Basic principle

The core functionality of hiproxy is the proxy request, it handles some of the development details at the same time as the proxy request, such as automatic generation of HTTPS certificates, automatic configuration of browser agents, and so on.

The basic principles of hiproxy core functionality describe as follows.

### Proxy request

hiproxy makes full use of the [Man-in-the-middle attack](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) model as intermediaries, data is forwarded at the client and server side to implement the HTTP and proxy for the HTTPS requests.

#### HTTP request

For the **HTTP request**, if the browser has configured the proxy, it will send `GET`/`POST` and so on to the hiproxy agent. After the hiproxy receives the request, it makes some changes to the requested information based on the user's `hosts` and `rewrite` rules, and then goes to the appropriate server to request the resource and return it to the client.

#### HTTPS request

For the **HTTPS request**, the browser will send a `CONNECT` request to hiproxy service after the proxy configured, then hiproxy will start a new TCP connection to the final target server (i.e. a new tunnel) and then transmit the data between the client and server.

However, it's only a simple proxy request, and hiproxy cannot obtain the requested information, such as parameters and Cookie, and there is no way to modify the response data. If we do not need to make corresponding changes to the request and response information, this will meet our needs.

What needs to be done if we need to implement the same functionality as the HTTP request: do some changes to the request and response based on the requested information?

Fortunately, we can make full use of [Man-in-the-middle attack](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) model. Because the final target server can get the requested information, we can start an intermediary service between the hiproxy and the final server (here referred to as *M*), when hiproxy receives a `CONNECT` request, it starts a new connection to the *M*, when the *M* receives the request, it makes some modifications to the request information, like the HTTP request agent, and then requests the resource from the target server and returns it to the client.

### HTTPS certificate generation

In the SSL/TLS handshake, the first message sent by the client (Client Hello) will be using the extension [SNI(Server Name Indication)](https://en.wikipedia.org/wiki/Server_Name_Indication) to send the requested domain to the server. Although only the domain information is sent, other requests, paths, parameters, and cookie are not sent, but the domain is sufficient for the certificate to be generated.

When hiproxy gets the domain for the request:

* If the user has configured the certificate for the corresponding domain, the user configured certificate is sent to the client.
* Otherwise, a new domain certificate is generated and returned to the client.

### Browser window

First, find the path corresponding to the browser in the system. For example, on OSX, look for `<browser-name>.app`, then start the app and pass arguments to configure the proxy server address.

```bash
<path-to-chrome-app>.app [options] [url]
```
On Windows, you go to the registry to find the `exe` file path for the browser. Then run and pass arguments.

```bash
<path-to-chrome-app>.exe [options] [url]
```

For Chrome/Opera, we need to pass two arguments:

* **Address of proxy service**: `--proxy-pac-url` (PAC proxy file path) or `--proxy-server` (general agent address), hiproxy supports all.

* **The directory where user data is stored**: `--user-data-dir`

When passing this argument, and the directory is not the default directory the browser uses to store user data, it will create a new browser instance which is independent of any other browser window and has no effect on each other(the instance has been configured with proxy, the request of other browser instance will not pass through the proxy configuration here).

### Configuration file

hiproxy can use hosts as a simple proxy request and configure rewrite rules similar to the Nginx syntax for complex configurations.

#### hosts

Consistent with the system `hosts` syntax, in addition, port numbers are supported. Hosts can only configure the IP and port numbers corresponding to the domain, detailed routing configuration and request response modification are not supported. For more details, check [hosts](../configuration/hosts.html)。

#### hosts configuration sample

```bash
# comment
127.0.0.1 example.com

# ip + port
127.0.0.1:8800 blog.example.com life.example.com
```

#### rewrite

The rewrite rule configuration file allows you to use more complex configurations to satisfy complex usage scenarios. You can configure the route in detail and make modifications to the request response. The syntax for the rewrite rule configuration is very similar to that of the Nginx syntax. For more details, check [rewrite](../configuration/rewrite.html)。

#### rewrite configuration sample

```bash
# Global variable
set $port 8899;
set $ip   127.0.0.1;
set $online 210.0.0.0;

# Domain configuration
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

### Plugin mechanism

When hiproxy starts, it automatically finds the module at the beginning of the `hiproxy-plugin-` from the directory in the NPM global module (`npm, root, -g`) and automatically resolve the plugin content after finding the modules.

Therefore, we only need global install plugins independently, no need to upgrade hiproxy, and the hiproxy plugin development is also independent, the plugin project itself is not dependent on hiproxy.

For detailed plugin documents, check [hiproxy Plugin](../developers/plugin.html)；

