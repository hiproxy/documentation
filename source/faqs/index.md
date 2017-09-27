title: FAQs
---

### What's the core feature(or purpose) of hiproxy?

The core feature of hiproxy is forwarding request. Hiproxy purposes to solve some problems which front-end developer can meet while working:

- `hosts` cannot work immediately since there are caches after it's updated.
- Nginx is used for reverse proxy.
- Self signed HTTPS certificate are not trusted.
- Everyone maintans the environment profile (hosts/nginx configuration).
- ...

<br/>

### What's the difference between hiproxy and Charles／Fiddler?

They all have the ability to capture packages, proxy request and many core function. But hiproxy is a CLI tool which works with configuration files.

However, hiproxy has no interface to see the specific content of request. That will be introduced as a plugin in the future.

<br/>

### What's the relationship between hosts for hiproxy and for OS？

They are no relationship actually.

the hosts file for hiproxy is normally placed in project directory, or other (user specified) directory. Hiproxy would looking for, load and parse the hosts file in project directories, **but not do with OS one**.

<br/>

### Is the rewrite configuration file for hiproxy fully compatible with Nginx configuration?

No. They are no relationship actually.

The rewrite configuration for rewrite has similar syntax of Nginx configuration. The core syntax is consistent with the syntax of Nginx, but there are also some syntax are specific to hiproxy. They are not exactly consistent with Nginx syntax. For example:

```bash
# base rule
http://hiproxy.org/api/login.do => http://127.0.0.1:9999/api/login.json;

# domain
hiproxy.org => {
  # ...
}
```

In addition, some directives come from Nginx which do simular things, such as `proxy_pass`, `set`, `ssl_certificate` and `ssl_certificate_key`, etc. In any case they **cannot promise that all details are same as Nginx directives.**Please see [Directive](../rewrite/directive.html) for more information.

<br/>

### Does hiproxy support that the same domain name is used in the configuration files of multi-projects?

It's supported.

You can set rules for the same domain name in configuration files of different projects. Hiproxy can merge all rules about the same domains. If there is conflict, later loaded rules would rewrite earlier rules.

<br/>

### How does hiproxy handle the conflict between multiple configuraton files?

Some soon.

<br/>

### How to get/import root certificate of hiproxy？

See [get／import SSL certificate](../configuration/ssl_certificate.html)。

<br/>

### How hiproxy to use it own SSL certificate？

By default, when the https request is forwading, hiproxy will **generate the certifiate automatically** and use customized CA certificate signature. The users should import root certificate of hiproxy.

If you use customized certificate, ou can use some hiproxy directive for configurating:

```
ssl_certificate     ./hiproxy.org.crt;
ssl_certificate_key ./hiproxy.org.key;
```

<br/>

### ...
