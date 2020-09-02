
const dbConfig = require("../config/db.config");
var mysql = require('mysql');

const connection = mysql.createConnection({
  database : dbConfig.database,
  host     : dbConfig.host,
  user     : dbConfig.user,
  password : dbConfig.password,
  insecureAuth : true,
  // What the fuck were you looking for hm?
});



connection.connect(function(err) {
    if (err) {
      console.error('error connecting: ' + err.stack);
      return;
    }

    console.log('connected as id ' + connection.threadId);
});

module.exports = connection;



// connection.connect();

// connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
//   if (err) throw err;
//   console.log('The solution is: ', rows[0].solution);
// });

// connection.end();
