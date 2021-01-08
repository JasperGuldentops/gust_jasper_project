var url = 'https://little-bear-29.loca.lt';

function checkData(data) {
    var currency = new Object();
    var price = new Object();

    $.getJSON(url + '/cryptocurrencies/' + data.data.id, function (localData) {
        //If data is found, update only the price
        currency.id = localData.id;
        currency.name = localData.name;
        currency.price = data.data.market_data.price_usd;
        currency.webUrl = localData.webUrl;
        currency.amount = localData.amount;

        price.price = data.data.market_data.price_usd;
        price.date = data.status.timestamp;
        price.cryptocurrencyId = localData.id;

        putData(currency);
        postPrice(price);
    })
    .fail(function () {
        //If request returns nothing (404) create new data
        currency.id = data.data.id;
        currency.name = data.data.name;
        currency.price = data.data.market_data.price_usd;
        currency.webUrl = "www." + data.data.name + ".com"
        currency.amount = 0.0;

        price.price = data.data.market_data.price_usd;
        price.date = data.status.timestamp;
        price.cryptocurrencyId = data.data.id;

        postData(currency);
        postPrice(price);
    });
}

function postData(currency) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url + "/cryptocurrencies", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify(currency));
    xhr.onloadend = function () {
        console.log('New currency posted');
    };
}

function putData(currency) {
    var xhr = new XMLHttpRequest();
    xhr.open("PUT", url + "/cryptocurrencies/" + currency.id, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify(currency));
    xhr.onloadend = function () {
        console.log('Currency updated');
    };
}

function postPrice(price) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url + "/prices", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify(price));
    console.log('Prices updated');
    xhr.onloadend = function () {
        console.log('New price posted');
    };
}