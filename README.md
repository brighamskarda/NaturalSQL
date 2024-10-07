# Natural SQL Project

This is a school project for BYU's CS452 course in database modeling concepts. This project attempts to convert natural language into SQL and provide results with the use of OpenAI.

## Database Schema

I used SQLite for my database, but the filled in database file and the sql used to create it are in this repo.

This database is a simple representation of different animals. Namely Birds and bugs, bugs are further subdivided into two groups, spiders and insects. As you can see in the picture below there are a few different attributes that are stored for every animal.

![Picture of schema used.](schema.svg)

## Sample Questions and Responses

The first example below is a working example of a question that was provided to the program, the sql query it generated, and the user friendly response it returned.

The second example is an example that didn't work with a brief explanation of what went wrong.

### Example 1

### Example 2

## Explanation of Prompting Strategies Used

## How To Run

Since the sqlite .db file is included in the repo you don't need to worry about generating the database.

You need an open api key stored in a file called secretKey.

Simply run the python script `NaturalLanguage.py` and answer the prompts provided to get some information from the database.
