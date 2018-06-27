title: Rewrite Introduction
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

**rewrite** reference [Nginx][Nginx] configuration syntax. With very simple configuration, it is helpful for front-end developer to debug in native with online API or some other environemnts.

The server would scan and monitor `rewrite` files in each projects while it's running. If some file are changed, it can update forward rules immediately without restarting the server.

**Note**: hiproxy support both `rewrite` and [hosts][hosts] file. If you need only simple `domain+port` forwarding, you can use host file by referencing[hosts][hosts].

## Basic syntax

### Variables

**Syntax**
```bash
$variableName
```
**Example**

```bash
# 定义变量
set $var_name value

# 使用变量
$var_name
```
### domain

`domain` specify a domain name and all configuration about the domain name should be in the `domain` block.

**Syntax**

```bash
[domain_name|variable] => {
  # ...
}
```
**Example**

```bash
set $domain some.example.com

# use a domain name directly
some.example.com => {
  # ...
}

# or use a variable
$domain => {
  # ...
}
```

Or

```bash
set $domain some.example.com

# use a domain name directly
domain some.example.com {
  # ...
}

# or use a variable
domain $domain {
  # ...
}
```

### location

`location` represent a specific path. All configuration about the path should be in the `location` block.

**Note**: `location` must be in `domain` block.

**Syntax**

```bash
location [directory|file|regex|variables] {
  # ...
}
```
**Example**

```bash
# directory
location /some/path/ {
  # ...
}

# specific file
location /some/file.htm {
  # ...
}

# regular expression
location ~ ^/some/(path|path1)/.* {
  # ...
}

# variables
location $some/$path {
  # ...
}
```
### Directives

Directive is used to set variables, or manipulate `request`/`response`.

**Syntax**

```bash
command param1 param2 ... paramN
```

**Example**

```bash
# set proxy header
proxy_set_header Host some.example.com;

# set cookie in response
set_cookie UserID some_user_id;
```

### Comments

Annotate certain unnecessary conent **Only line comments are supported.**

**Syntax**

```bash
# comment content
```

### Brief syntax

The brief syntax can define some basic rules, no need `location` or other directives.

**Syntax**

```bash
domain => domain|path
```

**Example**

```bash
json.example.com => 127.0.0.1:8800;
```

## More Examples

```bash
set $local 127.0.0.1:8800
# simple rewrite rule
api.hiproxy.org => local.hiproxy.org;
api.hiproxy.org => 127.0.0.1:8800;
api.hiproxy.org/mock => $local/mock;
```

```bash
# rewrite folder
api.hiproxy.org/user/ => {
  proxy_pass local.hiproxy.org/user/;

  # proxy request config
  proxy_set_header Host api.hiproxy.org;
  proxy_set_header other value;
  proxy_hide_header other;
  
  proxy_set_cookie userid 20150910121359;
  proxy_hide_cookie sessionid;

  # response config
  set_cookie sessionID E3BF86A90ACDD6C5FF49ACB09;
  set_header proxy hiproxy;

  # allow CORS
  set_header Access-Control-Allow-Origin *;

  hide_header proxy;
  hide_cookie sessionID;
}
```

```bash
# regexp support
~ /(demo|example)/([^\/]*\.(html|htm))$ => {
  proxy_pass http://127.0.0.1:9999/$1/src/$2;
}
```

```bash
set $domain api.hiproxy.org;
set $local 127.0.0.1:8800;
set $api api;
set $test $api.example.com;
set $id 1234567;

# standard rewrite url
$domain => {
  proxy_pass http://$local/api/mock/;
  set $id 1234;
  set $mock_user user_$id;
  set_header Host $domain;
  set_header UserID $mock_user;
  set_header Access-Control-Allow-Origin *;
}

blog.hiproxy.org => {
  set_header Access-Control-Allow-Origin *;

  set $node_server 127.0.0.1:3008;
  set $order order;
  set $cookie1 login=true;expires=20160909;

  location /$api/$order/detail {
    proxy_pass http://$node_server/user/?domain=$domain;
    set_header Set-Cookie userID 200908204140;
  }

  location ~ /(usercenter|userinfo)/ {
    set $cookie login=true;expires=20180808;
    set $id 56789;

    proxy_pass http://127.0.0.1:3008/info/;

    set_cookie userID 200908204140;
    set_cookie userName user_$id;
  }

  location ~ /local/(.*)(\?(.*))? {
    send_file ./mock/$1.json;
  }

  location /dev {
    #alias /site/path/;
    alias ./src/view/;
    root app.html
  }

  location /multiple {
    echo <h1>hello_echo</h1>;
    echo <p>test echo directive</p>;
    echo <p>finish</p>;
  }
}
```

[hosts]: ../configuration/hosts.html
[Nginx]: http://nginx.org/en/docs/
