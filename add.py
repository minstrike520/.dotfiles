#!/usr/bin/env python3

# import re
import json

def print_err(*args, **kwargs): print('\033[31m[Error] \033[0m', end=''); print(*args, **kwargs) 


def parse_range(range_str):
    r = range_str.split(':')

    if len(r) != 2:
        return None
    
    if r[0].isdigit() and r[1].isdigit():
        return (int(r[0]), int(r[1]))
    else:
        return None


# Default: store the whole file
def add(input_path, pattern_name, range_str=None):
    if range_str != None:
        range = parse_range(range_str)
    
        if range == None:
            print_err(f'Invaild range specification: {range_str}')
            return 1

    with open('patterns.json', 'r', encoding='utf-8') as file:
        patterns = json.loads(file.read())

    if patterns.get(pattern_name):
        print_err(f'Pattern with name `{pattern_name}` already exists:')
        print(patterns.get(pattern_name).__str__(), end='')
        return 1

    new_pattern_lines = []
    
    with open(input_path, 'r') as file:
        for i, line in enumerate(file.readlines()):
            if range_str == None or (i + 1 >= range[0] and i + 1 <= range[1]):
                new_pattern_lines.append(line)

    new_pattern = ''.join(new_pattern_lines)

    patterns[pattern_name] = {
        "type": "exp",
        "content": new_pattern
    }
    
    with open('patterns.json', 'w', encoding='utf-8') as file:
        json.dump(patterns, file, indent=4)

# Example:
# ./add source.txt 11:18 my-pattern
def main():
    # === ARGPARSE
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('input_path')
    parser.add_argument('pattern_name')
    parser.add_argument('--range')
    args = parser.parse_args()
    # /=== ARGPARSE

    exit(add(args.input_path, args.pattern_name, args.range))

if __name__ == "__main__":
    main()
# EXP py.ifmain
