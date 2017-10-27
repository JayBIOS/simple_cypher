# Simple Cypher

> Version: 1.0.0

[![Build Status](https://travis-ci.org/JayBIOS/simple_cypher.svg?branch=master)](https://travis-ci.org/JayBIOS/simple_cypher)

[**Deployed here**](https://caesar.jaybios.me/)

## Routes

**GET** `/` to retrieve the application version

**POST** `/cypher/` to cypher a phrase.
```
{
    "phrase": "string",
    "password": "string"
}
```

**POST** `/decypher/` to decypher a phrase.
```
{
    "phrase": "string",
    "password": "string"
}
```

**Password should only contain integers and spaces.**
