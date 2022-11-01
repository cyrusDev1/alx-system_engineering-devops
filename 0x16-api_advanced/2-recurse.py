#!/usr/bin/python3
"""Write a function that queries the Reddit API and prints the titles
of the first 10 hot posts listed for a given subreddit."""
import requests


def recurse(subreddit, hot_list=[], after=""):
    """Print first 10 hot posts listed for a given subreddit"""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "cyrusDev@alx-holbertonschool"
    }
    params = {
        "limit": 100,
        "after": after
    }
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code == 404:
        return None
    after = response.json().get("data").get("after")
    posts = response.json().get("data").get("children")
    for post in posts:
        hot_list.append(post.get("data").get("title"))
    if after is not None:
        recurse(subreddit, hot_list, after)
    return hot_list
