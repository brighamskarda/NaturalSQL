import sqlite3
import logging
from openai import OpenAI


def main():
    logging.basicConfig(
        level=logging.DEBUG,
        filename="NaturalLanguage.log",
        filemode="w",
        format="%(asctime)s - %(levelname)s - %(message)s",
    )

    openAI_key = open("secretKey", "r").read()
    client = OpenAI(api_key=openAI_key)

    dbConn = sqlite3.connect("animals.db")
    cursor = dbConn.cursor()

    while True:
        messageHistory = [
            {
                "role": "system",
                "content": """Generate a valid sqlite database query based on
                        following schema that answers the user's question.
                        Please return only the sql statement and nothing else.""",
            }
        ]

        context = get_contex(cursor)
        logging.debug("Database Context: " + str(context))

        messageHistory.extend(context)

        userQuestion = {"role": "user", "content": input("Enter your question: ")}

        messageHistory.append(userQuestion)

        completion = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messageHistory,
        )

        logging.debug(completion)

        sqlQuery = completion.choices[0].message.content

        logging.debug("SQL query to run: " + sqlQuery)

        messageHistory.append(
            {
                "role": "system",
                "content": "Here is the sql query I generated: " + sqlQuery,
            }
        )

        sqlResult = ""

        try:
            cursor.execute(sqlQuery)
            sqlResult = str(cursor.fetchall())
        except:
            sqlResult = "Invalid SQL"

        logging.debug("Result of running SQL: " + sqlResult)

        messageHistory.append(
            {
                "role": "system",
                "content": "Here is the result of running the sql query against the database: "
                + sqlResult,
            }
        )

        messageHistory.append(
            {
                "role": "assistant",
                "content": "Here is answer to your question in plain english",
            }
        )

        completion = client.chat.completions.create(
            model="gpt-4o-mini", messages=messageHistory
        )

        logging.debug(completion)

        answer = completion.choices[0].message.content

        print(answer)


def get_contex(cursor: sqlite3.Cursor):
    cursor.execute("SELECT sql FROM sqlite_master WHERE type='table';")
    schemas = cursor.fetchall()
    context = ""
    for schema in schemas:
        context = context + schema[0] + "\n"
    messages = [{"role": "system", "content": context.replace("\r\n", "\n")}]

    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()

    # Dictionary to store the first two rows of each table
    table_data = {}

    for table in tables:
        table_name = table[0]
        cursor.execute(f"SELECT * FROM {table_name} LIMIT 2;")
        rows = cursor.fetchall()
        table_data[table_name] = rows

    messages.append(
        {
            "role": "system",
            "content": "Here is example data from each of the tables in the database: "
            + str(table_data),
        }
    )

    return messages


if __name__ == "__main__":
    main()
