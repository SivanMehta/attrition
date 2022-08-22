const fs = require('fs');
const writeFile = require('util').promisify(fs.writeFile);
const readFile = require('util').promisify(fs.readFile);

async function parse(data) {
  return data;
}


async function run() {
  const data = await readFile('./data/data.txt', 'utf8');
  const parsed = await parse(data.split('\n'));
  console.log(parsed)
}

run();
