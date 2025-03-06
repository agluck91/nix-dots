import subprocess


def run_command(command):
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()


def move_all_workspaces_to_monitor(target_monitor):
    workspaces = run_command(
        "hyprctl workspaces | grep ^workspace | cut -d ' ' -f 3"
    ).split("\n")
    for workspace in workspaces:
        if workspace:
            subprocess.run(
                f"hyprctl dispatch moveworkspacetomonitor {workspace} {target_monitor}",
                shell=True,
            )


def get_monitors():
    """Returns a list of active monitor names and identifies the internal monitor."""
    monitors = run_command("hyprctl monitors | awk '{print $2}'").split("\n")
    internal = next((m for m in monitors if m.startswith("eDP")), None)
    external = next((m for m in monitors if not m.startswith("eDP")), None)
    return internal, external, monitors


INTERNAL_MONITOR, EXTERNAL_MONITOR, active_monitors = get_monitors()
num_monitors = int(run_command("hyprctl monitors all | grep -c Monitor"))
num_monitors_active = len(active_monitors)

if not INTERNAL_MONITOR:
    print("No internal monitor detected!")
    exit(1)

if num_monitors_active >= 2 and INTERNAL_MONITOR in active_monitors:
    move_all_workspaces_to_monitor(EXTERNAL_MONITOR)
    subprocess.run(f"hyprctl keyword monitor {INTERNAL_MONITOR}, disable", shell=True)
else:
    if num_monitors > 1:
        if EXTERNAL_MONITOR and EXTERNAL_MONITOR in active_monitors:
            subprocess.run(
                f"hyprctl keyword monitor {INTERNAL_MONITOR},preferred,0x0,1",
                shell=True,
            )
            move_all_workspaces_to_monitor(INTERNAL_MONITOR)
            subprocess.run(
                f"hyprctl keyword monitor {EXTERNAL_MONITOR}, disable", shell=True
            )
        else:
            subprocess.run(
                f"hyprctl keyword monitor {EXTERNAL_MONITOR},preferred,0x0,1",
                shell=True,
            )
            move_all_workspaces_to_monitor(EXTERNAL_MONITOR)
            subprocess.run(
                f"hyprctl keyword monitor {INTERNAL_MONITOR}, disable", shell=True
            )
    else:
        subprocess.run(
            f"hyprctl keyword monitor {INTERNAL_MONITOR},preferred,0x0,1", shell=True
        )
        move_all_workspaces_to_monitor(INTERNAL_MONITOR)

subprocess.run("hyprctl dispatch workspace 1", shell=True)
