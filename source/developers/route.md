title: Page Route Configuration
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

You can visit `http://127.0.0.1:<port>/` to watch basic informations of the service after it finished starting.

Except that page, hiproxy support a feature for adding new page. For example, plugin [hiproxy-plugin-dashboard](https://github.com/hiproxy/hiproxy-plugin-dashboard) add a page to hiproxy for showing service information and modifying configuration files, which is at `http://127.0.0.1:<port>/dashboard/`.

## Configuration Content

Page route configuration include: `route rules` and `renderer`. Then are:

* Route Rules（route）：`<String>`, URL pattern, i.e. `'/dashboard(/:page)'`. See <https://www.npmjs.com/package/url-pattern> for details.
* Renderer（render）：`<Function>`, for rendering a page. It accept three parameters: `(route, request, response)`.

## Renderer, render() Method

`render()` method should be invokded with three parameters, `(route, request, response)`, while user visit the corresponding page.

- **route**: `<Object>`, arguments object from route pattern. For example, `/test(/:pageName)` pattern cause the object `{pageName: 'home'}` while `/test/home` is visiting.
- **request**: `<http.IncomingMessage>`，http request instance.
- **response**: `<http.ServerResponse>`，http response instance.

## Example

A entire example is below:

```js
{
  route: '/test(/:pageName)',
  render: function (route, request, response) {
    // global variable `hiproxyServer` can be used to get hiproxy server instance.
    response.writeHead(200, {
      'Content-Type': 'text/html',
      'Powder-By': 'hiproxy-plugin-example'
    });

    var serverInfo = {
      route: route,
      pageID: route.pageName,
      time: new Date(),
      serverState: {
        http_port: global.hiproxyServer.httpPort,
        https_port: global.hiproxyServer.httpsPort,
        cliArgs: global.args,
        process_id: process.pid
      }
    };

    response.end('<pre>' + JSON.stringify(serverInfo, null, 4) + '</pre>');
  }
}
```
