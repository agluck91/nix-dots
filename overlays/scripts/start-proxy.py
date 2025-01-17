import subprocess


def start_socks5_proxy(ssh_user, ssh_host, local_port=1080):
    try:
        command = [
            "ssh",
            "-N",  # Do not execute remote commands
            "-D",
            f"{local_port}",  # Set up dynamic port forwarding (SOCKS5)
            f"{ssh_user}@{ssh_host}",
        ]
        print(
            f"Starting SOCKS5 proxy on localhost:{local_port} through {ssh_user}@{ssh_host}"
        )
        subprocess.run(command)
    except KeyboardInterrupt:
        print("Proxy stopped by user.")
    except Exception as e:
        print(f"Error starting proxy: {e}")


# Example usage
if __name__ == "__main__":
    ssh_username = "agluck"
    ssh_host = "mac"
    start_socks5_proxy(ssh_username, ssh_host, local_port=5000)
