const start = "https://www.swimcloud.com/team/33/roster/?page=1&gender=M&season_id=15&sort=name"; // 2011
const end = "https://www.swimcloud.com/team/33/roster/?page=1&gender=M&season_id=25&sort=name"; // 2021

function URLFromYear(year, gender = "M") {
  const season = year - 2011 + 15;
  return `https://www.swimcloud.com/team/33/roster/?page=1&gender=${gender}&season_id=${season}&sort=name`;
}
