import argparse
import os
import socket
import subprocess
import sys
import time


def is_host_reachable(host, port=22, timeout=5):
    """Check if the host is reachable on the specified port."""
    try:
        sock = socket.create_connection((host, port), timeout=timeout)
        sock.close()
        return True
    except (socket.timeout, socket.error):
        return False


def is_port_bound(port):
    """Check if the local port is already bound."""
    # Using 'ss' to check if the port is bound, could also use 'lsof' if preferred
    try:
        result = subprocess.run(
            ["ss", "-tuln"],  # List TCP/UDP ports in use
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
        )
        # Check if the port is in the result
        if f":{port} " in result.stdout.decode():
            return True
        return False
    except subprocess.CalledProcessError as e:
        print(f"Error checking port binding: {e}")
        return False


def start_socks5_proxy(ssh_user, ssh_host, local_port=1080, max_retries=10):
    attempt = 0
    while attempt < max_retries:
        # Check if the host is reachable before starting the proxy
        if not is_host_reachable(ssh_host):
            print(f"Host {ssh_host} is not reachable. Retrying...")
            attempt += 1
            time.sleep(2)
            continue

        # Check if the port is already bound
        if is_port_bound(local_port):
            print(f"Error: Port {local_port} is already bound. Exiting.")
            sys.exit(1)

        try:
            # Start the SSH command to create the SOCKS5 proxy
            command = [
                "ssh",
                "-N",  # Do not execute remote commands
                "-D",
                f"{local_port}",  # Set up dynamic port forwarding (SOCKS5)
                f"{ssh_user}@{ssh_host}",
            ]
            print(
                f"Starting SOCKS5 proxy on localhost:{local_port} through {ssh_user}@{ssh_host} (Attempt {attempt + 1})"
            )

            # Try to establish the proxy connection (capture output to check for success)
            process = subprocess.Popen(
                command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                preexec_fn=os.setpgrp,
            )

            # Wait a few seconds to ensure the connection is established
            time.sleep(3)

            # Check if the process is running
            if process.poll() is None:
                print("Proxy is running in the background.")
                process.stdout.close()
                process.stderr.close()
                return process
            else:
                stdout, stderr = process.communicate()
                print(f"Error: {stderr.decode()}")
                attempt += 1
                time.sleep(2)  # Wait before retrying

        except KeyboardInterrupt:
            print("Proxy stopped by user.")
            break
        except subprocess.CalledProcessError as e:
            print(f"Error starting proxy: {e}. Retrying...")
            attempt += 1
            time.sleep(2)  # Wait before retrying
        except Exception as e:
            print(f"Unexpected error: {e}. Retrying...")
            attempt += 1
            time.sleep(2)
    else:
        print("Failed to start the SOCKS5 proxy after multiple attempts.")


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

    process = start_socks5_proxy(
        args.user, args.host, local_port=args.port, max_retries=args.retries
    )

    if process:
        # After successful connection, we can background the process
        print("Proxy is running. Exiting the app.")
        sys.exit(0)
    else:
        sys.exit(1)
