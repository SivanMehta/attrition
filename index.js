const puppeteer = require('puppeteer');
const scrape = require('./tasks/scrape');
const parse = require('./tasks/parse');
const format = require('./tasks/format');
const writeFile = require('util').promisify(require('fs').writeFile);

const start = 2011;
const end = 2021;

// generate carnegie mellon swimming roster given a year
function URLFromYear(year, gender = "M") {
  const season = year - 2011 + 15;
  return `https://www.swimcloud.com/team/33/roster/?page=1&gender=${gender}&season_id=${season}&sort=name`;
}

async function run() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  for(let year = start; year <= end; year ++) {
    const url = URLFromYear(year);
    console.log('scraping', year, 'from', url);
    
    const data = await scrape(page, url);
    const parsed = parse(data);
    const formatted = format(parsed);
    
    const filename = `./data/${year}.csv`;
    await writeFile(filename, formatted);
  }

  await browser.close();
} 

run();
