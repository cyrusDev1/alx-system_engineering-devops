#!/usr/bin/python3
"""Using what you did in the task #0, extend your Python script to export data in the CSV format.
"""
import requests
import sys
from csv import DictWriter, QUOTE_ALL


if __name__ == "__main__":
    id = sys.argv[1]
    url_user = "https://jsonplaceholder.typicode.com/users/{}".format(id)
    url_todo = "https://jsonplaceholder.typicode.com/todos"
    response_user = requests.get(url_user)
    response_todo = requests.get(url_todo)
    todo = response_todo.json()
    username = response_user.json().get("username")
    lines = []
    for dict in todo:
        if dict.get("userId") == int(id):
            task = {
                "USER_ID": id, "USERNAME": username,
                "TASK_COMPLETED_STATUS": dict.get("completed"),
                "TASK_TITLE": dict.get("title")}
            lines.append(task)
    with open("{}.csv".format(id), 'w', newline='') as f:
        header = ["USER_ID", "USERNAME", "TASK_COMPLETED_STATUS", "TASK_TITLE"]
        writer = DictWriter(f, fieldnames=header, quoting=QUOTE_ALL)
        writer.writerows(lines)
