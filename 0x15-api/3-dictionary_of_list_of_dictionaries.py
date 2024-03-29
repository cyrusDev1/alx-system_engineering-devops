#!/usr/bin/python3
"""Using what you did in the task #0, extend your Python script to export
data in the json format.
"""
import json
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com"
    url_user = url + "/users"
    users = requests.get(url_user).json()
    data = {}
    for user in users:
        id = user.get('id')
        url_todo = url + "/users/{}/todos".format(id)
        response_todo = requests.get(url_todo)
        todo = response_todo.json()
        tasks = []
        for task in todo:
            username = user.get("username")
            dict_ = {
                "username": username, "task": task.get("title"),
                "completed": task.get("completed")}
            tasks.append(dict_)
        data[id] = tasks
    with open("todo_all_employees.json", 'w') as f:
        json.dump(data, f)
