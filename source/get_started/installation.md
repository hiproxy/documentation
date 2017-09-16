title: Installation
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Install hiproxy

### NPM

hiproxy has already been available in [npm](https://www.npmjs.com/), install it via commands:
```bash
npm install -g hiproxy
```

The latest beta version is also available (might be unstable), install it via commands:
```bash
npm install -g hiproxy@beta
```

Install source code from github via commands:
```bash
npm install -g hiproxy/hiproxy
```

**TIPS**: If you haven't installed NodeJS, download and install it from [Node.js](https://nodejs.org/en/)

### YARN

hiproxy can be installed by [yarn](https://yarnpkg.com):
```bash
yarn global add hiproxy
```

## Plugins installation

hiproxy also supports plugins. The plugins can be installed individually from hiproxy, just global install them.

e.g. If you want to install the plugin [hiporxy-plugin-dashboard](https://www.npmjs.com/package/hiproxy-plugin-dashboard), use the commands below:

```bash
npm install hiproxy-plugin-dashboard -g
```

After installation, the next time hiproxy starts, those plugins will be automatically loaded.
