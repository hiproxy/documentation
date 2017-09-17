title: Rewrite Directive
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

**rewrite directive** can configure `directive name`, `scopes` and `handler`. They are:

* **Directive Name（name）**：`<String>`, i.e. `'add'`。
* **Scopes（scope）**：`<Array>`, the scopes which the directive runs in. The directive is only valid in specified scopes. The scopes include `global`, `domain`, `location`, `request` and `response`.
* **Handler（fn）**：`<Function>`, the handler should be invoked while the directive is execute. See [handler](#handler-function) for details.

## Example

Here is a entire example of directive:

```js
{
  name: 'add',
  scope: ['global', 'domain', 'location'],
  fn: function (key, a, b) {
    var props = this.props;
    var value = Number(a) + Number(b);

    this.props[key] = value;
  }
}
```

<a name="handler-function"></a>

## Handler

The handler is invoked while hiproxy is executing related directive. The parameters whick are specified for the directive in *rewrite* configuration are passed in and `this` should be setted.

### Parameters

The parameters for the directive in *rewrite* configuration should be passed into handler. For example, `proxy_set_header Host hiproxy.org` is configured then `('Host', 'hiproxy.org')` should be passed into **the handler**.

### this

`this` value is depended on the scope which the directive executs in. Following are possible `this` values:

- **global**: the entire *rewrite* instance - `{props: <Object>, domains: <Array>, commands: <Array>}}`
- **domain**: domain instance - `{domain: <String>, props: <Object>, location: <Array>, commands: <Array>}}`
- **location**: location instance - `{props: <Object>, location: <String>, commands: <Array>}}`
- **request**: `{request: <http.IncomingMessage>}`
- **response**: `{response: <http.ServerResponse>}`
