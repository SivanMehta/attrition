const puppeteer = require('puppeteer');
const parse = require('./src/parse');

const start = 2011;
const end = 2021;

function URLFromYear(year, gender = "M") {
  const season = year - 2011 + 15;
  return `https://www.swimcloud.com/team/33/roster/?page=1&gender=${gender}&season_id=${season}&sort=name`;
}

const STATES = {
  ROW_NUMBER: 0,
  NAME: 1,
  CLASS: 2,
  POINTS: 3
}

async function scrape(page, url) {
  await page.goto(url, { waitUntil: 'networkidle2' });
  const tds = await page.$$('tr > td');
  const data = [];
    
  for(let i = 0; i < tds.length; i += 1) {
    const content = await page.evaluate(el => el.innerText, tds[i]);
    data.push(content);
  }

  return data;
}


async function run() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();


  for(let year = start; year <= start/*end*/; year ++) {
    const url = URLFromYear(year);
    console.log('scraping', url);
    const data = await scrape(page, url);
    const parsed = await parse(data);
  }
  await browser.close();

} 

run();
