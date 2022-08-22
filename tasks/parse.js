const fs = require('fs');

const states = {
  0: 'index',
  1: 'name',
  2: 'hometown',
  3: 'class',
  4: 'points'
}

module.exports = function parse(data) {
  const rows = [];
  let row = {};
  data.forEach((cell, i) => {
    const state = states[i % 5];
    row[state] = cell;

    // if we are looking at the last cell in a row,
    // push the row to the rows array
    if(state === states[4]) {
      rows.push(row);
      row = {};
    }
  });

  return rows;
}
