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


INTERNAL_MONITOR = "eDP-1"
EXTERNAL_MONITOR = "HDMI-A-1"

num_monitors = int(run_command("hyprctl monitors all | grep -c Monitor"))
num_monitors_active = int(run_command("hyprctl monitors | grep -c Monitor"))

active_monitors = run_command("hyprctl monitors | cut -d ' ' -f 2").split("\n")

if num_monitors_active >= 2 and INTERNAL_MONITOR in active_monitors:
    move_all_workspaces_to_monitor(EXTERNAL_MONITOR)
    subprocess.run(f"hyprctl keyword monitor {INTERNAL_MONITOR}, disable", shell=True)
else:
    if num_monitors > 1:
        if EXTERNAL_MONITOR in active_monitors:
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
