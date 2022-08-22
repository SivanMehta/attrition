const puppeteer = require('puppeteer');
const scrape = require('./scrape');
const parse = require('./parse');
const format = require('./format');
const writeFile = require('util').promisify(require('fs').writeFile);

const start = 2011;
const end = 2021;

const competitors = {
  CMU: 33,
  Emory: 123, // 🖕🖕🖕
  Chicago: 259,
  WashU: 94,
  NYU: 59,
  Case: 200,
  Rochester: 6,
  Brandeis: 4,
  Hopkins: 111,
  MIT: 14,
  Kenyon: 125,
  Denison: 118
};

// generate a roster given a year and team id
function URLFromYear(year, id) {
  const season = year - 2011 + 15;
  return `https://www.swimcloud.com/team/${id}/roster/?page=1&gender=M&season_id=${season}&sort=name`;
}

async function run(team, page) {
  const id = competitors[team];
  for(let year = start; year <= end; year ++) {
    const url = URLFromYear(year, id);
    console.log('scraping', year, 'for', team, 'from', url);
    
    const data = await scrape(page, url);
    const parsed = parse(data);
    const formatted = format(parsed);
    
    const filename = `./data/${team}/${year}.csv`;
    await writeFile(filename, formatted);
  }
}

async function main() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  const teams = Object.keys(competitors);

  for(let i = 0; i < teams.length; i++) {
    const team = teams[i];
    await run(team, page);
  }

  await browser.close();
}

main();
