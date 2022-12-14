module.exports = function format(data) {
  let content = 'name|home|year|points\n';

  data.forEach(row => {
    content += `${row.name}|${row.hometown}|${row.class}|${row.points}\n`;
  });

  if(data.length === 0) {
    content += `-|-|-|-\n`;
  }

  return content;
}
