import subprocess
import sys

# Define color codes
RED = "\033[0;31m"
GREEN = "\033[0;32m"
BLUE = "\033[0;34m"
YELLOW = "\033[0;33m"
LIGHT_BLUE = "\033[1;36m"
NC = "\033[0m"  # No color


def list_ssh_tunnels():
    try:
        result = subprocess.run(
            ["ps", "aux"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True
        )
        ssh_tunnels = []

        for line in result.stdout.decode().splitlines():
            # Look for SSH processes with the '-D' flag (SOCKS5 proxy), but exclude 'sshd'
            if "ssh" in line and "-D" in line and "sshd" not in line:
                parts = line.split()
                command = " ".join(parts[10:])  # Full SSH command
                pid = parts[1]
                port = None
                destination = None

                # Extract port and destination from the command
                if "-D" in command:
                    try:
                        port_index = command.split().index("-D") + 1
                        port = command.split()[port_index]
                    except IndexError:
                        port = "Unknown"
                if "@" in command:
                    destination = command.split("@")[-1]

                ssh_tunnels.append(
                    {"pid": pid, "port": port, "destination": destination}
                )

        if ssh_tunnels:
            print(f"\n{BLUE}SSH Tunnels:{NC}")
            print(
                f"{BLUE} ┌─────┬────────────────────┬──────────┐{NC}"
            )  # Table header border
            print(
                f"{BLUE} │ id  │ Destination        │ Port     │{NC}"
            )  # Table header row
            print(
                f"{BLUE} ├─────┼────────────────────┼──────────┤{NC}"
            )  # Table separator
            for idx, tunnel in enumerate(ssh_tunnels, 1):
                print(
                    f"{BLUE} │ {idx:<3} │ {tunnel['destination']:<18} │ {tunnel['port']:<8} │"
                )
            print(
                f"{BLUE} └─────┴────────────────────┴──────────┘{NC}"
            )  # Table bottom border
        else:
            print(f"{YELLOW}No SSH tunnels found.{NC}")

        return ssh_tunnels
    except subprocess.CalledProcessError as e:
        print(f"{RED}Error while listing SSH tunnels: {e}{NC}")
        return []


def kill_ssh_tunnel(tunnel_pid):
    try:
        subprocess.run(["kill", str(tunnel_pid)], check=True)
        print(f"{GREEN}SSH tunnel with PID {tunnel_pid} has been killed.{NC}")
    except subprocess.CalledProcessError as e:
        print(f"{RED}Error while killing SSH tunnel with PID {tunnel_pid}: {e}{NC}")


def main():
    while True:
        ssh_tunnels = list_ssh_tunnels()

        if not ssh_tunnels:
            sys.exit(0)

        # Ask user if they want to kill one or all tunnels or exit
        choice = (
            input(
                f"{YELLOW}\nEnter the number of the tunnel to kill, 'all' to kill all, or 'exit' to quit: {NC}"
            )
            .strip()
            .lower()
        )

        if choice == "exit":
            sys.exit(0)
        elif choice == "all":
            for tunnel in ssh_tunnels:
                pid = int(tunnel["pid"])
                kill_ssh_tunnel(pid)
        elif choice.isdigit() and 1 <= int(choice) <= len(ssh_tunnels):
            tunnel = ssh_tunnels[int(choice) - 1]
            pid = int(tunnel["pid"])
            kill_ssh_tunnel(pid)
        else:
            print(f"{RED}Invalid choice. Please try again.{NC}")


if __name__ == "__main__":
    main()
