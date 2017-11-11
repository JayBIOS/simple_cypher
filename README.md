# Simple Cypher

> Version: 2.0.0

[![Build Status](https://travis-ci.org/JayBIOS/simple_cypher.svg?branch=master)](https://travis-ci.org/JayBIOS/simple_cypher)

[**Deployed here**](https://caesar.jaybios.me/)

## Routes

**GET** `/` to retrieve the application version

**POST** `/cypher/` to cypher a phrase.
```JSON
{
    "text": "string",
    "password": "string"
}
```

**POST** `/decypher/` to decypher a phrase.
```JSON
{
    "text": "string",
    "password": "string"
}
```

Both routes return the result with the following JSON structure.
```JSON
{
    "result": "string"
}
```

**Password must contain only integers and spaces.**
