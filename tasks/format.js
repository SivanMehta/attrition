module.exports = function format(data) {
  let content = '';

  data.forEach(row => {
    content += `${row.name}|${row.hometown}|${row.class}|${row.points}\n`;
  });

  return content;
}
