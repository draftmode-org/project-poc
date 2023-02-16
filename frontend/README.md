#bootstrap config

##install
```
npm i --save bootstrap bootstrap-vue @popperjs/core

npm i --save-dev vite
npm i --save-dev sass
npm i --save-dev @types/node
npm i --save-dev unocss
npm i --save-dev unplugin-vue-components
```

## default structure
my-project/<br/>
- src
  - js
    - main.js
  - scss
    - styles.scss
  - index.html
- package-lock.json
- package.json
- vite.config.js

## default content

### vite.config.js
```
const path = require('path')

export default {
  root: path.resolve(__dirname, 'src'),
  server: {
    port: 8080,
    hot: true
  }
}
```

### src/index.html
```
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap w/ Vite</title>
  </head>
  <body>
    <div class="container py-4 px-3 mx-auto">
      <h1>Hello, Bootstrap and Vite!</h1>
      <button class="btn btn-primary">Primary button</button>
    </div>
    <script type="module" src="./js/main.js"></script>
  </body>
</html>
```

## plugins

### bootstrap-navbar-sidebar