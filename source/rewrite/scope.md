title: Rewrite Scope
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Code block

There are three categories of code block in hiproxy:

* **global block**: All configurations which are not in other blocks, are in global block;
* **domain block**: It's nested in global block;
* **location block**: It's nested in domain block;

## Scope

There are five types of scopes that are involved in the configuration file:

* **global scope**: The scope is corresponding to *global block*. The variables in the global scope can be accessed everywhere;
* **domain scope**: The scope is corresponding to *domain block*.
* **location scope**: The scope is corresponding to *location block*.
* **request scope**: A implicit scopre which is not corrsponding to any code block. The directives in the scope are distributed across any code block.
* **response scope**: A implicit scopre which is not corrsponding to any code block. The directives in the scope are distributed across any code block.

## Code block hierarchy

```
global
    |- domain
        |- location
        |- location
        |- ...
    |- domain
        |- location
        |- location
        |- ...
```

## Looking for variables

Here are rules for looking for variables in current scope:

1. While the varialbe is in current scope, its value should be *returned*.
2. Looking for the varialbe in upper level scope, and *return* the value if it's found.
3. Otherwise, if upper scope is global scope, the variable name (include `$` character) should be *returned*.
4. Repeat steps *[2-3]*.

## Execute directive

The directive in the code block executes automaticlly at the appropriate time (request/response). The directives in upper scope execute too.

```bash
www1.test.com => {
    # 1    
    proxy_set_header Host www.test.com;

    location / {
        # 2
        proxy_pass http://52.88.88.88/;
    }

    location /index.html {
        # 3
        proxy_pass http://127.0.0.1:8800/girl/view/index.html;
    }

    location ~ /\/(native|gallery|picture|font)\/(.*)/ {
        # 4
        proxy_pass http://88.88.88.88/$1/$2;
    }
}
```

In the configuration, if the directive at \#2, \#3 or \#4 executes, the one at \#1 would execute too. That means:


A request for `/`, `/index.html` or `/\/(native|gallery|picture|font)\/(.*)/` should be add a `Host` header, which has `www.test.com` as value.

