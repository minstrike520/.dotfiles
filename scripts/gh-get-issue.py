#!/usr/bin/env python3
import json
import os
import subprocess
from pathlib import Path
import sys

# === ARGPARSE
import argparse
parser = argparse.ArgumentParser(description="利用 github-cli API 獲取指定 issue 的資料。例：`/get-issue.py openpubkey opkssh 346 -o ./out.json`")
parser.add_argument('author')
parser.add_argument('repo_name')
parser.add_argument('issue_id')
parser.add_argument("--output", "-o", help="output file")
args = parser.parse_args()
# /=== ARGPARSE

def gh_get_issue(author, repo_name, issue_id):
    # f'/repos/{author}/{repo_name}/issues/{issue_id}/comments'
    # gh api   -H "Accept: application/vnd.github+json"   -H "X-GitHub-Api-Version: 2022-11-28"   /repos/openpubkey/opkssh/issues/346/comments > input.json
    
    res = subprocess.run([
        'gh', 'api',
        '-H', 'Accept: application/vnd.github+json',
        '-H', 'X-GitHub-Api-Version: 2022-11-28',
        f'/repos/{author}/{repo_name}/issues/{issue_id}',
        ],
        capture_output=True,
        text=True)

    s = res.stdout

    res = subprocess.run([
        'gh', 'api',
        '-H', 'Accept: application/vnd.github+json',
        '-H', 'X-GitHub-Api-Version: 2022-11-28',
        f'/repos/{author}/{repo_name}/issues/{issue_id}/comments',
        ],
        capture_output=True,
        text=True)

    if res.returncode != 0:
        print('return code is not zero!')
        print(res.stderr)
        return None

    s += res.stdout

    return res.stdout


def transform_github_comments(input_str, output_path):
    # try:
    data = json.loads(input_str)

    # Transform each dictionary in the root array
    transformed_data = []
    for entry in data:
        new_entry = {
            # Extract 'login' from the nested 'user' object
            "author_name": entry.get("user", {}).get("login"),
            "body": entry.get("body")
        }
        transformed_data.append(new_entry)

    # Write the transformed data to the output path
    with open(output_path, 'w', encoding='utf-8') as outfile:
        json.dump(transformed_data, outfile, indent=4)
    
    print(f"Successfully transformed {len(transformed_data)} entries.")
    print(f"Output saved to: {output_path}")

    # except json.JSONDecodeError:
    #     print("Error: Failed to decode JSON. Check if the input file is formatted correctly.")
    # except Exception as e:
    #     print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    input_str = gh_get_issue(args.author, args.repo_name, args.issue_id)
    

    if args.output:
        output_path = Path(args.output)
    else:
        output_path = Path.cwd() / "output.json"
    
    transform_github_comments(input_str, output_path)
