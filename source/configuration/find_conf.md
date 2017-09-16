title: Find Configuration File
---

> 如果你愿意帮助hiproxy编写文档，请联系zdying@live.com, 谢谢！
> 
> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

If you place the configuration file (include the its name) by following [hiproxy concept](../get_started/#Concept), while hiproxy starts, it can automatically find the file without specifying the configuration file manually.

Otherwise, you have to specify the configuration file while hiproxy starts. In the case, you may place the configuration file anywhere, which can be named anything. (Omitted *hosts* file name is `hosts`, and *rewrite* file name is `rewrite`).

## Specifiy configuration file

You can use some options to specify the name of configuration file. They are `-c, --hosts-file <files>` or `-r, --rewrite-file <files>`.

`-c, --hosts-file <files>` is used to specify the path of *hosts* file. `,` can be used to separate more than one files.

`-r, --rewrite-file <files>` is used to specify the path of *rewrite* file. `,` can be used to separate more than one files.

`<files>` supports **simple wildchar mode** to speify more files. For example, `--rewrite-file ./*/*.conf`.

> **Note**
>
> If you specified a configuration file, hiproxy would look for specified file to instead of looking for omitted `hosts` ro `rewrite`. For example:
> * If `-c ./*/hosts.conf` is specified, hiproxy would ignore the file named `hosts`.
> * If `-r ./*/rewrite.conf` is specified, hiproxy would ignore the file named `rewrite`.

## Wildchars in configuraton files

Suporting wildchars:

wildchars | description | example | mached | unmached
---------|----------|---------|----------|---------
 \* | Match one or more characters. | ./test-*.js | ./test-hello.js | ./test-.js
 ? | Match only one character. | ./test?.js | ./testA.js | ./testAB.js
 [abc] | Matches a single character that is contained within the brackets. | ./test[ABC].js | ./testA.js | ./testD.js
 [^abc] | Matches a single character that is not contained within the brackets. | ./test[^ABC].js | ./testD.js | ./testA.js
 [!abc] | Same as [^abc] | ./test[!ABC].js | ./testD.js | ./testA.js

> **Note**
> 
> Do not support use `**` to look for files in any hierarchy.
