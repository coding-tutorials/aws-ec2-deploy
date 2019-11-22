const express = require('express')
const app = express()


app.get('/', (_, res) => {
  res.send("root")
})

app.get('/version', (_, res) => {
  res.send('published at 2019-11-22 14:23')
})

app.listen(3000, () => console.log('listening on :3000'))