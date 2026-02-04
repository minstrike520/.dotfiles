#!/usr/bin/env python3

import re
import subprocess
import tempfile
import os
import json

def print_err(*args, **kwargs): print('\033[31m[Error] \033[0m', end=''); print(*args, **kwargs)
def print_info(*args, **kwargs): print('\033[32m[Info] \033[0m', end=''); print(*args, **kwargs)


def sub(input_path, pattern_name, output_path=None, modify_self=False):
    with open('patterns.json', 'r') as file:
        patterns = json.loads(file.read())

    with open(input_path, 'r', encoding='utf-8') as inp_file:
        inp_str = inp_file.read()

    pattern = patterns[pattern_name]
    if pattern['type'] == 'sub':
        target = pattern['target']
        replacement = pattern['replacement']
    elif pattern['type'] == 'exp':
        target = f'# EXP {pattern_name}'
        replacement = pattern['content']

    _res = re.subn(
        target,
        replacement,
        inp_str)

    if _res[1] == 0:
        print_info('No substitutions are made, exiting.')
        exit(0)

    res = _res[0]

    with tempfile.NamedTemporaryFile(mode='w+t', delete=False, suffix=os.path.splitext(input_path)[1]) as temp:
        temp.write(res)

    try:
        subprocess.run([ 'git', 'diff', '--no-index', input_path, temp.name ])
    finally:
        os.remove(temp.name)

    if modify_self:
        print_info('Mode: self-modify')
    else:
        print_info(f'Mode: write -> {output_path}')

    try:
        input('confirm patch? ')
    except KeyboardInterrupt:
        print()
        print_info('Terminating')
        return 130

    if modify_self:
        output_path = input_path
    else:
        output_path = output_path

    print_info("Writing file")

    with open(output_path, 'w', encoding='utf-8') as out_file:
        out_file.write(res)

    print_info("Done")
    return 0


def main():
    # === ARGPARSE
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('input_path')
    parser.add_argument('pattern_name')
    parser.add_argument('--output', '-o')
    parser.add_argument("--modify-self", "-m", action='store_true')
    args = parser.parse_args()

    if args.output == None and not args.modify_self:
        print_err('You should follow flag existence as XOR(--output, --modify-self)')
        exit(1)

    if args.output != None and args.modify_self:
        print_err('You should follow flag existence as XOR(--output, --modify-self)')
        exit(1)
    # /=== ARGPARSE

    exit(sub(args.input_path, args.pattern_name, args.output, args.modify_self))

if __name__ == "__main__":
    main()
