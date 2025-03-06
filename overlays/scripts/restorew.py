import json
import os
import subprocess
import time

CONFIG_DIR = os.path.expanduser("~/.config/snapshot-ws")
config_file = "default.json"
config_path = os.path.join(CONFIG_DIR, config_file)


# Load the snapshot layout
def load_snapshot():
    """Load the saved workspace snapshot from the JSON file."""
    with open(config_path, "r") as f:
        return json.load(f)


# Run a shell command and return the output
def run_command(command):
    """Runs a shell command and returns the output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()


# Open application using its class name (app_name) if not already open
def open_application(app_name):
    """Opens the application if not already running."""
    # Check if the app is already running
    running_apps = run_command("pgrep -f {}".format(app_name))
    if not running_apps:
        print(f"Opening {app_name}...")
        subprocess.Popen([app_name])


# Restore the window layout for each workspace
def restore_layout(snapshot):
    """Restore the window layout from the snapshot."""
    for workspace, windows in snapshot.items():
        print(f"Restoring workspace {workspace}...")
        for window in windows:
            app_name = window["app_name"]
            title = window.get("title", "")
            position = window["position"]
            size = window["size"]
            floating = window["floating"]
            fullscreen = window["fullscreen"]

            # Open the application
            open_application(app_name)

            # Ensure the app is open before trying to move and resize it
            time.sleep(1)

            # Restore window position and size using `hyprctl`
            # Set the window position
            move_command = (
                f"hyprctl window move {app_name} {position['x']} {position['y']}"
            )
            run_command(move_command)

            # Set the window size
            resize_command = (
                f"hyprctl window resize {app_name} {size['width']} {size['height']}"
            )
            run_command(resize_command)

            # Handle floating and fullscreen
            if floating:
                float_command = f"hyprctl window togglefloating {app_name}"
                run_command(float_command)

            if fullscreen:
                fullscreen_command = f"hyprctl window fullscreen {app_name}"
                run_command(fullscreen_command)

            print(f"Restored window: {app_name} (Title: {title})")


# Main function
def main():
    """Main function to load and restore the layout."""
    snapshot = load_snapshot()
    restore_layout(snapshot)


if __name__ == "__main__":
    main()
