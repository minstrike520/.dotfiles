#!/bin/python3

import subprocess
import argparse
import sys
import shutil
import os
from pathlib import Path
import json

# === COLOR_PRINT
COLOR_PRINT_DBG=True
def print_err(*args, **kwargs): print('\033[31m[Error] \033[0m', end=''); print(*args, **kwargs)
def print_info(*args, **kwargs): print('\033[32m[Info] \033[0m', end=''); print(*args, **kwargs)
def print_warn(*args, **kwargs): print('\033[33m[Warn] \033[0m', end=''); print(*args, **kwargs)
def print_dbg(*args, **kwargs):
    if not COLOR_PRINT_DBG: return
    print('\033[34m[DEBUG] \033[0m', end=''); print(*args, **kwargs)
# /=== COLOR_PRINT

BASE_DIR = Path.home()
STOW = Path.home() / '.dotfiles/stow'

with open(STOW / 'config.json', 'r') as file:
    config = json.loads(file.read())

parser = argparse.ArgumentParser()
parser.add_argument('-t', '--target', help='Specify package name')
parser.add_argument('-n', '--no-purge', action='store_true', help='Do not remove existing files')
parser.add_argument('-m', '--migrate', help='Migrate existing files into stow system')
args = parser.parse_args()

if args.migrate != None and args.target == None:
    print_err('`--migrate` must come with `--target`')
    print_err('Example:')
    print_err(f'  {sys.argv[0]} -t nvim -m .config/nvim/')
    exit(1)

if args.migrate != None and args.no_purge:
    print_err('Flag `--migrate` conflits with `--no-purge`')
    exit(1)

if args.migrate:
    migrate_target = Path(args.migrate)#.relative_to(BASE_DIR)
    (STOW / args.target / migrate_target.parent).mkdir(parents=True, exist_ok=True)
    # target=nvim
    # migrate=$HOME/.config/nvim
    # stow=$HOME/.dotfiles/stow/nvim/.config/nvim
    try:
       shutil.move(BASE_DIR / migrate_target, STOW / args.target / migrate_target.parent / '.')
    except FileNotFoundError as e:
        print_err(e)
        exit(1)

if args.target == None:
    print_err('Install-all is not yet implemented')
    print_err('Please specify `--target`')
    exit(1)

if not args.no_purge and args.migrate == None and config.get(args.target) != None:
    for rm_path in config[args.target]:
        rm_target = Path(rm_path)
        if not rm_target.exists():
            continue
        print_dbg('Removing : ' + rm_path)
        input('Confirm: ')
        if rm_target.is_symlink():
            os.remove(rm_target)
        else:
            shutil.rmtree(rm_target)
    
subprocess.run([ 'stow', '-d', str(STOW), '-t', str(BASE_DIR), args.target ])
