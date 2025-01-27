import argparse
import os
import socket
import subprocess
import sys
import time

# Define color codes
RED = "\033[0;31m"
GREEN = "\033[0;32m"
BLUE = "\033[0;34m"
CYAN = "\033[1;36m"
YELLOW = "\033[0;33m"
NC = "\033[0m"  # No color


def is_host_reachable(host, port=22, timeout=5, max_retries=10):
    attempt = 0
    while attempt < max_retries:
        if attempt == 0:
            print(f"{BLUE}[INFO] Checking if host {host} is reachable{NC}")
        else:
            print(
                f"{BLUE}[INFO] Checking if host {host} is reachable (Attempt {attempt + 1}){NC}"
            )
        try:
            sock = socket.create_connection((host, port), timeout=timeout)
            sock.close()
            print(f"{GREEN}[SUCCESS] Host {host} is reachable.{NC}")
            return True
        except (socket.timeout, socket.error):
            print(f"{RED}[ERROR] Host {host} is not reachable. Retrying...{NC}")
            attempt += 1
            time.sleep(2)

    print(f"{RED}[FATAL] Failed to reach host {host} after {max_retries} attempts.{NC}")
    return False


def is_port_bound(port):
    try:
        result = subprocess.run(
            ["ss", "-tuln"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
        )
        if f":{port} " in result.stdout.decode():
            return True
        return False
    except subprocess.CalledProcessError as e:
        print(f"{RED}[ERROR] Error checking port binding: {e}{NC}")
        return False


def start_socks5_proxy(ssh_user, ssh_host, local_port=1080):
    if not is_host_reachable(ssh_host):
        sys.exit(1)

    if is_port_bound(local_port):
        print(f"{RED}[ERROR] Port {local_port} is already bound. Exiting.{NC}")
        sys.exit(1)

    try:
        command = [
            "ssh",
            "-N",
            "-D",
            f"{local_port}",
            f"{ssh_user}@{ssh_host}",
        ]
        print(
            f"{BLUE}[INFO] Starting Proxy: {CYAN}[localhost:{local_port} => {ssh_user}@{ssh_host}]{NC}"
        )

        process = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            preexec_fn=os.setpgrp,
        )

        print(f"{YELLOW}[WAITING] Proxy service started. Checking connection...{NC}")

        time.sleep(5)

        if process.poll() is None:
            process.stdout.close()
            process.stderr.close()
            print(f"{GREEN}[SUCCESS] Proxy started successfully!{NC}")
            return process
        else:
            stdout, stderr = process.communicate()
            print(f"{RED}[FATAL] {stderr.decode()}{NC}")
            sys.exit(1)

    except KeyboardInterrupt:
        print(f"{RED}[ERROR] Proxy stopped by user.{NC}")
        sys.exit(1)
    except subprocess.CalledProcessError as e:
        print(f"{RED}[ERROR] Error starting proxy: {e}{NC}")
        sys.exit(1)
    except Exception as e:
        print(f"{RED}[ERROR] Unexpected error: {e}{NC}")
        sys.exit(1)


if __name__ == "__main__":
    DEFAULT_SSH_USER = "agluck"
    DEFAULT_SSH_HOST = "mac"
    DEFAULT_PORT = 5000

    parser = argparse.ArgumentParser(
        description="Start an SSH SOCKS5 proxy.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--user",
        default=DEFAULT_SSH_USER,
        help=f"SSH username (default: {DEFAULT_SSH_USER})",
    )
    parser.add_argument(
        "--host",
        default=DEFAULT_SSH_HOST,
        help=f"SSH host (default: {DEFAULT_SSH_HOST})",
    )
    parser.add_argument(
        "--port", type=int, default=DEFAULT_PORT, help="Local port for SOCKS5 proxy"
    )
    parser.add_argument("--retries", type=int, default=3, help="Max number of retries")

    args = parser.parse_args()

    process = start_socks5_proxy(args.user, args.host, local_port=args.port)

    if process:
        print(
            f"{GREEN}[SUCCESS] Proxy is now running in the background. Exiting the script.\nUse 'kill-proxy' to stop the proxy.{NC}"
        )
        sys.exit(0)
    else:
        sys.exit(1)
