title: Hosts
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

**Hosts** can be thought as enhanced `hosts` of OS, Its most important feature is **port forwarding**.

**Note**: hiproxy support both `hosts` file and [`rewrite`][rewrite] file. `hosts` is a simple solution so that it supports only forwarding domain & port. If you want custom complex forwarding rules, see [rewrite][rewrite] as referrence.

## Working mechanism

**Hiproxy** will parse `hosts` files in the projects' immediate directories while it starts. The proxy server would forward received requests according to rules in `hosts` files.


## Features
* Port forwarding;
* `hosts` file of project is used to instead of OS one and avoid system cache issue;
* You do NOT need to restart hiproxy after modifying `hosts` file. Hiproxy can restart and refresh `hosts` rules automatically.

## Syntax

The syntax of project `hosts` is very similar as OS one. Supporting **IP+port** is the only difference. The syntax is:

```
IP[:port] domain1 domain2 domain3 ... domainN
```

## For Example

```bash
# custom hosts with port :)

127.0.0.1:8800 hiproxy.org blog.hiproxy.org
127.0.0.1 hiproxy.org blog.hiproxy.org
```

[rewrite]: ../rewrite/
