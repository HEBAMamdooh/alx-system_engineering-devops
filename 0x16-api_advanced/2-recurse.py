#!/usr/bin/python3
"""
This module contains a recursive function that queries the Reddit API
and returns a list containing the titles of all hot articles for a given
subreddit.
"""

import requests


def recurse(subreddit, hot_list=[], after="", count=0):
    """
    Queries the Reddit API recursively to get titles of all hot articles
    for a given subreddit.
    Args:
        subreddit (str): The name of the subreddit to query.
        hot_list (list): A list to accumulate the titles of hot articles.
        after (str): The parameter used for pagination (optional).
    Returns:
        list: A list of titles of hot articles or None if the subreddit is
        invalid.
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {'limit': 100, 'after': after}

    response = requests.get(url, headers=headers,
                            params=params, allow_redirects=False)

    if response.status_code != 200:
        return None

    data = response.json().get('data')
    if not data:
        return None

    hot_list.extend([child['data']['title'] for child in data['children']])

    after = data.get('after')
    if after:
        return recurse(subreddit, hot_list, after)
    return hot_list
