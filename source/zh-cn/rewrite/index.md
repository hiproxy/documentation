title: Rewrite简介
---

> 如果你愿意帮助hiproxy编写文档，请联系zdying@live.com, 谢谢！
>
> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## 简介

**rewrite** 参考了[Nginx][Nginx]配置语法，通过简单的配置，就可以帮助前端开发在本地调试的基础上，方便的利用其他环境或者线上的API接口进行测试。

当服务启动后，将自动扫描并监听各项目根目录下的`rewrite`文件，生成及实时更新转发规则，无需重启服务。

**注**：hiproxy同时支持项目`rewrite`及[hosts][hosts]文件。如果仅需要简单的`域名+端口`转发，请参考[hosts][hosts]。

## 基本语法

### 变量

**语法**
```bash
$变量名
```
**例子**

```bash
# 定义变量
set $var_name value

# 使用变量
$var_name
```
### domain

`domain` 用来指定一个域名，这个域名的所有配置都在 `domain` 块中。

**语法**

```bash
[域名|变量] => {
    # ...
}
```
**例子**

```bash
set $domain some.example.com

# 直接使用域名
some.example.com => {
    # ...
}

# 或者使用变量
$domain => {
    # ...
}
```
### location

location 用来指定域名中的一个具体的路径，这个路径的所有配置都在 location 块中。

**注意**：location必须位于domain块中。

**语法**

```bash
location [目录|文件|正则表达式|变量] {
    # ...
}
```
**例子**

```bash
# 目录
location /some/path/ {
    # ...
}

# 具体文件
location /some/file.htm {
    # ...
}

# 正则表达式
location ~ ^/some/(path|path1)/.* {
    # ...
}

# 变量
location $some/$path {
    # ...
}
```
### 命令

命令用于设置一些变量，或者对`request`\/`response`做一些操作。

**语法**

```bash
命令 参数1 参数2 ... 参数N
```

**例子**

```bash
# 设置代理时的头部
proxy_set_header Host some.example.com;

# 设置response的cookie
set_cookie UserID some_user_id;
```

### 注释

用来注释某些不需要的内容，**只支持单行注释**。

**语法**

```bash
# 注释内容
```

### 简写语法

简写语法，可以用来定义一些基本的规则，不需要写`location`和其他的命令。

**语法**

```bash
域名 ==> 域名|路径
```

**例子**

```bash
json.example.com => 127.0.0.1:8800;
```

## 更多例子

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

    location ~ /local\/(.*)(\?(.*))? {
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
