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

# Manual mapping of command names to readable app names
COMMAND_MAPPING = {
    "com.mitchellh.ghostty": "ghostty",
    "teams-for-linux": "teams-for-linux",
    "Slack": "Slack",
    "google-chrome": "Google Chrome",
    # Add any other necessary mappings here
}


def run_command(command):
    """Runs a shell command and returns the output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()


def get_command_from_pid(pid):
    """Gets the command used to launch the process from its PID."""
    try:
        # Use ps to find the command from the PID
        command = run_command(f"ps -p {pid} -o comm=")
        return command.strip()
    except Exception as e:
        print(f"Error getting command for PID {pid}: {e}")
        return ""


def get_app_name(command):
    """Returns the mapped app name if available, or the command itself."""
    return COMMAND_MAPPING.get(command, command)


def snapshot_workspaces():
    """Snapshots the current workspace layout and saves it to a JSON file."""
    layout = {}

    # Run the `hyprctl clients -j` command to get all windows
    windows = run_command("hyprctl clients -j")
    window_data = json.loads(windows)

    # Loop through workspaces 1 to 5
    for ws in range(1, 6):
        workspace_apps = []

        # Loop through all windows and filter by workspace id
        for window in window_data:
            if "workspace" in window and window["workspace"]["id"] == ws:
                app_name = window["class"]
                pid = window.get("pid", None)  # Get the PID if available

                # Use PID to find the command if possible
                command = ""
                if pid:
                    command = get_command_from_pid(pid)

                # Use manual mapping to get readable app name
                app_name = get_app_name(command)

                app_info = {
                    "app_name": app_name,
                    "command": command,  # Save the dynamically fetched command
                    "title": window.get("title", ""),
                    "position": {"x": window["at"][0], "y": window["at"][1]},
                    "size": {"width": window["size"][0], "height": window["size"][1]},
                    "floating": window.get("floating", False),
                    "fullscreen": window.get("fullscreen", 0),
                }
                workspace_apps.append(app_info)

        layout[str(ws)] = workspace_apps

    # Save the layout to the specified config file
    with open(config_path, "w") as f:
        json.dump(layout, f, indent=4)

    print(f"Snapshot saved to {config_path}")


# Take a snapshot of the workspaces and save to the file
snapshot_workspaces()
