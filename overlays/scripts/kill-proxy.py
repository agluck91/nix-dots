import subprocess
import sys


def list_ssh_tunnels():
    """List all SSH tunnel processes (those with the '-D' flag), excluding sshd services."""
    try:
        # Get the list of all SSH processes with their details
        result = subprocess.run(
            ["ps", "aux"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True
        )
        ssh_tunnels = []

        for line in result.stdout.decode().splitlines():
            # Look for SSH processes with the '-D' flag (SOCKS5 proxy), but exclude 'sshd'
            if "ssh" in line and "-D" in line and "sshd" not in line:
                ssh_tunnels.append(line)

        if ssh_tunnels:
            print("\nRunning SSH Tunnels:")
            for idx, tunnel in enumerate(ssh_tunnels, 1):
                print(f"{idx}. {tunnel}")
        else:
            print("No SSH tunnels found.")

        return ssh_tunnels
    except subprocess.CalledProcessError as e:
        print(f"Error while listing SSH tunnels: {e}")
        return []


def kill_ssh_tunnel(tunnel_pid):
    """Kill the specified SSH tunnel process by PID."""
    try:
        subprocess.run(["kill", str(tunnel_pid)], check=True)
        print(f"SSH tunnel with PID {tunnel_pid} has been killed.")
    except subprocess.CalledProcessError as e:
        print(f"Error while killing SSH tunnel with PID {tunnel_pid}: {e}")


def main():
    ssh_tunnels = list_ssh_tunnels()

    if not ssh_tunnels:
        sys.exit(0)

    # Ask user if they want to kill one or all tunnels
    choice = (
        input("\nEnter the number of the tunnel to kill, or 'all' to kill all: ")
        .strip()
        .lower()
    )

    if choice == "all":
        for tunnel in ssh_tunnels:
            pid = int(
                tunnel.split()[1]
            )  # PID is the second column in the output of 'ps aux'
            kill_ssh_tunnel(pid)
    elif choice.isdigit() and 1 <= int(choice) <= len(ssh_tunnels):
        tunnel = ssh_tunnels[int(choice) - 1]
        pid = int(
            tunnel.split()[1]
        )  # PID is the second column in the output of 'ps aux'
        kill_ssh_tunnel(pid)
    else:
        print("Invalid choice. Exiting.")


if __name__ == "__main__":
    main()
