#!/usr/bin/env python3

import os
import sys
from github import Github

MAX_OWNERS = 3

def get_owner_count(org_name, repo_name, token):
    g = Github(token)
    repo = g.get_repo(f"{org_name}/{repo_name}")
    owners = [c for c in repo.get_collaborators(permission='admin')]
    return len(owners), [c.login for c in owners]

def main():
    token = os.getenv("GITHUB_TOKEN")
    if not token:
        print("GITHUB_TOKEN not set", file=sys.stderr)
        sys.exit(2)
    repo_full = os.getenv("GITHUB_REPOSITORY", "")
    if "/" not in repo_full:
        print("GITHUB_REPOSITORY not set or invalid", file=sys.stderr)
        sys.exit(2)
    org, repo = repo_full.split("/", 1)
    count, owners = get_owner_count(org, repo, token)
    if count > MAX_OWNERS:
        print(f"Error: Found {count} owners {owners}. Maximum allowed is {MAX_OWNERS}.", file=sys.stderr)
        sys.exit(1)
    print(f"Owner count {count} within limit.")
    sys.exit(0)

if __name__ == "__main__":
    main()
