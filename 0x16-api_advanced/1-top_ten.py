#!/usr/bin/python3
"""Write a function that queries the Reddit API and prints the titles
of the first 10 hot posts listed for a given subreddit."""
import requests


def top_ten(subreddit):
    """print first 10 hot posts listed for a given subreddit"""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "cyrusDev@alx-holbertonschool"
    }
    params = {
        "limit": 1
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 404:
        print("None")
        return
    posts = response.json().get("data").get("children")
    for post in posts:
        print(post.get("data").get("title"))
