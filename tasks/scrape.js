module.exports = async function scrape(page, url) {
  await page.goto(url, { waitUntil: 'networkidle2' });
  const tds = await page.$$('tr > td');
  const data = [];
    
  for(let i = 0; i < tds.length; i += 1) {
    const content = await page.evaluate(el => el.innerText, tds[i]);
    data.push(content);
  }

  return data;
}
