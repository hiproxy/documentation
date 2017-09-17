title: Node.js API
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

<a name="ProxyServer"></a>

## ProxyServer ⇐ <code>EventEmitter</code>
**Kind**: global class  
**Extends**: <code>EventEmitter</code>  

* [ProxyServer](#ProxyServer) ⇐ <code>EventEmitter</code>
    * [new ProxyServer(httpPort, httpsPort)](#new_ProxyServer_new)
    * [.start(httpPort, httpsPort)](#ProxyServer+start) ⇒ <code>Promise</code>
    * [.stop()](#ProxyServer+stop) ⇒ [<code>ProxyServer</code>](#ProxyServer)
    * [.restart()](#ProxyServer+restart) ⇒ [<code>ProxyServer</code>](#ProxyServer)
    * [.addHostsFile(filePath)](#ProxyServer+addHostsFile) ⇒ [<code>ProxyServer</code>](#ProxyServer)
    * [.addRewriteFile(filePath)](#ProxyServer+addRewriteFile) ⇒ [<code>ProxyServer</code>](#ProxyServer)
    * [.openBrowser(browserName, url, [usePacProxy])](#ProxyServer+openBrowser) ⇒ [<code>ProxyServer</code>](#ProxyServer)
    * [.findConfigFiels([dir])](#ProxyServer+findConfigFiels) ⇒ [<code>ProxyServer</code>](#ProxyServer)

<a name="new_ProxyServer_new"></a>

### new ProxyServer(httpPort, httpsPort)
Hiproxy's proxy server.


| Param | Type | Description |
| --- | --- | --- |
| httpPort | <code>Number</code> | proxy server port for http |
| httpsPort | <code>Number</code> | proxy server port for https |

<a name="ProxyServer+start"></a>

### proxyServer.start([config]) ⇒ <code>Promise</code>
Start proxy server.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| config | <code>Object</code> | configuration fields |

<a name="ProxyServer+stop"></a>

### proxyServer.stop() ⇒ [<code>ProxyServer</code>](#ProxyServer)
Stop proxy server.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  
<a name="ProxyServer+restart"></a>

### proxyServer.restart() ⇒ [<code>ProxyServer</code>](#ProxyServer)
Restart proxy server.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  
<a name="ProxyServer+addHostsFile"></a>

### proxyServer.addHostsFile(filePath) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Add a *hosts* file.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| filePath | <code>String</code> \| <code>Array</code> | `hosts` file path(s) (absolute) |

<a name="ProxyServer+addRewriteFile"></a>

### proxyServer.addRewriteFile(filePath) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Add a *rewrite* file.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| filePath | <code>String</code> \| <code>Array</code> | `rewrite` file path(s) (absolute) |

<a name="ProxyServer+openBrowser"></a>

### proxyServer.openBrowser(browserName, url, [usePacProxy]) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Open a browser.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| browserName | <code>String</code> |  | browser name |
| url | <code>String</code> |  | the URL should be opened |
| [usePacProxy] | <code>Boolean</code> | <code>false</code> | whether use PAC proxy |

<a name="ProxyServer+findConfigFiels"></a>

### proxyServer.findConfigFiles([dir]) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Look for configuration files within the workspace (directory).
Hiproxy looks for configuration files from immediate child directories of workspace.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| [dir] | <code>String</code> | <code>process.cwd()</code> | workspace (directory) |


### proxyServer.enableConfFile(confFileType, filePath) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Enable specified configuration file.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| confFileType | <code>String</code> |  | file type (host/rewrite) |
| filePath | <code>String</code> \| <code>Array</code> |  | modified file path(s) |

### proxyServer.disableConfFile(confFileType, filePath) ⇒ [<code>ProxyServer</code>](#ProxyServer)
Disable specified configuration file.

**Kind**: instance method of [<code>ProxyServer</code>](#ProxyServer)  
**Access**: public  

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| confFileType | <code>String</code> |  | file type (host/rewrite) |
| filePath | <code>String</code> \| <code>Array</code> |  | modified file path(s) |
