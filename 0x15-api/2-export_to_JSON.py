#!/usr/bin/python3
"""Using what you did in the task #0, extend your Python script to export
data in the json format.
"""
import json
import requests
import sys

if __name__ == "__main__":
    id = sys.argv[1]
    url_user = "https://jsonplaceholder.typicode.com/users/{}".format(id)
    url_todo = "https://jsonplaceholder.typicode.com/todos"
    response_user = requests.get(url_user)
    response_todo = requests.get(url_todo)
    todo = response_todo.json()
    username = response_user.json().get("username")
    tasks = []
    for dict in todo:
        if dict.get("userId") == int(id):
            dict_ = {
                "task": dict.get("title"), "completed": dict.get("completed"),
                "username": username}
            tasks.append(dict_)
    with open("{}.json".format(id), 'w') as f:
        json.dump({id: tasks}, f)
