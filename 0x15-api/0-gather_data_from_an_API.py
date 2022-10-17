#!/usr/bin/python3
"""
Write a Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""


if __name__ == "__main__":
	import requests
	import sys
	id = sys.argv[1]
	url_user = "https://jsonplaceholder.typicode.com/users/{}".format(id)
	url_todo = "https://jsonplaceholder.typicode.com/todos"
	response_user = requests.get(url_user)
	response_todo = requests.get(url_todo)
	todo = response_todo.json()
	name = response_user.json().get("name")
	total = 0
	do = 0
	titles = []
	for dict in todo:
		if dict.get("userId") == int(id):
			if dict.get("completed") is True:
				do += 1
				titles.append(dict.get("title"))
			total += 1
	print("Employee {} is done with tasks({}/{})".format(name, do, total))
	for title in titles:
		print(f"	 {title}")
