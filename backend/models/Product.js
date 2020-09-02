// MODELO
const table = "products";
const dbConnection = require("./DBConnection"); 
 
module.exports = class Product {

    constructor(barcode, name, price) {
        this.barcode = barcode;
        this.name = name;
        this.price = price;
    }

    static all = () => {
        return dbConnection.threadId;
        // dbconnection.query('SELECT * FROM ' + table, function(err, rows, fields) {
        //     if (err) throw err;
        //     return rows;
        // });
    }

    // static test(){
    //     console.log("Como esto vaya me cago encima");  
    // }
    
    // static getById(id){

    // }
    // static getByBarCode(id){
        
    // }
}