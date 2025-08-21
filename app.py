import os
import subprocess
from database import get_user_by_name
from secrets import API_KEY
from utils import deserialize_user

def main():
    print("API Key (hardcoded secret):", API_KEY)

    username = input("Enter username to lookup: ")
    user = get_user_by_name(username)
    print(f"User data: {user}")

    serialized = input("Enter serialized user data: ")
    user_obj = deserialize_user(serialized)
    print(f"Deserialized user: {user_obj}")

    cmd = input("Enter directory to list: ")
    os.system(f"ls {cmd}")

if __name__ == "__main__":
    main()
