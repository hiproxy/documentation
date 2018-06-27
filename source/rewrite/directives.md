title: Rewrite Directive
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

<style>
  h3 {margin-top: 5em!important;}
  h3:first-of-type {margin-top: 1em!important;}

  h4 {margin-top: 5em!important;}
</style>

## Directive

`directive`（known as `command`）is for setting variable, or manipulating request/response.

### Global Directives

#### * set

Description: define variables

Syntax: 

> **set** key value

**Scope Chain**：global, domain, location

Example:

```bash
set $server hiipack;
```









### Request Directives

The directives are `Request` instances to send request from proxy to target server.

**Scope Chain**：domain, location

#### * proxy_set_header

Description: setting a request header

Syntax: 

> **proxy_set_header** key value

Example:

```bash
proxy_set_header Host some.example.com;
```

#### * proxy_hide_header

Description: remove a request header

Syntax: 

> **proxy_hide_header** key

Example:

```bash
proxy_hide_header Host;
```

#### * proxy_set_cookie

Description: setting a request cookie value

Syntax: 

> **proxy_set_cookie** key value

Example:

```bash
proxy_set_cookie from hiproxy;
```

#### * proxy_hide_cookie

Description: remove a request cookie value

Syntax: 

> **proxy_hide_cookie** key

Example:

```bash
proxy_hide_cookie from;
```

#### * proxy_method

Description: set the request method.

Syntax: 

> **proxy_method** method

Example:

```bash
proxy_method POST;
```

#### * proxy_set_body

Description: set the request body content.

Syntax: 

> **proxy_set_body** body

Example:

```bash
proxy_set_body "a=1&b=2&c=3";
```

#### * proxy_append_body

Description: append content to the body.

Syntax: 

> **proxy_append_body** content

Example:

```bash
proxy_append_body "&d=4";
```

#### * proxy_replace_body

Description: replace part of the body.

Syntax: 

> **proxy_replace_body** oldVal newVal

Example:

```bash
proxy_replace_body "a=1" "a=111";
```

### Response directives

The directives are `Response` instances to let proxy response the browser.

**Scope Chain**：domain, location

#### * status

Description: Set the response status code and status message.

Syntax: 

> **status** statusCode statusMessage

Example:

```bash
status 477 "Authentication failed";
```

#### * set_header

Description: add a header

Syntax: 

> **set_header** key value

Example:

```bash
set_header SERVER hiproxy;
```

#### * hide_header

Description: remove a header

Syntax: 

> **hide_header** key

*Example*:

```bash
hide_header SERVER;
```

#### * set_cookie

Description: set a coolie value

Syntax: 

> **set_cookie** key value

Example

```bash
set_cookie SESSION_ID 2BF36A09CB35FD71E;
```

#### * hide_cookie

Description: remove a cookie value

Syntax: 

> **hide_cookie** key

*Example*:

```bash
hide_cookie SESSION_ID;
```

#### * send_file

Description: send the specified file as response

Syntax: 

> **send_file** file_name

Example:

```bash
send_file index.html;
send_file /site/index.html;
```

#### * echo

Description: response specified content

Syntax: 

> **echo** string

Example:

```bash
echo <h1>hello_echo</h1>;
echo <p>finish</p>;
```

### Directives in domain

They are valid only in then same domain and make directives ignored which has the same name in global scope.

**Scope Chain**：domain

#### * ssl_certificate

Description: specify certificate file

parameter: **ssl_certificate** file.crt

Example:

```bash
example.com => {
  ssl_certificate /user/root/.hiproxy/cert/example.crt;
}

```

#### * ssl_certificate_key

Description: specify the file storing private key

parameter: **ssl_certificate_key** file.key

Example:

```bash
example.com => {
  ssl_certificate_key /user/root/.hiproxy/cert/example.key;
}

```


### Directives in location

They are valid only in the same location and make directives ignored which has the same name in global scope.

**Scope Chain**：domain, location

#### * proxy_pass

Description: set the target location of forwarding

parameter: **proxy_pass** url

Example:

```bash
proxy_pass http://some.example.com/some/path/;
```

#### * alias

Description: map the particular `location` to native.

parameter: **alias** path

Example:

```bash
alias /Users/root/some/path/;
```

#### * root

Description: the default document while `location` is mapped to native. `index.html` is the omitted document name.

parameter: **root** file_name

*Example*:

```bash
root app.html;
```
