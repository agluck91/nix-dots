import argparse
import subprocess
import time


def start_socks5_proxy(ssh_user, ssh_host, local_port=5000, max_retries=10):
    attempt = 0
    while attempt < max_retries:
        try:
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
            subprocess.run(command, check=True)
            break  # Exit loop if successful
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
    DEFAULT_LOCAL_PORT = 5000

    parser = argparse.ArgumentParser(
        description="Start an SSH SOCKS5 proxy.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--ssh_user",
        default=DEFAULT_SSH_USER,
        help=f"SSH username (default: {DEFAULT_SSH_USER})",
    )
    parser.add_argument(
        "--ssh_host",
        default=DEFAULT_SSH_HOST,
        help=f"SSH host (default: {DEFAULT_SSH_HOST})",
    )
    parser.add_argument(
        "--port",
        type=int,
        default=DEFAULT_LOCAL_PORT,
        help="Local port for SOCKS5 proxy",
    )
    parser.add_argument("--retries", type=int, default=10, help="Max number of retries")
    parser.add_argument(
        "-h", "--help", action="help", help="Show this help message and exit"
    )

    args = parser.parse_args()

    start_socks5_proxy(
        args.ssh_user, args.ssh_host, local_port=args.port, max_retries=args.retries
    )
