title: Run Example
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

## Introduction

Here is an [Example](https://github.com/hiproxy/hiproxy-example), with a Workspace inside, this workspace contains three basic projects, they use port `8000`, `8001` and `8002` respectively.

Meanwhile, a script named `server.js` is provided to start those three services, use command `npm start` or `node start`

The directory structure of this project is as follows:

```bash
.
├── LICENSE
├── README.md
├── package.json
├── start.js          # Service start
└── workspace         # workspace
    ├── blog-app      # blog app example
    │   ├── app.js    # express app
    │   ├── hosts     # hosts file
    │   ├── public    # static resources
    │   └── rewrite   # rewrite file
    ├── main-app      # main app example
    │   ├── app.js    # express app
    │   ├── hosts     # hosts file
    │   └── public    # static resources
    └── news-app      # news app example
        ├── app.js    # express app
        └── hosts     # hosts file
```

In directory `workspace`, three apps exist, with a `hosts` file for each:

```bash
# main-app hosts
127.0.0.1:8000 www.example.com
```

```bash
# blog-app hosts
127.0.0.1:8001 blog.example.com
```

```bash
# news-app hosts
127.0.0.1:8002 news.example.com
```

For `blog-app`, a `rewrite` file is included:

```bash
# rewrite rules
domain blog.example.io {
  # rewrite / to 8001;
  location / {
    proxy_pass http://127.0.0.1:8001/;
  }

  # static files
  location /static/ {
    alias ./public/;

    set_header server hiproxy;
    set_cookie server hiproxy;
  }
}
```

...

## STEPS

### STEP 1: clone codes

The codes of example project is hosted on github, use Git command to clone those codes local

```bash
git clone https://github.com/hiproxy/hiproxy-example.git
```

### STEP 2: install dependencies

Enter the root directory of project `hiproxy-example/`, install all the third-party dependencies

```bash
cd hiproxy-example
npm install
```

### STEP 3: start service

After cloning codes and installing dependencies, start the service provided by example project. Use command in `hiproxy-example/`:

```bash
npm start
```

### STEP 4: start hiproxy

With all steps above done, start hiproxy to have the first taste of it. Use command in `hiproxy-example/`:

```bash
hiproxy start --https --open --workspace ./workspace
```

### STEP 5: View test page

After running the command above, a browser window will be opened, with proxy already set. Visit any of the links below:

* <http://blog.example.com/>
* <http://www.example.com/>
* <http://news.example.com/>
* <http://blog.example.io/>
* <http://blog.example.io/static/>

