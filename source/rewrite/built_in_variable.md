title: Rewrite Built-in Variables
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

You can define your own global variables (use `set $var value` in global scope) in rewrite rules configuration file of hiproxy, as well as you can define variables in other scopes.

Hiproxy has some built-in variables so that you can use them directly in corresponding scopes without neither defining nor assigning. Particularly, user cannot redefine the variables to overwrite them.

## Global variables

Global variables can **be used in everywhere of configuration files**.

> Hint: hiproxy currently has not built-in variables. Some would be added in the furture.

## Location block scope variables

You can use the variables only in `location` blocks. Then are used to store information about request, such as query string(`$query_string`), Cookie(`$cookie_name`), and host(`$host`), etc. Here are all the variables that are currently supported:

### $host

The `host` correlative to the current request URL, or the `Host` field in request headers.

### $hostname

The `hostname` correlative to the current request URL, or correlative to the `Host` field in request headers.

### $server_port

The server port number of the request, default `80`.

### $search

The query string (with `?`) of the request, such as `?from=app&v=19482848253`.

### $query_string

The query string (**without `?`**), such as `from=app&v=19482848253`.

### $scheme

The request protocol, it's either `http` or `https`.

### $request_uri

The entire request URL, such as `http://hiproxy.org:8081/docs/index.html?from=google&v=_1847295727524#get-started`.

### $path

The request `path` (with query string), such as `/docs/index.html?from=google&v=_1847295727524#get-started`.

### $path_name

The request `path_name` (without query string), such as `/docs/index.html`.

### $base_name

The last part of the path. For exampke, let's say the path is `/docs/index.html`, so that $base_name is `index.html`.

### $dir_name

The directory names of the path. For example, let's say path is `/docs/index.html`, so that $dir_name is `/docs/`.

### $hash

The `hash` (with `#`) of request URL, such as `#get-started`.

### $hash_value

The `hash` value (without `#`) of request URL, such as `get-started`.

### $uri

Same as `$request_uri`.

### $cookie_*name*

A `cookie` value. The `name` stands field name whose capital letters have been changed to lower ones and `-` characters have been changed to `_`. For example, `$cookie_userId` is for the value of `userId` in the `cookie`.

### $http_*name*

The value of a request header field. The `name` stands field name whose capital letters have been changed to lower ones and `-` characters have been changed to `_`. For example, let's say `User-Agent: user agent` is a valid request header, then `$http_user_agent` can get its value.

### $arg_*name*

The value of a request query parameter. The `name` stands field name whose capital letters have been changed to lower ones and `-` characters have been changed to `_`. For example, let's say the query string is ``?from=google&v=_1847295727524`, then `$arg_from` can get value of `from`.

