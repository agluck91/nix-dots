import json
import os
import subprocess
import sys

CONFIG_DIR = os.path.expanduser("~/.config/snapshot-ws")
if not os.path.exists(CONFIG_DIR):
    os.makedirs(CONFIG_DIR)

# Set default config file name
config_file = "default.json"

# Check if a custom config name is passed as an argument
if len(sys.argv) > 1:
    config_file = sys.argv[1] + ".json"

config_path = os.path.join(CONFIG_DIR, config_file)


def run_command(command):
    """Runs a shell command and returns the output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()


def snapshot_workspaces():
    """Snapshots the current workspace layout and saves it to a JSON file."""
    layout = {}

    # Loop through workspaces 1 to 5
    for ws in range(1, 6):
        windows = run_command(f"hyprctl clients -j")
        workspace_apps = []

        for window in json.loads(windows):
            if (
                window.get("workspace", {}).get("id") == ws
            ):  # Check if the window is in the current workspace
                app_info = {
                    "app_name": window["class"],
                    "title": window["title"],
                    "position": {"x": window["at"][0], "y": window["at"][1]},
                    "size": {"width": window["size"][0], "height": window["size"][1]},
                    "floating": window["floating"],
                    "fullscreen": window["fullscreen"],
                }
                workspace_apps.append(app_info)

        layout[str(ws)] = workspace_apps

    # Save the layout to the specified config file
    with open(config_path, "w") as f:
        json.dump(layout, f, indent=4)

    print(f"Snapshot saved to {config_path}")


# Take a snapshot of the workspaces and save to the file
snapshot_workspaces()
