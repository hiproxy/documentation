title: 安装
---

> 如果你愿意帮助hiproxy编写文档，请联系zdying@live.com, 谢谢！
>
> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## 安装hiproxy

### 通过npm安装

hiproxy已经发布到[npm](https://www.npmjs.com/)，您可以通过npm来安装：
```bash
npm install -g hiproxy
```

如果您希望使用最新的测试版本功能（可能不稳定），可以选择安装hiproxy的beta版本：
```bash
npm install -g hiproxy@beta
```

此外，您也可以直接使用github源码安装：
```bash
npm install -g hiproxy/hiproxy
```

**提示**：如果您还没有安装Node.js，可以到[Node.js官网](https://nodejs.org/en/)下载安装。

### 通过yarn安装

hiproxy也支持通过[yarn](https://yarnpkg.com)来安装：
```bash
yarn global add hiproxy
```

## 安装插件

hiproxy也支持插件扩展。插件可以独立于hiproxy安装，直接安装到全局即可。

比如我们要安装插件[hiporxy-plugin-dashboard](https://www.npmjs.com/package/hiproxy-plugin-dashboard)，可以执行下面的命令：

```bash
npm install hiproxy-plugin-dashboard -g
```

安装之后，hiproxy下次启动的时候，会自动加载安装好的插件。
