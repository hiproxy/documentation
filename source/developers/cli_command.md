title: CLI Command Configuration
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

CLI of hiproxy supplied commands such as `start`, `stop`, `state` and `open`. If then are not enought, you can add your own ones.

You should define something, such as `command name`, `description`, `handler` and `options`, for the new command. This is description:

* **Command Name（command）**：`<String>`, i.e. `'hello'`。
* **Description（describe）**：`<String>`, summary about the command's usage or more, i.e. `'A test command that say hello to you.'`。
* **Usage（usage）**：`<String>`, command usage, i.e. `'hello [--name <name>] [-xodD]'`。
* **Handler（fn）**：`<Function>`, the command invokes the handler while it's executing. `this` of the handler refer to a object which describes command line arguments.
* **Options（option）**：`<Object>`, options for the command, supplied in form of `key:value`. See <https://github.com/hemsl/hemsl>.

## Example

A whole example of custom command is:

```js
{
  command: 'hello',
  describe: 'A test command that say hello to you.',
  usage: 'hello [--name <name>] [-xodD]',
  fn: function () {
    var cliArgs = this;
    if (cliArgs.name ) {
      console.log('your name is', cliArgs.name.green);
    }

    if (cliArgs.age ) {
      console.log('your are', cliArgs.age.green, 'years old');
    }
  },
  options: {
    'name <name>': {
      alias: 'n',
      describe: 'your name'
    },
    'age': {
      alias: 'a',
      describe: 'your age'
    }
  }
}
```


