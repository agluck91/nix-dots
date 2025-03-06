import subprocess
import time

# Define applications and their target workspaces
APPS = {
    "google-chrome-stable": 1,
    "ghostty": 2,
    "Slack": 4,
    "teams-for-linux": 4,
}


def run_command(command):
    """Runs a shell command and returns the output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()


def launch_and_move(app, workspace):
    """Launches an app and moves it to the specified workspace."""
    subprocess.Popen(app, shell=True)  # Start the app without waiting
    time.sleep(2)  # Give the app some time to launch

    # Get the window class name for the app
    windows = run_command("hyprctl clients -j")

    if app in windows:
        subprocess.run(
            f"hyprctl dispatch movetoworkspace {workspace},class:{app}", shell=True
        )


# Loop through applications and assign them to workspaces
for app, workspace in APPS.items():
    launch_and_move(app, workspace)

# Switch to workspace 1 when done
subprocess.run("hyprctl dispatch workspace 2", shell=True)
