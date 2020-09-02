// MODELO
const dbConnection = require("./DBConnection");
const table = "products";
 
module.exports = class Product {

    constructor(barcode, name, price) {
        this.barcode = barcode;
        this.name = name;
        this.price = price;
    }

    static async all(callbackGiveData) {
        let sqlQuery = 'SELECT * FROM ' + table;

        dbConnection.query(sqlQuery, function(err, rows) {
            if (err) throw err;

            callbackGiveData(rows);
        });
    }

    // static test(){
    //     console.log("Como esto vaya me cago encima");  
    // }
    
    // static getById(id){

    // }
    // static getByBarCode(id){
        
    // }
}