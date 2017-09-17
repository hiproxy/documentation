title: Plugin Development Guide
---

Hiproxy supplied a mechanism of developing plugins. It's simple that you need just develop a plugin and install it to global. Hiproxy should look for and load all plugins while it starts. 

If you want to develop a plugin, `hiproxy-plugin-example` is a good demo which you can find at <https://github.com/hiproxy/hiproxy-plugin-example>. This is a entire plugin demo, you can start your own pluign base on the demo.

**A plugin is a common npm module. You do not need to install hiproxy as a dependency.**

<br />

## Plugin's architecture

Three condition should be satisfied before a module becomes a hiproxy pluign:

1. __It must be a standalone npm module which export only one object with three properties__

```js
module.exports = {
  // CLI commands
  commands: commands,

  // Rewrite config redirectives
  directives: directives,
  
  // HTTP server routes
  routes: routes
};
```

* **commands**: `<Array>`, extends `hiproxy` **CLI**. Each element in the array should be a command configuration. See [Command Configuration](./cli_command.html) for details.

* **directives**: `<Array>`, extends ***rewrite* directive** of `hiproxy`. Each element in the array should be a directive configuration. See [Rewrite Directive](./directive.html) for details.

* **routes**: `<Array>`, extends page router of `hiproxy`. Each element in the array should be a route configuration.See [Page Route Configuration](./route.html) for details.

2. __Plugin module must be installed to global__

3. __Plugin name should use `hiproxy-plugin-` as prefix__

## Code Example

<https://github.com/hiproxy/hiproxy-plugin-example/blob/master/index.js#L14-L23>

## Publish Plugin

You can publish a plugin into npm while it's completed with development and testing.

The publish process is the same as publishing other npm module, since the a plugin of hiproxy **is jsut** a **common npm module** which follows given rules.

## Hint

Hiproxy look for plugins which has `hiproxy-plugiin-` as prefix and installed in the directory described by `npm root -g`, so that hiproxy cannot find new developing pluigns.

`npm link` can create a symbol link of a plugin so that you can debug it while it's in development. See [npm link](https://docs.npmjs.com/cli/link) of npm document for details.
