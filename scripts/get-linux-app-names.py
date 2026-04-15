#!/usr/bin/env python3
import csv
import os
import configparser



def get_display_name(app_id):
    # Common paths for desktop files on Arch
    search_paths = [
        os.path.expanduser("~/.local/share/applications"),
        "/usr/share/applications",
    ]
    
    # Standard IDs usually map to "id.desktop"
    # Some IDs like 'code' or 'kitty' are just the binary name
    potential_filenames = [f"{app_id}.desktop", f"{app_id.lower()}.desktop"]
    
    for path in search_paths:
        for filename in potential_filenames:
            full_path = os.path.join(path, filename)
            if os.path.exists(full_path):
                config = configparser.ConfigParser(interpolation=None)
                try:
                    # .desktop files follow INI structure
                    config.read(full_path, encoding='utf-8')
                    if 'Desktop Entry' in config:
                        return config['Desktop Entry'].get('Name', app_id)
                except Exception:
                    continue
                    
    return app_id  # Fallback to ID if not found

# Example usage with your list:
# app_ids = ["org.kde.dolphin", "google-chrome-unstable", "kitty", "org.kde.kate"]
# for aid in app_ids:
#     print(f"{aid} -> {get_display_name(aid)}")

application_ids = set()

try:
    with open('raw.csv', mode='r', newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        
        for row in reader:
            if len(row) >= 3:
                app_id = row[2].strip()
                
                application_ids.add(app_id)

    print(f"Found {len(application_ids)} unique applications:")
    for id in sorted(application_ids):
        print(f"- {id} -> {get_display_name(id)}")

except FileNotFoundError:
    print("Error: The file 'raw.csv' was not found.")
